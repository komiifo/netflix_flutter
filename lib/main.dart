import 'package:flutter/material.dart';
import 'package:netflix_flutter/screens/home_screen.dart';
import 'package:netflix_flutter/screens/movie_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Netflix',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/movie': (context) => const MovieScreen()
      },
    );
  }
}
