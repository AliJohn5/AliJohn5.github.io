import 'package:flutter/material.dart';
import 'package:login_template/auth/components/custom_input.dart';
import 'package:login_template/auth/screens/forget_password_screen.dart';
import 'package:login_template/auth/screens/login_screen.dart';
import 'package:login_template/auth/services/loading_service.dart';
import 'package:login_template/auth/services/login_service.dart';
import 'package:login_template/auth/services/show_message_service.dart';
import 'package:login_template/l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.email});

  final String email;
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Directionality(
                  textDirection: Directionality.of(context),

                child: SizedBox(
                  height: 300, // give the stack a size
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/login/cover_signup.png',
                          fit: BoxFit.cover,
                          matchTextDirection: true,
                        ),
                      ),
                
                      // Text
                      Positioned(
                        bottom: 5,
                         left: Directionality.of(context) == TextDirection.ltr
                            ? 30
                            : null,
                        right: Directionality.of(context) == TextDirection.ltr
                            ? null
                            : 15,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.resetPass,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                
                            Container(
                              width: 120,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                key: _formKey,
                child: Column(
                  children: [
                    CustomInput(
                      label: tr.myCode,
                      helpingText: tr.myCodeDes,
                      controller: codeController,
                      firstImagePath: "assets/login/password.png",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr.myCodeEmpty;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomInput(
                      label: tr.password,
                      helpingText: tr.passwordDes,
                      controller: passwordController,
                      firstImagePath: "assets/login/password.png",
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr.emptyPassword;
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomInput(
                      label: tr.confirmPassword,
                      helpingText: tr.confirmPasswordDes,
                      controller: confirmPasswordController,
                      firstImagePath: "assets/login/password.png",
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr.emptyPassword;
                        }

                        if (value != passwordController.text) {
                          return tr.passwordNotSame;
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      if (!context.mounted) return;
                      showMessage(
                        context,
                        tr.fillData,
                      );
                      return;
                    }

                    bool isLoading = true;
                    showLoadingDialog(context);

                    try {
                      final res = await changePassword(
                        widget.email,
                        passwordController.text.trim(),
                        codeController.text.trim(),
                      );

                      if (!context.mounted) return;
                      hideLoadingDialog(context);
                      isLoading = false;

                      if (res['status'] == "success") {
                        if (!context.mounted) return;
                        showMessage(
                          context,
                          res['message']
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } else {
                        if (!context.mounted) return;
                        showMessage(context, res['message']);
                      }
                    } catch (e) {
                      if (isLoading) {
                        if (!context.mounted) return;
                        hideLoadingDialog(context);
                        isLoading = false;
                      }
                      if (!context.mounted) return;
                      showMessage(context, null);
                    }

                    if (isLoading) {
                      if (!context.mounted) return;
                      hideLoadingDialog(context);
                      isLoading = false;
                    }
                  },

                  child: Text(tr.resetPass),
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.center,

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 4.0,
                        top: 8.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        tr.myCodeLost,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 5.0),
                        child: Text(
                          tr.sendAgain,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),


              Align(
                alignment: Alignment.center,

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 4.0,
                        top: 8.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        tr.remmemberPassword,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 5.0),
                        child: Text(
                          tr.login,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
