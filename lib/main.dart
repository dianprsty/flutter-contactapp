import 'package:contactapp/providers/contact_provider.dart';
import 'package:contactapp/providers/gallery_provider.dart';
import 'package:contactapp/providers/theme_provide.dart';
import 'package:contactapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => GalleryProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ContactProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: context.watch<ThemeProvider>().themeColor,
      ),
      home: const HomeScreen(),
    );
  }
}
