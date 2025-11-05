// lib/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/app_button.dart';
import '../../common_widget/app_image_header.dart';
import '../../common_widget/app_text_field.dart';
import '../../core/app_colors.dart';
import '../../core/app_styles.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../utils/validators.dart';
import '../../main.dart';

class LoginPage extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  const LoginPage({required this.onLocaleChange, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to read values directly
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    // If you had saves that update other things, call save:
    _formKey.currentState?.save();

    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    // Dispatch directly to AuthBloc (no dependency on LoginBloc state)
    context.read<AuthBloc>().add(LoginRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations(Localizations.localeOf(context));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', true);
              await prefs.setBool('language_selected', true);

              if (!mounted) return;
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },

          builder: (context, authState) {
            return BlocBuilder<LoginBloc, LoginState>(
              builder: (context, loginState) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: _formKey,
                    child: ImageHeader(
                      title: loc.tr('welcome_back'),
                      subTitle: loc.tr('hello_there'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 30),

                          // Email (controller wired)
                          AppTextField(
                            controller: _emailCtrl,
                            hintText: loc.tr('enter_email'),
                            assetIconPath: "assets/images/mail_icon.svg",
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => Validators.validateEmail(
                              v,
                              loc.tr('enter_email'),
                              loc.tr('enter_valid_email'),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password (controller wired)
                          AppTextField(
                            controller: _passwordCtrl,
                            hintText: loc.tr('enter_password'),
                            assetIconPath: "assets/images/lock_icon.svg",
                            textInputAction: TextInputAction.done,
                            isPassword: true,
                            validator: (v) => Validators.validatePassword(
                              v,
                              loc.tr('enter_password'),
                              loc.tr('password_len'),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Remember Me / Forgot
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<LoginBloc>().add(
                                          RememberMeToggled(
                                              !loginState.rememberMe));
                                    },
                                    child: SvgPicture.asset(
                                      loginState.rememberMe
                                          ? 'assets/images/check_box_active.svg'
                                          : 'assets/images/check_box_inactive.svg',
                                      width: 19,
                                      height: 19,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    loc.tr('remember_me'),
                                    style: AppTextStyle.raleWayMedium14Gray
                                        .copyWith(
                                        fontSize: 13,
                                        color: AppColors.darkCharcoal),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/forgot_password'),
                                child: Text(
                                  loc.tr('forgot_password'),
                                  style: AppTextStyle.raleWayMedium14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGray,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Sign In
                          authState is AuthLoading
                              ? const Center(child: CircularProgressIndicator())
                              : PrimaryButton(
                            text: loc.tr('sign_in').toUpperCase(),
                            onPressed: () => _submit(context),
                          ),

                          const SizedBox(height: 170),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(loc.tr('dont_have_account'),
                                  style: AppTextStyle.raleWayMedium14Gray
                                      .copyWith(color: AppColors.darkGray)),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/signup'),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    loc.tr('sign_up'),
                                    style:
                                    AppTextStyle.raleWayMedium14.copyWith(
                                      color: AppColors.darkCharcoal,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
