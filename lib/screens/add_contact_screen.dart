import 'dart:io';

import 'package:contactapp/providers/contact_provider.dart';
import 'package:contactapp/providers/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late DateTime _dateTime;
  late Color _bgColor;
  XFile? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _bgColor = Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please input contact name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please input phone number";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: context.watch<ThemeProvider>().isDark
                                      ? Colors.white
                                      : Colors.black,
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
                                setState(() {
                                  _dateTime = date!;
                                });
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                            label: Text(
                              "Select Date",
                              style: TextStyle(
                                color: context.watch<ThemeProvider>().isDark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            style: context.watch<ThemeProvider>().isDark
                                ? buttonStyleWhite
                                : buttonStyleBlack,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    content: ColorPicker(
                                      pickerColor: _bgColor,
                                      onColorChanged: (value) {
                                        setState(() {
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
                            label: Text(
                              "Pick Color",
                              style: TextStyle(
                                color: context.watch<ThemeProvider>().isDark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            style: context.watch<ThemeProvider>().isDark
                                ? buttonStyleWhite
                                : buttonStyleBlack,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    setState(
                                      () {
                                        _image = pickedFile;
                                      },
                                    );
                                  }
                                },
                                icon: const Icon(Icons.image),
                                label: Text(
                                  "Select Image",
                                  style: TextStyle(
                                    color: context.watch<ThemeProvider>().isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                style: context.watch<ThemeProvider>().isDark
                                    ? buttonStyleWhite
                                    : buttonStyleBlack,
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
                                  color: context.watch<ThemeProvider>().isDark
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            padding: const EdgeInsets.all(16),
                            child: _image == null
                                ? const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "No Image Selected",
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Icon(
                                        Icons.image,
                                        size: 48,
                                      ),
                                    ],
                                  )
                                : Image.file(
                                    File(_image!.path),
                                    height: 200,
                                    width: 200,
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
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    setState(
                      () {
                        Provider.of<ContactProvider>(context, listen: false)
                            .addContacts({
                          "name": _nameController.text,
                          "phone": _phoneController.text,
                          "date": _dateTime,
                          "color": _bgColor,
                          "picture": _image,
                        });

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
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(42)),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    iconColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
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
                        minimumSize:
                            MaterialStatePropertyAll(Size.fromHeight(42)),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
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
        ),
      ),
    );
  }
}

ButtonStyle buttonStyleBlack = const ButtonStyle(
  padding: MaterialStatePropertyAll(
    EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    ),
  ),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  ),
  iconColor: MaterialStatePropertyAll(Colors.white),
  backgroundColor: MaterialStatePropertyAll(Colors.black),
);

ButtonStyle buttonStyleWhite = const ButtonStyle(
  padding: MaterialStatePropertyAll(
    EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    ),
  ),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  ),
  iconColor: MaterialStatePropertyAll(Colors.black),
  backgroundColor: MaterialStatePropertyAll(Colors.white),
);
