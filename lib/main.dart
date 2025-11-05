import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyur_practicle/presentation/pages/choose_language_page.dart';
import 'package:keyur_practicle/presentation/pages/sign_up_page.dart';

import 'injections.dart';
import 'bloc/auth/auth_bloc.dart';
import 'data_impl/repositories/auth_repository_impl.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/home_page.dart';

// Simple map-based localization (easy to replace with ARB+intl)
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const Map<String, Map<String, String>> _t = {
    'en': {
      'appTitle': 'Clip Cuts',
      'login': 'Login',
      'choose_language': 'Choose Language',
      'welcome_back': 'Welcome Back',
      'hello_there': 'Hello there. sign in to continue',
      'choose_language_prefer': 'Choose language which you prefer',
      'continue': 'CONTINUE',
      'sign_up': 'Sign up',
      'sign_in': 'SIGN IN',
      'remember_me': 'Remember me',
      'forgot_password': 'Forgot password?',
      'email': 'Email',
      'password': 'Password',
      'enter_email': 'Please enter email',
      'enter_valid_email': 'Enter a valid email',
      'enter_password': 'Please enter password',
      'password_len': 'Password should be at least 6 characters',
      'logout': 'Logout',
      'logout_confirm': 'Are you sure you want to logout?',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'welcome': 'Welcome!',
      'dont_have_account': 'Don’t have an account?',
      'already_have_account': 'Already have an account?',
      "hi_welcome": "Hi welcome there",
      "create_account": "Please create your new account",
      "upload_profile": "Upload profile picture",
      "full_name": "Full Name",
      "enter_name": "Please enter your name",
      "email_address": "Email address",
      "invalid_email": "Please enter a valid email",
      "mobile_number": "Mobile number",
      "confirm_password": "Confirm Password",
      "password_short": "Password must be at least 6 characters",
      "password_not_match": "Passwords do not match",
      "privacy_text": "By Signing up, you agree to our Terms & Privacy Policy.",
      "accept_terms_error": "Please accept Terms & Privacy Policy",
      "already_account": "Already have an account?",
      "signup_success": "Sign Up Successful",
      "male": "Male",
      "female": "Female",
      "search_by_name": "Search by name or pet ID",
      "yes": "Yes",
      "no": "No",
      "enter_mobile": "Please Enter mobile number",
      "password_mismatch": "Passwords do not match",
    },
    'hi': {
      'appTitle': 'क्लिप कट्स',
      'login': 'लॉग इन',
      'choose_language': 'भाषा चुनें',
      'welcome_back': 'वापसी पर स्वागत है',
      'hello_there': 'नमस्ते. जारी रखने के लिए साइन इन करें',
      'choose_language_prefer': 'अपनी पसंदीदा भाषा चुनें',
      'continue': 'जारी रखना',
      'sign_up': 'साइन अप करें',
      'sign_in': 'दाखिल करना',
      'remember_me': 'मुझे याद करो',
      'forgot_password': 'पासवर्ड भूल गए?',
      'email': 'ईमेल',
      'password': 'पासवर्ड',
      'enter_email': 'कृपया ईमेल दर्ज करें',
      'enter_valid_email': 'मान्य ईमेल दर्ज करें',
      'enter_password': 'कृपया पासवर्ड दर्ज करें',
      'password_len': 'पासवर्ड कम से कम 6 वर्ण होना चाहिए',
      'logout': 'लॉग आउट',
      'logout_confirm': 'क्या आप वाकई लॉग आउट करना चाहते हैं?',
      'cancel': 'रद्द करें',
      'confirm': 'पुष्टि करें',
      'welcome': 'स्वागत है!',
      'dont_have_account': 'क्या आपके पास खाता नहीं है?',
      'already_have_account': 'क्या आपके पास पहले से एक खाता मौजूद है?',
      "hi_welcome": "हाय, आपका स्वागत है",
      "create_account": "कृपया अपना नया खाता बनाएँ",
      "upload_profile": "प्रोफाइल फोटो अपलोड करें",
      "full_name": "पूरा नाम",
      "enter_name": "कृपया नाम दर्ज करें",
      "email_address": "ईमेल पता",
      "invalid_email": "कृपया मान्य ईमेल दर्ज करें",
      "mobile_number": "मोबाइल नंबर",
      "confirm_password": "पासवर्ड की पुष्टि करें",
      "password_short": "पासवर्ड कम से कम 6 अक्षरों का होना चाहिए",
      "password_not_match": "पासवर्ड मेल नहीं खा रहा है",
      "privacy_text":
          "साइन अप करके, आप हमारी शर्तों और गोपनीयता नीति से सहमत हैं।",
      "accept_terms_error": "कृपया शर्तें और गोपनीयता नीति स्वीकार करें",
      "already_account": "पहले से खाता है?",
      "signup_success": "साइन अप सफल हुआ",
      "male": "पुरुष",
      "female": "महिला",
      "search_by_name": "नाम या पालतू जानवर की आईडी से खोजें",
      "yes": "हाँ",
      "no": "नहीं",
      "enter_mobile": "कृपया मोबाइल नंबर दर्ज करें",
      "password_mismatch": "सांकेतिक शब्द मेल नहीं खाते"
    },
  };

  String tr(String key) =>
      _t[locale.languageCode]?[key] ?? _t['en']![key] ?? key;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocDelegate();
}

class _AppLocDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // dependency injection
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // ✅ Added this helper to access setLocale anywhere
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(sl<AuthRepositoryImpl>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clip Cuts',
        locale: _locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Poppins',
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => SplashPage(onLocaleChange: setLocale),
          '/choose_language': (context) => ChooseLanguagePage(
                onLocaleChange: (locale) {
                  MyApp.of(context)?.setLocale(locale);
                },
              ),
          '/login': (_) => LoginPage(onLocaleChange: setLocale),
          '/signup': (_) => SignUpPage(onLocaleChange: setLocale),
          '/home': (_) => HomePage(onLocaleChange: setLocale),
        },
      ),
    );
  }
}
