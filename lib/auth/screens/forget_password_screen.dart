import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_template/auth/components/custom_input.dart';
import 'package:login_template/auth/services/loading_service.dart';
import 'package:login_template/auth/services/login_service.dart';
import 'package:login_template/auth/services/show_message_service.dart';
import 'package:login_template/l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
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
                  height: 425, // give the stack a size
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/login/cover.png',
                          fit: BoxFit.cover,
                          matchTextDirection: true,
                        ),
                      ),
                
                      // Text
                      Positioned(
                        bottom: 5,
                        left: Directionality.of(context) == TextDirection.ltr
                            ? 20
                            : null,
                        right: Directionality.of(context) == TextDirection.ltr
                            ? null
                            : 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.fogetIt,
                              maxLines: 3,
                              
                              style: TextStyle(
                                fontSize: 35,
                              
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                
                            Container(
                              width: 100,
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

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tr.emailDesCode,
                  style:  TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      final res = await forgetPassword(
                        emailController.text.trim(),
                      );

                      if (!context.mounted) return;
                      hideLoadingDialog(context);
                      isLoading = false;

                      if (res['status'] == "success") {
                        if (!context.mounted) return;
                        showMessage(context, res['message']);

                        context.go('/change-password?email=${emailController.text.trim()}');

                      } else {
                        if (!context.mounted) return;
                        showMessage(context, res['message']);
                      }
                    } catch (e) {
                      if (isLoading) {
                        if (!context.mounted) return;
                        showLoadingDialog(context);
                        isLoading = false;
                      }
                      if (!context.mounted) return;
                      showMessage(context, null);
                    }

                    if (isLoading) {
                      if (!context.mounted) return;
                      showLoadingDialog(context);
                      isLoading = false;
                    }
                  },

                  child: Text(tr.sendCode),
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
