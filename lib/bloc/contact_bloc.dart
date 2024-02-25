import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final List<Map<String, dynamic>> _contacts = [
    {
      "name": "Alice Green",
      "phone": "+1 (555) 123-4567",
      "date": DateTime.now(),
      "color": Colors.green,
      "picture": null,
    },
    {
      "name": "Bob Johnson",
      "phone": "+44 20 7946 0958",
      "date": DateTime.now(),
      "color": Colors.green,
      "picture": null,
    },
    {
      "name": "Clara Davis",
      "phone": "+49 30 1234567",
      "date": DateTime.now(),
      "color": Colors.green,
      "picture": null,
    },
    {
      "name": "David Smith",
      "phone": "+61 2 3456 7890",
      "date": DateTime.now(),
      "color": Colors.green,
      "picture": null,
    },
    {
      "name": "Emily White",
      "phone": "+81 3-1234-5678",
      "date": DateTime.now(),
      "color": Colors.green,
      "picture": null,
    }
  ];
  ContactBloc() : super(ContactInitial()) {
    on<AddContactEvent>((event, emit) {
      _contacts.add(event.contact);
      emit(ContactUpdate(_contacts));
    });
  }
}
