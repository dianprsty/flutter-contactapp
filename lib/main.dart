import 'package:contactapp/contacts/bloc/contact_bloc.dart';
import 'package:contactapp/core/shared_components/bloc/theme_bloc.dart';
import 'package:contactapp/gallery/bloc/gallery_bloc.dart';
import 'package:contactapp/home/widget/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  bool? theme = pref.getBool("theme");
  if (theme == null) {
    theme = false;
    pref.setBool("theme", false);
  }

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
    context.watch<ThemeBloc>().add(ThemeSetEvent());
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: context.watch<ThemeBloc>().state is ThemeDark
            ? const ColorScheme.dark()
            : const ColorScheme.light(),
      ),
      home: const HomeScreen(),
    );
  }
}
