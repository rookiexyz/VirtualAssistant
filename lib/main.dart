import 'package:assist/pallete.dart';
import 'package:flutter/material.dart';

import 'Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assist',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Cera Pro'),
        ),
      ),
      home: const HomePage(),
    );
  }
}
