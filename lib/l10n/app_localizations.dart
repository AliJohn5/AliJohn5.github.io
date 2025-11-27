import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Home label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Greeting
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Sign up button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// Login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Welcome title
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Welcome paragraph message
  ///
  /// In en, this message translates to:
  /// **'Welcome to our app! Get ready to explore a world of exciting features. Let us get started!'**
  String get welcomeMessage;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuenow;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailDes;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordDes;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgetPassword;

  /// Don’t have an account text
  ///
  /// In en, this message translates to:
  /// **'Do not have an Account?'**
  String get donthaveAccount;

  /// Invalid email message
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// Empty password message
  ///
  /// In en, this message translates to:
  /// **'Password can not be empty'**
  String get emptyPassword;

  /// Confirm password label
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Confirm password hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password again'**
  String get confirmPasswordDes;

  /// Already have an account text
  ///
  /// In en, this message translates to:
  /// **'Already have an Account'**
  String get haveAccount;

  /// Forgot password description
  ///
  /// In en, this message translates to:
  /// **'Enetr your email to send you a recovery code'**
  String get forgetPasswordDes;

  /// Send recovery code button
  ///
  /// In en, this message translates to:
  /// **'Send my code'**
  String get sendCode;

  /// Remember password text
  ///
  /// In en, this message translates to:
  /// **'Did you remmember it'**
  String get remmemberPassword;

  /// Reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetPass;

  /// Code label
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get myCode;

  /// Code input hint
  ///
  /// In en, this message translates to:
  /// **'Enetr your code'**
  String get myCodeDes;

  /// Send code again button
  ///
  /// In en, this message translates to:
  /// **'Send Again'**
  String get sendAgain;

  /// Send again description
  ///
  /// In en, this message translates to:
  /// **'You lost the code?'**
  String get sendAgainDes;

  /// Data validation message
  ///
  /// In en, this message translates to:
  /// **'Please fill your data correctly first.'**
  String get fillData;

  /// Welcome again message
  ///
  /// In en, this message translates to:
  /// **'Welcome Again.'**
  String get welcomeAgain;

  /// Password mismatch message
  ///
  /// In en, this message translates to:
  /// **'Passwords are not same'**
  String get passwordNotSame;

  /// Forget it button
  ///
  /// In en, this message translates to:
  /// **'Forget it?'**
  String get fogetIt;

  /// Email hint for code recovery
  ///
  /// In en, this message translates to:
  /// **'Enter your email to send you a recovery code.'**
  String get emailDesCode;

  /// Empty code message
  ///
  /// In en, this message translates to:
  /// **'Code can not be empty'**
  String get myCodeEmpty;

  /// Lost code message
  ///
  /// In en, this message translates to:
  /// **'You lost the code? '**
  String get myCodeLost;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, Try again.'**
  String get somethingWrong;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please check your connection.'**
  String get somethingWrongInternet;

  /// Brand label
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// Language label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
