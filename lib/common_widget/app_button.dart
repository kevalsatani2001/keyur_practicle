import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final Color? backgroundColor; // optional custom background
  final Color? textColor;
 final bool isShadow;// optional custom text color

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.isShadow = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.button;
    final fgColor = textColor ?? Colors.white;

    return Container(
      decoration: BoxDecoration(
        boxShadow: isShadow?[
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.18),
          ),
        ]:null,
        borderRadius: BorderRadius.circular(53),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(53),
          ),
          elevation: 0,
        ),
        onPressed: loading ? null : onPressed,
        child: loading
            ? CircularProgressIndicator(color: fgColor)
            : Text(
          text,
          style: AppTextStyle.button.copyWith(color: fgColor),
        ),
      ),
    );
  }
}

/// Utility for spacing
Widget verticalSpace(double h) => SizedBox(height: h);
