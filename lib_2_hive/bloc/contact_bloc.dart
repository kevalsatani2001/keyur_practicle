import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/bloc/contact_state.dart';
import '../contact_model.dart';
import 'contact_event.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final Box<ContactModel> contactBox;

  ContactBloc(this.contactBox) : super(ContactLoading()) {

    // Data Load karva mate
    on<LoadContacts>((event, emit) {
      final contacts = contactBox.values.toList();
      emit(ContactLoaded(contacts));
    });

    // Data Add karva mate
    on<AddContact>((event, emit) async {
      final newContact = ContactModel(
        name: event.name,
        phone: event.phone,
        email: event.email,
      );
      await contactBox.add(newContact);
      add(LoadContacts()); // List refresh karo
    });

    // Data Delete karva mate
    on<DeleteContact>((event, emit) async {
      await contactBox.deleteAt(event.index);
      add(LoadContacts()); // List refresh karo
    });
  }
}