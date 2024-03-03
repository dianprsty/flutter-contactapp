import 'package:bloc/bloc.dart';
import 'package:contactapp/contacts/model/contact_model.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<AddContactEvent>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? strContacts = pref.getStringList("contacts");

      strContacts!.add(event.contact.toJsonString());
      pref.setStringList("contacts", strContacts);

      emit(ContactFinishUpdate());
    });

    on<FinishAddContactEvent>((event, emit) {
      emit(ContactInitial());
    });
  }
}
