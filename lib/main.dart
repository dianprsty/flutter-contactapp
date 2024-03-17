import 'package:contactapp/auth/bloc/auth_bloc.dart';
import 'package:contactapp/auth/view/login_screen.dart';
// import 'package:contactapp/auth/view/register_screen.dart';
import 'package:contactapp/contact/bloc/contact_bloc.dart';
import 'package:contactapp/core/shared_components/bloc/theme_bloc.dart';
import 'package:contactapp/gallery/bloc/gallery_bloc.dart';
import 'package:contactapp/home/view/home_screen.dart';
// import 'package:contactapp/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  bool? theme = pref.getBool("theme");
  List<String>? contacts = pref.getStringList("contacts");
  String? email = pref.getString("email");
  List<String> initalData = [
    '{"name": "Alice Green", "phone": "+1 (555) 123-4567", "date": null, "color": null, "picture": null}',
    '{"name": "Bob Johnson", "phone": "+44 20 7946 0958", "date": null, "color": null, "picture": null}',
    '{"name": "Clara Davis", "phone": "+49 30 1234567", "date": null, "color": null, "picture": null}',
    '{"name": "David Smith", "phone": "+61 2 3456 7890", "date": null, "color": null, "picture": null}',
    '{"name": "Emily White", "phone": "+81 3-1234-5678", "date": null, "color": null, "picture": null}',
  ];
  if (theme == null) {
    theme = false;
    pref.setBool("theme", false);
  }
  if (contacts == null) {
    pref.setStringList("contacts", initalData);
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
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        )
      ],
      child: MyApp(email: email),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.email});
  final String? email;

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
      home: email != null ? const HomeScreen() : const LoginScreen(), //const RegisterScreen(), //const HomeScreen(),
    );
  }
}
