part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

final class AddContactEvent extends ContactEvent {
  final Map<String, dynamic> contact;

  const AddContactEvent(this.contact);

  @override
  List<Object> get props => [];
}
