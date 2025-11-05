import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data_impl/repositories/auth_repository_impl.dart';
import '../../data/models/login_response.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());
    try {
      final LoginResponse resp =
      await repository.login(email: event.email, password: event.password);

      if (resp.status == 200 && resp.data != null) {
        final prefs = await SharedPreferences.getInstance();

        // ✅ Save token and id as before
        await prefs.setString('auth_token', resp.data!.token);
        await prefs.setInt('user_id', resp.data!.id);

        // ✅ NEW: Save full login response
        await prefs.setString('login_response', jsonEncode(resp.toJson()));

        emit(AuthSuccess(resp.data!));
      } else {
        emit(AuthFailure(
            resp.message.isNotEmpty ? resp.message : 'Login failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
