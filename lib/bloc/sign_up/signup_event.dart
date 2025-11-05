import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameChanged extends SignUpEvent {
  final String name;
  NameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class MobileChanged extends SignUpEvent {
  final String mobile;
  MobileChanged(this.mobile);
  @override
  List<Object?> get props => [mobile];
}

class PasswordChanged extends SignUpEvent {
  final String password;
  PasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
  @override
  List<Object?> get props => [confirmPassword];
}

class GenderChanged extends SignUpEvent {
  final String gender;
  GenderChanged(this.gender);
  @override
  List<Object?> get props => [gender];
}

class TermsToggled extends SignUpEvent {
  final bool value;
  TermsToggled(this.value);
  @override
  List<Object?> get props => [value];
}

class ProfileImagePickRequested extends SignUpEvent {
  final File? imageFile;
  ProfileImagePickRequested(this.imageFile);
  @override
  List<Object?> get props => [imageFile];
}

class SignUpSubmitted extends SignUpEvent {}
