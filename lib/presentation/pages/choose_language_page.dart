import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:keyur_practicle/common_widget/app_button.dart';
import 'package:keyur_practicle/common_widget/app_image.dart';
import 'package:keyur_practicle/common_widget/app_image_header.dart';
import 'package:keyur_practicle/core/app_colors.dart';
import 'package:keyur_practicle/core/app_styles.dart';
import 'package:keyur_practicle/core/language_helper.dart';
import '../../main.dart';

class ChooseLanguagePage extends StatefulWidget {
  final void Function(Locale) onLocaleChange;

  const ChooseLanguagePage({super.key, required this.onLocaleChange});

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  String _selectedLangCode = "en";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocale = Localizations.localeOf(context);
    _selectedLangCode = currentLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations(Localizations.localeOf(context));

    return Scaffold(
      backgroundColor: AppColors.white,
      body: ImageHeader(
        title: loc.tr('choose_language'),
        subTitle: loc.tr('choose_language_prefer'),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildLangTile(context, "English", "en"),
            const SizedBox(height: 15),
            _buildLangTile(context, "हिन्दी", "hi"),
            const SizedBox(height: 30),

            /// ✅ Save language + continue
            PrimaryButton(
              text: loc.tr('continue'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('language_selected', true);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangTile(
      BuildContext context,
      String title,
      String code,
      ) {
    final isSelected = _selectedLangCode == code;
    final borderRadius = BorderRadius.circular(18);

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () async {
          final locale = Locale(code);
          await LanguageHelper.changeLocale(context, locale);
          widget.onLocaleChange(locale);
          setState(() => _selectedLangCode = code);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.15)
                : AppColors.offWhite,
            borderRadius: borderRadius,
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.lightGray,
              width: isSelected ? 1.8 : 1,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: AppColors.rosePink.withOpacity(0.09),
              ),
            ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: isSelected
                    ? AppTextStyle.raleWayMedium14
                    : AppTextStyle.raleWayMedium14Gray,
              ),
              ImageView(
                imageUrl: isSelected
                    ? "assets/images/radio_selected.svg"
                    : "assets/images/radio_unselected.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
