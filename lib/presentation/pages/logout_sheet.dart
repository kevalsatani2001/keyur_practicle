import 'package:flutter/material.dart';
import 'package:keyur_practicle/core/app_colors.dart';
import 'package:keyur_practicle/core/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/app_button.dart';
import '../../main.dart';

void showLogoutBottomSheet(BuildContext context) {
  final loc = AppLocalizations(Localizations.localeOf(context));
  showModalBottomSheet(
    context: context,
    showDragHandle: true,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            loc.tr('logout_confirm'),
            textAlign: TextAlign.center,
            style: AppTextStyle.raleWayMedium14.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: AppColors.darkCharcoal),
          ),
          const SizedBox(height: 15),
          Row(children: [
            Expanded(
              child: PrimaryButton(
                isShadow: false,
                text: loc.tr('yes').toUpperCase(),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('auth_token');
                  await prefs.remove('user_id');
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
                backgroundColor: AppColors.darkCharcoal.withOpacity(0.10),
                textColor: AppColors.darkCharcoal,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: PrimaryButton(
                text: loc.tr('no').toUpperCase(),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ]),

          const SizedBox(height: 30),
        ]),
      );
    },
  );
}
