import 'dart:async';
import 'dart:io';
import 'package:contactapp/core/shared_components/bloc/theme_bloc.dart';
import 'package:contactapp/gallery/bloc/gallery_bloc.dart';
import 'package:contactapp/gallery/view/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddImageScreenState createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  XFile? _image;
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: LottieBuilder.asset("assets/lottie/checked.json"),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        "Add New Photo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please input the title";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                labelText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                    "Add Image",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: context.watch<ThemeBloc>().state
                                              is ThemeDark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  style: context.watch<ThemeBloc>().state
                                          is ThemeDark
                                      ? buttonStyleWhite
                                      : buttonStyleBlack,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                _image != null
                                    ? Container(
                                        height: 400,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: context
                                                    .watch<ThemeBloc>()
                                                    .state is ThemeDark
                                                ? Colors.white
                                                : Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Image.file(File(_image!.path),
                                            fit: BoxFit.cover),
                                      )
                                    : Container(
                                        height: 400,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: context
                                                      .watch<ThemeBloc>()
                                                      .state is ThemeDark
                                                  ? Colors.white
                                                  : Colors.black,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.image_outlined,
                                            size: 100,
                                            color: context
                                                    .watch<ThemeBloc>()
                                                    .state is ThemeDark
                                                ? Colors.white
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    if (_image == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please Select Picture",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.red,
                                          dismissDirection:
                                              DismissDirection.down,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });

                                    await Future.delayed(
                                      const Duration(milliseconds: 5000),
                                    );
                                    setState(
                                      () {
                                        isLoading = false;
                                      },
                                    );

                                    Map<String, dynamic> data = {
                                      "title": _titleController.text,
                                      "image": _image,
                                    };

                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<GalleryBloc>()
                                        .add(GalleryAddEvent(data));

                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GalleryScreen(),
                                      ),
                                      (route) => route.isFirst,
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      Colors.blue,
                                    ),
                                    foregroundColor:
                                        const MaterialStatePropertyAll(
                                      Colors.white,
                                    ),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GalleryScreen(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      Colors.white,
                                    ),
                                    foregroundColor:
                                        const MaterialStatePropertyAll(
                                      Colors.black,
                                    ),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: const BorderSide(
                                              color: Colors.black)),
                                    ),
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
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
