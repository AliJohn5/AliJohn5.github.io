import 'dart:ui' as ui;

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login_template/auth/screens/refresh_screen.dart';
import 'package:login_template/auth/welcome_screen.dart';
import 'package:login_template/auth/services/login_service.dart';
import 'package:login_template/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> setInitialLocale() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  late String? locale;

  if (isFirstLaunch) {
    // Check system language
    Locale systemLocale = ui.PlatformDispatcher.instance.locale;
    if (systemLocale.languageCode == 'ar') {
      locale = 'ar';
    } else {
      locale = 'en';
    }

    await prefs.setBool('isFirstLaunch', false);
  } else {
    String? savedLang = prefs.getString('appLocale');
    if (savedLang != null) {
      locale = savedLang;
    } else {
      locale = savedLang;
    }
  }

  await prefs.setString('appLocale', locale!);

  return locale;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogedIn = await isUserLoggedIn();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final locale = await setInitialLocale();
  runApp(
    MyApp(
      isLogedIn: isLogedIn,
      savedThemeMode: savedThemeMode,
      localelang: locale ?? "en",
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.isLogedIn,
    this.savedThemeMode,
    required this.localelang,
  });
  final bool isLogedIn;
  final AdaptiveThemeMode? savedThemeMode;
  final String localelang;

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.localelang);
  }

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF532828),
          surface: const Color(0xFFFFFCFC),
          primary: const Color(0xFF532828),
          secondary: const Color(0xFFD48F8F),
          tertiary: const Color(0xFF291412),
          onPrimary: const Color(0xFFF8F8FF),
          onSecondary: const Color(0xFF291412),
          onSurface: const Color.fromARGB(190, 97, 97, 97),
        ),
        useMaterial3: true,
        fontFamily: 'Rubik',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFF532828)),
            elevation: WidgetStateProperty.all(6.0),
            fixedSize: WidgetStateProperty.all(
              Size(MediaQuery.widthOf(context) * 0.95, 50),
            ),
            foregroundColor: WidgetStateProperty.all(const Color(0xFFF8F8FF)),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontFamily: 'Rubik', // color: Color(0xFFF8F8FF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            overlayColor: WidgetStateProperty.all(
              const Color.fromARGB(78, 248, 248, 255),
            ),
            shadowColor: WidgetStateProperty.all(
              const Color.fromARGB(141, 97, 97, 97),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
        ),
      ),
      dark: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF532828),
          surface: Color(0xFF191312),
          primary: const Color(0xFF532828),
          secondary: const Color(0xFFD48F8F),
          tertiary: const Color(0xFF291412),
          onPrimary: const Color(0xFFF8F8FF),
          onSecondary: const Color(0xFF291412),
          onSurface: const Color(0xFFE7E3E3),
        ),

        useMaterial3: true,
        fontFamily: 'Rubik',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFF532828)),
            elevation: WidgetStateProperty.all(6.0),
            fixedSize: WidgetStateProperty.all(
              Size(MediaQuery.widthOf(context) * 0.95, 50),
            ),
            foregroundColor: WidgetStateProperty.all(const Color(0xFFF8F8FF)),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontFamily: 'Rubik',
                // color: Color(0xFFF8F8FF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            overlayColor: WidgetStateProperty.all(
              const Color.fromARGB(78, 248, 248, 255),
            ),
            shadowColor: WidgetStateProperty.all(
              const Color.fromARGB(141, 97, 97, 97),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
        ),
      ),

      debugShowFloatingThemeButton: true,
      initial: widget.savedThemeMode ?? AdaptiveThemeMode.system,

      builder: (theme, darkTheme) {
        return MaterialApp(
          title: 'Flutter Demo',

          locale: _locale,

          supportedLocales: const [Locale('en'), Locale('ar')],

          localizationsDelegates: const [
            AppLocalizations.delegate, // ✔ Our translations
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) return supportedLocales.first;
            for (var supported in supportedLocales) {
              if (supported.languageCode == locale.languageCode) {
                return supported;
              }
            }
            return supportedLocales.first;
          },

          theme: theme,
          darkTheme: darkTheme,

          home: widget.isLogedIn
              ? const RefreshScreen()
              : const WelcomeScreen(),
        );
      },
    );
  }
}
