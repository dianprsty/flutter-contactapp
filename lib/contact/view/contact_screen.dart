import 'dart:convert';
import 'dart:io';

import 'package:contactapp/contact/bloc/contact_bloc.dart';
import 'package:contactapp/contact/model/contact_model.dart';
import 'package:contactapp/contact/view/add_contact_screen.dart';
import 'package:contactapp/core/shared_components/bloc/theme_bloc.dart';
import 'package:contactapp/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late SharedPreferences pref;
  List<ContactModel> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    pref = await SharedPreferences.getInstance();
    List<String>? strContacts = pref.getStringList("contacts");
    List<ContactModel> listContact = [];
    for (var data in strContacts!) {
      print(data);
      var jsonData = json.decode(data);
      var contact = ContactModel.fromJson(jsonData);
      listContact.add(contact);
    }

    setState(() {
      contacts = listContact;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.watch<ThemeBloc>().state is ThemeDark
              ? Colors.white
              : Colors.black,
        ),
        title: const Text("Contact List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.home_filled))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            // MaterialPageRoute(
            //   builder: (context) => const AddContactScreen(),
            // ),
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AddContactScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
                transitionDuration: Durations.medium1),
          );
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      drawer: const Drawer(),
      body: BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
        if (state is ContactFinishUpdate) {
          _loadPreferences();
          context.read<ContactBloc>().add(FinishAddContactEvent());
        }
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 60),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              selectedTileColor: Colors.blue,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              titleAlignment: ListTileTitleAlignment.center,
              horizontalTitleGap: 16,
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: contacts[index].color, shape: BoxShape.circle),
                child: contacts[index].picture == null
                    ? Center(
                        child: Text(
                          contacts[index].name[0],
                          style: const TextStyle(
                              fontSize: 32, color: Colors.white),
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          File(contacts[index].picture!.path),
                        ),
                      ),
              ),
              title: Text(
                contacts[index].name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(contacts[index].phone),
              trailing: SizedBox(
                width: 100,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              //
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: IconButton(
                            icon: const Icon(Icons.delete_rounded,
                                color: Colors.red),
                            onPressed: () {
                              //
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${contacts[index].date.day < 10 ? "0" : ""}${contacts[index].date.day} - ${contacts[index].date.month < 10 ? "0" : ""}${contacts[index].date.month} - ${contacts[index].date.year}',
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
