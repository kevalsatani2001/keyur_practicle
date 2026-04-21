import '../contact_model.dart';

abstract class ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<ContactModel> contacts;
  ContactLoaded(this.contacts);
}