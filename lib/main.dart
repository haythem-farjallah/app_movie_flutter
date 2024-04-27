import 'package:app_movie_final/pages/favorites_screen.dart';
import 'package:app_movie_final/pages/home_screen.dart';
import 'package:app_movie_final/pages/login_screen.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search App',
      theme: ThemeData(

        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        hintColor: Colors.cyan[600],
        fontFamily: 'Georgia',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 5,
        ),

        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
