import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:keyur_practicle/common_widget/app_image.dart';
import 'package:keyur_practicle/core/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart'; // for AppLocalizations

class SplashPage extends StatefulWidget {
  final void Function(Locale) onLocaleChange;

  const SplashPage({required this.onLocaleChange, super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  Future<void> _initCheck() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();

    final bool langSelected = prefs.getBool('language_selected') ?? false;
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final savedData = prefs.getString('login_response');

    // 🔹 1. No language selected yet
    if (!langSelected) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/choose_language');
      return;
    }

    // 🔹 2. If logged in and valid login data exists → Go Home
    if (isLoggedIn && savedData != null && savedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(savedData);
        if (decoded['data'] != null && decoded['data']['token'] != null) {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/home');
          return;
        }
      } catch (e) {
        debugPrint("Error reading saved login: $e");
      }
    }

    // 🔹 3. Otherwise → Go to Login
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations(Localizations.localeOf(context));

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            /// Background Image
            ImageView(
              imageUrl: "assets/images/splash_bg.jpg",
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity,
            ),

            /// Gradient Overlay with Opacity
            Opacity(
              opacity: 0.6,
              child: ImageView(
                imageUrl: "assets/images/splash_gradiant.png",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),

            /// Center Content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageView(
                    imageUrl: "assets/images/splash_logo_white.png",
                    bgColor: Colors.transparent,
                    height: 115,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    loc.tr('appTitle'),
                    style: AppTextStyle.appTitle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
