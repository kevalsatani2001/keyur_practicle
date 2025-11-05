import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RememberMeToggled>(_onRememberMeToggled);
    on<LoginSubmitted>(_onLoginSubmitted);
    _loadRememberedCredentials();
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email, isValid: _validate(event.email, state.password)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password, isValid: _validate(state.email, event.password)));
  }

  void _onRememberMeToggled(RememberMeToggled event, Emitter<LoginState> emit) async {
    emit(state.copyWith(rememberMe: event.rememberMe));
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', event.rememberMe);
    if (!event.rememberMe) {
      prefs.remove('saved_email');
      prefs.remove('saved_password');
    }
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      if (state.rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('saved_email', state.email);
        await prefs.setString('saved_password', state.password);
      }
      // Don’t handle actual API here — AuthBloc does that
      emit(state.copyWith(isSubmitting: false));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }

  bool _validate(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty && email.contains('@');
  }

  Future<void> _loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('remember_me') ?? false;
    final email = prefs.getString('saved_email') ?? '';
    final password = prefs.getString('saved_password') ?? '';

    if (rememberMe && email.isNotEmpty) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(email: email, password: password, rememberMe: rememberMe));
    }
  }
}
