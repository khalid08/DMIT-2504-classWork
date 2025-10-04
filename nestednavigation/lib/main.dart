import 'package:flutter/material.dart';
import 'package:nestednavigation/pages/home_page.dart';
import 'package:nestednavigation/pages/settings/settings_manager.dart';
import 'package:nestednavigation/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case homeRoute:
            page = const HomePage();
            break;
          case settingsHomeRoute:
            page = SettingsManager(
              optionPageRoute: settings.name!.substring(10),
            );
            break;
          default:
            throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) => page,
          settings: settings,
        );
      },
    );
  }
}
