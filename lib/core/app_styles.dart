import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyur_practicle/core/app_colors.dart';

class AppTextStyle {
  static final heading = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final subText = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.gray,
  );

  static final button = GoogleFonts.poppins(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static final appTitle = GoogleFonts.pattaya(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 40,
  );
  static final raleWayBold24 = GoogleFonts.raleway(
    color: AppColors.darkCharcoal,
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  static final raleWayMedium16 = GoogleFonts.raleway(
    color: AppColors.gray,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static final raleWayMedium14 = GoogleFonts.raleway(
    color: AppColors.darkCharcoal,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static final raleWayMedium14Gray = GoogleFonts.raleway(
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}
