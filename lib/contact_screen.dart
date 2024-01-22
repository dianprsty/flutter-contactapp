import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Map<String, String>> contacts = [
    {"name": "Leanne Graham", "phone": "1-770-736-8031  x56442"},
    {"name": "Ervin Howell", "phone": "010-692-6593 x09125"},
    {"name": "Clementine Bauch", "phone": "1-463-123-4447"},
    {"name": "Patricia Lesback", "phone": "493-170-9623mx156"},
    {"name": "Chelsey Dietrich", "phone": "(254)954-1289"},
    {"name": "Mrs. Dennis Schulist", "phone": "1-477-935-8478 x6480"},
    {"name": "Kurtis Weissnat", "phone": "210.067.6132"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Contact List",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        drawer: const Drawer(),
        body: ListView.builder(
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
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      contacts[index]["name"]![0],
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
                title: Text(
                  contacts[index]["name"]!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                subtitle: Text(contacts[index]["phone"]!),
              );
            }));
  }
}
