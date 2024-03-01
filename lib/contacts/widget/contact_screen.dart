import 'dart:io';

import 'package:contactapp/contacts/bloc/contact_bloc.dart';
import 'package:contactapp/contacts/widget/add_contact_screen.dart';
import 'package:contactapp/core/shared_components/bloc/theme_bloc.dart';
import 'package:contactapp/home/widget/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
            MaterialPageRoute(
              builder: (context) => const AddContactScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      drawer: const Drawer(),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 60),
            itemCount: state.contacts.length,
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
                      color: state.contacts[index]["color"],
                      shape: BoxShape.circle),
                  child: state.contacts[index]["picture"] == null
                      ? Center(
                          child: Text(
                            state.contacts[index]["name"]![0],
                            style: const TextStyle(
                                fontSize: 32, color: Colors.white),
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(
                            File(state.contacts[index]["picture"]!.path),
                          ),
                        ),
                ),
                title: Text(
                  state.contacts[index]["name"]!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(state.contacts[index]["phone"]!),
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
                        '${state.contacts[index]['date'].day < 10 ? "0" : ""}${state.contacts[index]['date'].day} - ${state.contacts[index]['date'].month < 10 ? "0" : ""}${state.contacts[index]['date'].month} - ${state.contacts[index]['date'].year}',
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
