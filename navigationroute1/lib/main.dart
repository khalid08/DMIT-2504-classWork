import 'package:flutter/material.dart';
import 'routes.dart';
import 'home_page.dart';
import 'details_page.dart';
import 'second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation Demo',
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.second: (context) => const SecondPage(),
        AppRoutes.details: (context) => const DetailsPage(),
      },
      initialRoute: AppRoutes.home,
    );
  }
}
