import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyur_practicle/core/app_styles.dart';
import '../core/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final String assetIconPath;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.assetIconPath,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onSaved,
    this.textInputAction = TextInputAction.next
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_onFocusChange);
    _obscure = widget.isPassword;
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color fillColor =
        _isFocused ? AppColors.primary.withOpacity(0.15) : AppColors.offWhite;
    final Color iconColor =
        _isFocused ? AppColors.primary : AppColors.mediumGray;

    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      cursorColor: AppColors.primary,
      textInputAction: widget.textInputAction,
      style: AppTextStyle.raleWayMedium14,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: widget.hintText,
        hintStyle:AppTextStyle.raleWayMedium14Gray,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.lightGray, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.lightGray, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1.8),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                splashRadius: 1,
                icon: SvgPicture.asset(
                  _obscure
                      ? 'assets/images/eye_close.svg'
                      : 'assets/images/eye_open.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
                onPressed: () {
                  setState(() => _obscure = !_obscure);
                },
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: SvgPicture.asset(
                  widget.assetIconPath,
                  width: 20,
                  height: 24,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
      ),
    );
  }
}
