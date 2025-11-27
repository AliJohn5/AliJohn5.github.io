import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_template/auth/components/custom_input.dart';
import 'package:login_template/auth/services/loading_service.dart';
import 'package:login_template/auth/services/login_service.dart';
import 'package:login_template/auth/services/show_message_service.dart';
import 'package:login_template/l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
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
                            : 30,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.signup,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),

                            Container(
                              width: Directionality.of(context) ==
                                      TextDirection.ltr
                                  ? 120
                                  : 90,
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

              const SizedBox(height: 40),

              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                key: _formKey,
                child: Directionality(
                  textDirection: Directionality.of(context),
                  child: Column(
                    children: [
                      CustomInput(
                        label: tr.email,
                        helpingText: tr.emailDes,
                        controller: emailController,
                        firstImagePath: "assets/login/email.png",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr.invalidEmail;
                          }
                          if (!value.contains("@")) return tr.invalidEmail;
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
                      final res = await signUpUser(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (!context.mounted) return;
                      hideLoadingDialog(context);
                      isLoading = false;

                      if (res['status'] == "success") {
                        if (!context.mounted) return;
                        showMessage(
                          context,
                          res['message'],
                        );

                        context.go('/login');

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

                  child: Text(tr.signup),
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
                        tr.haveAccount,
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
                        context.go('/login');

                      },
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 30)

            ],
          ),
        ),
      ),
    );
  }
}
