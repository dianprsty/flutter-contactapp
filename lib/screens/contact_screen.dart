import 'dart:io';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:contactapp/providers/theme_provide.dart';
import 'package:contactapp/screens/add_contact_screen.dart';
import 'package:contactapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          color: context.watch<ThemeProvider>().isDark
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
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.contacts.length,
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
                        color: provider.contacts[index]["color"],
                        shape: BoxShape.circle),
                    child: provider.contacts[index]["picture"] == null
                        ? Center(
                            child: Text(
                              provider.contacts[index]["name"]![0],
                              style: const TextStyle(
                                  fontSize: 32, color: Colors.white),
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(
                              File(provider.contacts[index]["picture"]!.path),
                            ),
                          ),
                  ),
                  title: Text(
                    provider.contacts[index]["name"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(provider.contacts[index]["phone"]!),
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
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
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
                          '${provider.contacts[index]['date'].day < 10 ? "0" : ""}${provider.contacts[index]['date'].day} - ${provider.contacts[index]['date'].month < 10 ? "0" : ""}${provider.contacts[index]['date'].month} - ${provider.contacts[index]['date'].year}',
                        )
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
