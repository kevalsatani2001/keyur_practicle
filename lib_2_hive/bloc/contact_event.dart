abstract class ContactEvent {}

class LoadContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final String name;
  final String phone;
  final String email;
  AddContact(this.name, this.phone, this.email);
}

class DeleteContact extends ContactEvent {
  final int index;
  DeleteContact(this.index);
}