import 'package:contactapp/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Theme : ${context.watch<ThemeBloc>().state.isDark ? 'Dark' : 'Light'}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Switch(
                value: context.watch<ThemeBloc>().state.isDark,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ThemeChangeEvent());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
