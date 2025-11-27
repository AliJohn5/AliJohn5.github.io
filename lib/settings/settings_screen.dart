import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_template/auth/services/loading_service.dart';
import 'package:login_template/auth/services/logout_service.dart';
import 'package:login_template/l10n/app_localizations.dart';
import 'package:login_template/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLang(String s) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('appLocale', s);
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String currentLang = "en";

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    currentLang = prefs.getString('appLocale') ?? "en";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final secondary = Theme.of(context).colorScheme.secondary;
    final darkMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          tr.brand,
          style: TextStyle(color: secondary, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // ---------------- DARK MODE SWITCH ----------------
            SwitchListTile(
              title: Text(
                "Dark Mode",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              value: darkMode,
              activeThumbColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              },
            ),

            const Divider(height: 20),

            // ---------------- LANGUAGE DROPDOWN ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                tr.language,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(150),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: currentLang,
                  underline: const SizedBox(),
                  isExpanded: true,
                  iconEnabledColor: secondary,
                  dropdownColor: Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha(150),

                  items: const [
                    DropdownMenuItem(value: "en", child: Text("English")),
                    DropdownMenuItem(value: "ar", child: Text("العربية")),
                  ],

                  onChanged: (value) async {
                    if (value == null) return;

                    setState(() => currentLang = value);

                    if (value == "ar") {
                      MyApp.of(context).setLocale(const Locale('ar'));
                      await saveLang('ar');
                    } else {
                      MyApp.of(context).setLocale(const Locale('en'));
                      await saveLang('en');
                    }
                  },
                ),
              ),
            ),

            const Divider(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  showLoadingDialog(context);
                  await Future.delayed(const Duration(seconds: 5));

                  await logoutUser();
                  if (!context.mounted) return;

                  hideLoadingDialog(context);

                  if (!context.mounted) return;
                  context.go("/login");
                },
                child: Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const Divider(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  showLoadingDialog(context);
                  await Future.delayed(const Duration(seconds: 5));

                  if (!context.mounted) return;
                  hideLoadingDialog(context);
                },
                child: Text(
                  "Show loading",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
