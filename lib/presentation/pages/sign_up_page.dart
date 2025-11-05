import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bloc/sign_up/signup_bloc.dart';
import '../../bloc/sign_up/signup_event.dart';
import '../../bloc/sign_up/signup_state.dart';
import '../../common_widget/app_button.dart';
import '../../common_widget/app_image.dart';
import '../../common_widget/app_text_field.dart';
import '../../core/app_colors.dart';
import '../../core/app_styles.dart';
import '../../main.dart';
import '../../utils/validators.dart';

class SignUpPage extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  const SignUpPage({required this.onLocaleChange, super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations(Localizations.localeOf(context));

    return BlocProvider(
      create: (_) => SignUpBloc(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(loc.tr('signup_success'))),
              );
              Navigator.pushReplacementNamed(context, '/login');
            } else if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
            }
          },
          builder: (context, state) {
            final bloc = context.read<SignUpBloc>();

            return Stack(
              children: [
                ImageView(imageUrl: "assets/images/sign_up_layout.png"),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Text(loc.tr('hi_welcome'),
                                  style: AppTextStyle.raleWayBold24),
                              Text(loc.tr('create_account'),
                                  style: AppTextStyle.raleWayMedium14Gray),
                              const SizedBox(height: 20),

                              // Profile Picture
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    loc.tr('upload_profile'),
                                    style: AppTextStyle.raleWayMedium16.copyWith(
                                        color: AppColors.darkCharcoal),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<SignUpBloc>()
                                          .add(ProfileImagePickRequested(null));
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: AppColors.offWhite,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.lightGray),
                                        image: state.imageFile != null
                                            ? DecorationImage(
                                          image: FileImage(state.imageFile!),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
                                      ),
                                      child: state.imageFile == null
                                          ? Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: SvgPicture.asset(
                                            "assets/images/camera_icon.svg"),
                                      )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Full Name
                        AppTextField(
                          controller: _nameController,
                          hintText: loc.tr('enter_name'),
                          assetIconPath: "assets/images/user_icon.svg",
                          validator: (v) =>
                              Validators.validateName(v, loc.tr('enter_name')),
                        ),
                        const SizedBox(height: 14),

                        // Email
                        AppTextField(
                          controller: _emailController,
                          hintText: loc.tr('email_address'),
                          assetIconPath: "assets/images/mail_icon.svg",
                          validator: (v) => Validators.validateEmail(
                            v,
                            loc.tr('enter_email'),
                            loc.tr('enter_valid_email'),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Mobile
                        AppTextField(
                          controller: _mobileController,
                          hintText: loc.tr('mobile_number'),
                          assetIconPath: "assets/images/phone_icon.svg",
                          validator: (v) => Validators.validateMobile(
                            v,
                            loc.tr('enter_mobile'),
                            loc.tr('enter_valid_mobile'),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 14),

                        // Gender Selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _genderOption(context, bloc, state, loc.tr('male')),
                            const SizedBox(width: 15),
                            _genderOption(context, bloc, state, loc.tr('female')),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Password
                        AppTextField(
                          controller: _passwordController,
                          hintText: loc.tr('password'),
                          assetIconPath: "assets/images/lock_icon.svg",
                          isPassword: true,
                          validator: (v) => Validators.validatePassword(
                            v,
                            loc.tr('enter_password'),
                            loc.tr('password_short'),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Confirm Password
                        AppTextField(
                          controller: _confirmPasswordController,
                          hintText: loc.tr('confirm_password'),
                          assetIconPath: "assets/images/lock_icon.svg",
                          isPassword: true,
                          validator: (v) => Validators.validateConfirmPassword(
                            v,
                            _passwordController.text,
                            loc.tr('enter_password'),
                            loc.tr('password_mismatch'),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Terms
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  bloc.add(TermsToggled(!state.termsAccepted)),
                              child: SvgPicture.asset(
                                state.termsAccepted
                                    ? 'assets/images/check_box_active.svg'
                                    : 'assets/images/check_box_inactive.svg',
                                width: 22,
                                height: 22,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                loc.tr('privacy_text'),
                                style: AppTextStyle.raleWayMedium14Gray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Sign Up Button
                        state.loading
                            ? const Center(child: CircularProgressIndicator())
                            : PrimaryButton(
                          text: loc.tr('sign_up'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (!state.termsAccepted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          loc.tr('accept_terms_first'))),
                                );
                                return;
                              }

                              bloc.add(SignUpSubmitted());
                            }
                          },
                        ),

                        const SizedBox(height: 16),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(loc.tr('already_account'),
                                  style: AppTextStyle.raleWayMedium14Gray
                                      .copyWith(color: AppColors.darkGray)),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/login'),
                                child: Text(
                                  " ${loc.tr('sign_in')}",
                                  style: AppTextStyle.raleWayMedium14.copyWith(
                                    color: AppColors.darkCharcoal,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _genderOption(
      BuildContext context, SignUpBloc bloc, SignUpState state, String label) {
    final selected = state.gender == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => bloc.add(GenderChanged(label)),
        child: Container(
          decoration: BoxDecoration(
            color:
            selected ? AppColors.primary.withOpacity(0.15) : AppColors.offWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.lightGray,
              width: selected ? 1.8 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: AppTextStyle.raleWayMedium14Gray),
                SvgPicture.asset(
                  selected
                      ? "assets/images/radio_selected.svg"
                      : "assets/images/radio_unselected.svg",
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
