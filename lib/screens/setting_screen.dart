import 'package:contactapp/providers/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                "Theme : ${context.watch<ThemeProvider>().isDark ? 'Dark' : 'Light'}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Switch(
                value: context.watch<ThemeProvider>().isDark,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme(value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
