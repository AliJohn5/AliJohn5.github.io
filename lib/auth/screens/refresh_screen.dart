import 'package:flutter/material.dart';
import 'package:login_template/auth/screens/login_screen.dart';
import 'package:login_template/auth/services/loading_service.dart';
import 'package:login_template/auth/services/login_service.dart';
import 'package:login_template/auth/services/logout_service.dart';
import 'package:login_template/auth/services/show_message_service.dart';
import 'package:login_template/home/home_screen.dart';
import 'package:login_template/l10n/app_localizations.dart';

class RefreshScreen extends StatefulWidget {
  const RefreshScreen({super.key});

  @override
  State<RefreshScreen> createState() => _RefreshScreenState();
}

class _RefreshScreenState extends State<RefreshScreen> {
  bool _called = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_called) {
      _called = true;
      _refreshToken();
    }
  }

  Future<void> _refreshToken() async {
    final tr = AppLocalizations.of(context)!;

    try {
      final res = await refreshUser();

      if (!mounted) return;

      if (res['status'] == "success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        showMessage(context, res['message']);
        await logoutUser();
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } catch (e) {
      if (!mounted) return;
      showMessage(context, tr.somethingWrongInternet);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) _refreshToken();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(child: SineWaveLoader()),
    );
  }
}
