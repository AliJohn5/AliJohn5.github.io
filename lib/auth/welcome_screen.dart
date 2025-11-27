import 'package:flutter/material.dart';
import 'package:login_template/auth/screens/login_screen.dart';
import 'package:login_template/l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Image.asset(
                'assets/welcome/cover.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 580,
                matchTextDirection: true,
              ),
            ),

            //SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  tr.welcome,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                tr.welcomeMessage,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            SizedBox(height: 50),

            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  // Navigate to Login Screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },

                child: Align(
                  alignment: Directionality.of(context) == TextDirection.rtl
                      ? Alignment
                            .centerLeft // English → left
                      : Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tr.continuenow,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Align(
                        child: SizedBox(
                          height: 50,
                          width: 50,

                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Image.asset(
                                  'assets/welcome/continue_icon.png',
                                  width: 50,
                                  height: 50,
                                  matchTextDirection:
                                      true, // auto-flip in Arabic
                                ),
                              ),

                              Positioned(
                                bottom: 11,
                                left:
                                    Directionality.of(context) ==
                                        TextDirection.ltr
                                    ? 15
                                    : null,
                                right:
                                    Directionality.of(context) ==
                                        TextDirection.rtl
                                    ? 15
                                    : null,
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 28,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
