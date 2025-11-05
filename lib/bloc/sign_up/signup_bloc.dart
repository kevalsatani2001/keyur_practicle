import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final ImagePicker _picker = ImagePicker();

  SignUpBloc() : super(const SignUpState()) {
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));
    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<MobileChanged>((event, emit) => emit(state.copyWith(mobile: event.mobile)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<ConfirmPasswordChanged>(
            (event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
    on<GenderChanged>((event, emit) => emit(state.copyWith(gender: event.gender)));
    on<TermsToggled>((event, emit) => emit(state.copyWith(termsAccepted: event.value)));

    on<ProfileImagePickRequested>((event, emit) async {
      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        emit(state.copyWith(imageFile: File(picked.path)));
      }
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(state.copyWith(loading: true));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(loading: false, success: true));
    });
  }
}
