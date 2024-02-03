import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Map<String, dynamic>> contacts = [
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late DateTime _dateTime;
  late Color _bgColor;
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _bgColor = Colors.green;
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, stfSetState) {
                return Dialog.fullscreen(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          "Add Contact",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: _phoneController,
                                decoration: const InputDecoration(
                                  labelText: "Phone Number",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    "Date\t: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    // width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black,
                                        )),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Text(
                                      '${_dateTime.day < 10 ? "0" : ""}${_dateTime.day} - ${_dateTime.month < 10 ? "0" : ""}${_dateTime.month} - ${_dateTime.year}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                      ).then((date) {
                                        stfSetState(() {
                                          _dateTime = date!;
                                        });
                                      });
                                    },
                                    icon: const Icon(Icons.calendar_month),
                                    label: const Text(
                                      "Select Date",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)))),
                                        iconColor: MaterialStatePropertyAll(
                                            Colors.white),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.black)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    "Color\t: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 42,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        color: _bgColor),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Pick a Color"),
                                            backgroundColor: Colors.white,
                                            content: ColorPicker(
                                              pickerColor: _bgColor,
                                              onColorChanged: (value) {
                                                stfSetState(() {
                                                  _bgColor = value;
                                                });
                                              },
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Close"))
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.color_lens),
                                    label: const Text(
                                      "Pick Color",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)))),
                                        iconColor: MaterialStatePropertyAll(
                                            Colors.white),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.black)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Text(
                                        "Profile Picture\t: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          final picker = ImagePicker();
                                          final pickedFile =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (pickedFile != null) {
                                            stfSetState(
                                              () {
                                                _image = pickedFile;
                                              },
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.image),
                                        label: const Text(
                                          "Select Image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 8)),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8)))),
                                            iconColor: MaterialStatePropertyAll(
                                                Colors.white),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.black)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black,
                                        )),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: _image == null
                                        ? const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              // Icon(Icons.file_upload_outlined),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text("Please Select Image")
                                            ],
                                          )
                                        : Image.file(
                                            File(_image!.path),
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                contacts = [
                                  ...contacts,
                                  {
                                    "name": _nameController.text,
                                    "phone": _phoneController.text,
                                    "date": _dateTime,
                                    "color": _bgColor,
                                    "picture": _image,
                                  }
                                ];
                                _nameController.text = "";
                                _phoneController.text = "";
                                _dateTime = DateTime.now();
                                _bgColor = Colors.green;
                                _image = null;
                              },
                            );

                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size.fromHeight(42)),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            iconColor: MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(
                                () {
                                  _nameController.text = "";
                                  _phoneController.text = "";
                                  _dateTime = DateTime.now();
                                  _bgColor = Colors.green;
                                  _image = null;
                                },
                              );

                              Navigator.pop(context);
                            },
                            style: const ButtonStyle(
                                minimumSize: MaterialStatePropertyAll(
                                    Size.fromHeight(42)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8)),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            child: const Text(
                              "Discard",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
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
                decoration: BoxDecoration(
                    color: contacts[index]["color"], shape: BoxShape.circle),
                child: contacts[index]["picture"] == null
                    ? Center(
                        child: Text(
                          contacts[index]["name"]![0],
                          style: const TextStyle(
                              fontSize: 32, color: Colors.white),
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          File(contacts[index]["picture"]!.path),
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
                      '${contacts[index]['date'].day < 10 ? "0" : ""}${contacts[index]['date'].day} - ${contacts[index]['date'].month < 10 ? "0" : ""}${_dateTime.month} - ${_dateTime.year}',
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
