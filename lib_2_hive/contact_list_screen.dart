import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
import 'bloc/contact_state.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive + BLoC Demo")),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactLoaded) {
            if (state.contacts.isEmpty) {
              return const Center(child: Text("No contacts found."));
            }
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text("${contact.phone} | ${contact.email}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<ContactBloc>().add(DeleteContact(index));
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Demo mate dummy data add kariye
          context.read<ContactBloc>().add(
              AddContact("New User", "1234567890", "user@mail.com")
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}