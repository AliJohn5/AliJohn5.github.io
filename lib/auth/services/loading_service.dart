import 'dart:math';
import 'package:flutter/material.dart';
import 'package:login_template/l10n/app_localizations.dart';
void showLoadingDialog(BuildContext context) {
  final tr = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
       backgroundColor: Colors.transparent,

      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SineWaveLoader(),
            SizedBox(height: 20),
            Text(
              tr.brand,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 50,
                fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void hideLoadingDialog(BuildContext context) {
  if (!context.mounted) return;
  Navigator.pop(context);
}

class SineWaveLoader extends StatefulWidget {
  final double width;
  final double height;

  const SineWaveLoader({super.key, this.width = 150, this.height = 75});

  @override
  State<SineWaveLoader> createState() => _SineWaveLoaderState();
}

class _SineWaveLoaderState extends State<SineWaveLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> wave1Progress;
  late Animation<double> wave2Progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Wave 1: 0 → 1 in the first half
    wave1Progress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.linear),
    );

    // Wave 2: 0 → 1 in the second half
    wave2Progress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _DualWavePainter(
            wave1Progress: wave1Progress.value,
            wave2Progress: wave2Progress.value,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}

class _DualWavePainter extends CustomPainter {
  final double wave1Progress;
  final double wave2Progress;
  final Color color;

  _DualWavePainter({
    required this.wave1Progress,
    required this.wave2Progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paint2 = Paint()
      ..color = color.withValues(alpha: 175)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Wave 1
    _drawWave(
      canvas,
      size,
      paint1,
      wave1Progress,
      amplitude: size.height / 2,
      phase: 0,
    );

    // Wave 2 (starts after wave1 finishes)
    if (wave2Progress > 0) {
      _drawWave(
        canvas,
        size,
        paint2,
        wave2Progress,
        amplitude: size.height / 2,
        phase: pi,
        isSecond: true,
      );
    }
  }

  void _drawWave(
    Canvas canvas,
    Size size,
    Paint paint,
    double progress, {
    required double amplitude,
    required double phase,
    bool isSecond = false,
  }) {
    if (!isSecond) {
      // NORMAL: left → right
      final maxX = size.width * progress;
      final path = Path()..moveTo(0, size.height / 2);

      for (double x = 0; x <= maxX; x++) {
        double virtualX = x; // normal
        double y =
            size.height / 2 +
            sin((virtualX / size.width * 2 * pi) + phase) * amplitude;

        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
      return;
    }

    // SECOND WAVE: right → left, SAME SHAPE
    final minX = size.width * (1 - progress);

    final path = Path()..moveTo(size.width, size.height / 2);

    for (double drawX = size.width; drawX >= minX; drawX--) {
      double virtualX = drawX; // still increasing to keep wave orientation
      double y =
          size.height / 2 +
          sin((virtualX / size.width * 2 * pi) + phase) * amplitude;

      path.lineTo(drawX, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
