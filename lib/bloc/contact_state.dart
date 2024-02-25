part of 'contact_bloc.dart';

sealed class ContactState extends Equatable {
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

  ContactState();

  @override
  List<Object> get props => [_contacts];

  List<Map<String, dynamic>> get contacts => _contacts;
}

final class ContactInitial extends ContactState {}

final class ContactUpdate extends ContactState {
  @override
  final List<Map<String, dynamic>> contacts;

  ContactUpdate(this.contacts);
}
