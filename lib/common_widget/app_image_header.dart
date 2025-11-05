import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_styles.dart';
import 'app_image.dart';

// ignore: must_be_immutable
class ImageHeader extends StatelessWidget {
  final Widget? child;
  final double topPadding;
  String? title;
  String? subTitle;

  ImageHeader({
    super.key,
    this.child,
    this.title = "",
    this.subTitle = "",
    this.topPadding = 150,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          /// Background + Layout images stacked
          Stack(
            children: [
              ImageView(
                imageUrl: "assets/images/header_image.png",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              ImageView(
                imageUrl: "assets/images/header_layout.png",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),

          /// Center content
          Padding(
            padding: EdgeInsets.only(top: topPadding,left: 20,right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Logo container with shadow
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        // ignore: deprecated_member_use
                        color: AppColors.black.withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ImageView(
                      imageUrl: "assets/images/splash_logo.png",
                      height: 63,
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                Text(
                  title ?? "",
                  style: AppTextStyle.raleWayBold24,
                ),
                const SizedBox(height: 8),
                Text(
                  subTitle ?? "",
                  style: AppTextStyle.raleWayMedium16,
                ),

                /// Dynamic child widget (optional)
                if (child != null) child!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
