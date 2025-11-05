import 'dart:io';
import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String name;
  final String email;
  final String mobile;
  final String password;
  final String confirmPassword;
  final String gender;
  final bool termsAccepted;
  final File? imageFile;
  final bool loading;
  final bool success;
  final String? error;

  const SignUpState({
    this.name = '',
    this.email = '',
    this.mobile = '',
    this.password = '',
    this.confirmPassword = '',
    this.gender = '',
    this.termsAccepted = false,
    this.imageFile,
    this.loading = false,
    this.success = false,
    this.error,
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? mobile,
    String? password,
    String? confirmPassword,
    String? gender,
    bool? termsAccepted,
    File? imageFile,
    bool? loading,
    bool? success,
    String? error,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      imageFile: imageFile ?? this.imageFile,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    mobile,
    password,
    confirmPassword,
    gender,
    termsAccepted,
    imageFile,
    loading,
    success,
    error,
  ];
}
