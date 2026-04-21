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

/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(home: PaginationHome(), debugShowCheckedModeBanner: false),
  );
}

class PaginationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Pagination Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => LocalPagination()),
              ),
              child: Text("Local List Pagination"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => ApiPagination()),
              ),
              child: Text("API Pagination"),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => ClientSidePagination()),
              ),
              child: Text("client Pagination"),
            ),
          ],
        ),
      ),
    );
  }
}

// --- ૧. LOCAL LIST PAGINATION ---
class LocalPagination extends StatefulWidget {
  @override
  _LocalPaginationState createState() => _LocalPaginationState();
}

class _LocalPaginationState extends State<LocalPagination> {
  final List<String> _allData = List.generate(
    1000,
    (i) => "Local Item ${i + 1}",
  );
  List<String> _displayData = [];
  int _currentLimit = 15;
  bool _loadingMore = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _displayData = _allData.getRange(0, _currentLimit).toList();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() async {
    if (_displayData.length >= _allData.length) return;

    setState(() => _loadingMore = true);

    // થોડો લોડિંગ ટાઈમ આપવા માટે (Real feel)
    await Future.delayed(Duration(seconds: 1));

    int nextLimit = _currentLimit + 15;
    if (nextLimit > _allData.length) nextLimit = _allData.length;

    setState(() {
      _displayData.addAll(_allData.getRange(_currentLimit, nextLimit).toList());
      _currentLimit = nextLimit;
      _loadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Local Pagination")),
      body: ListView.builder(
        controller: _controller,
        itemCount: _displayData.length + 1,
        itemBuilder: (context, index) {
          if (index < _displayData.length) {
            return ListTile(
              leading: CircleAvatar(child: Text("${index + 1}")),
              title: Text(_displayData[index]),
            );
          } else {
            return _loadingMore
                ? Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SizedBox();
          }
        },
      ),
    );
  }
}

// --- ૨. API PAGINATION ---
class ApiPagination extends StatefulWidget {
  @override
  _ApiPaginationState createState() => _ApiPaginationState();
}

class _ApiPaginationState extends State<ApiPagination> {
  List _posts = [];
  int _page = 1;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller.addListener(_loadMore);
  }

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      final res = await http.get(
        Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit",
        ),
      );
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      print("Error fetching data");
    }
    setState(() => _isFirstLoadRunning = false);
  }

  void _loadMore() async {
    if (_hasNextPage &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning &&
        _controller.position.extentAfter < 300) {
      setState(() => _isLoadMoreRunning = true);
      _page += 1;
      try {
        final res = await http.get(
          Uri.parse(
            "https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit",
          ),
        );
        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() => _hasNextPage = false);
        }
      } catch (err) {
        print("Something went wrong!");
      }
      setState(() => _isLoadMoreRunning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Pagination")),
      body: _isFirstLoadRunning
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (context, index) => Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: ListTile(
                        title: Text(_posts[index]['title']),
                        subtitle: Text("ID: ${_posts[index]['id']}"),
                      ),
                    ),
                  ),
                ),
                if (_isLoadMoreRunning)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
    );
  }
}

class ClientSidePagination extends StatefulWidget {
  @override
  _ClientSidePaginationState createState() => _ClientSidePaginationState();
}

class _ClientSidePaginationState extends State<ClientSidePagination> {
  List allApiData = []; // API માંથી આવેલો બધો ડેટા
  List displayedItems = []; // સ્ક્રીન પર દેખાતો ડેટા
  int currentMax = 15; // અત્યારે કેટલી આઈટમ બતાવવી છે
  bool isLoading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchAllData(); // API માંથી એકવાર બધો ડેટા ખેંચી લેવો

    _scrollController.addListener(() {
      // જો યુઝર છેલ્લે પહોંચે તો વધુ 15 આઈટમ લોડ કરવી
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreLocalData();
      }
    });
  }

  // ૧. API માંથી બધો ડેટા એકસાથે લાવવો
  Future fetchAllData() async {
    final url =
        'https://jsonplaceholder.typicode.com/posts'; // આમાં પેજ પેરામીટર નથી
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        setState(() {
          allApiData = data;
          // શરૂઆતનો ડેટા (પહેલી 15 આઈટમ)
          displayedItems = allApiData.take(currentMax).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // ૨. લોકલ લિસ્ટમાંથી વધુ ડેટા ડિસ્પ્લે લિસ્ટમાં ઉમેરવો
  void _loadMoreLocalData() {
    if (currentMax < allApiData.length) {
      setState(() {
        // હવે પછીની 15 આઈટમ ઉમેરો
        int nextMax = currentMax + 15;
        if (nextMax > allApiData.length) nextMax = allApiData.length;

        displayedItems.addAll(
          allApiData.getRange(currentMax, nextMax).toList(),
        );
        currentMax = nextMax;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("No Page Param Pagination")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: (currentMax < allApiData.length)
                  ? displayedItems.length + 1
                  : displayedItems.length,
              itemBuilder: (context, index) {
                if (index < displayedItems.length) {
                  return ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(displayedItems[index]['title']),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
    );
  }
}

 */
