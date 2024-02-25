import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<AddContactEvent>((event, emit) {
      var contacts = state.contacts;
      contacts.add(event.contact);
      emit(ContactUpdate(contacts));
    });
  }
}
