import 'package:contactapp/bloc/contact_bloc.dart';
import 'package:contactapp/bloc/gallery_bloc.dart';
import 'package:contactapp/bloc/theme_bloc.dart';
import 'package:contactapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactBloc(),
        ),
        BlocProvider(
          create: (context) => GalleryBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: context.watch<ThemeBloc>().state.themeColor,
      ),
      home: const HomeScreen(),
    );
  }
}
