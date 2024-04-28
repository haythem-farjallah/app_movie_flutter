import 'package:app_movie_final/pages/favorites_screen.dart';
import 'package:app_movie_final/pages/home_screen.dart';
import 'package:app_movie_final/pages/login_screen.dart';
import 'package:app_movie_final/pages/profileEditScreen.dart';
import 'package:app_movie_final/pages/profileScreen.dart';
import 'package:app_movie_final/providers/movie_details_provider.dart';
import 'package:app_movie_final/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(create: (context) => MovieDetailsProvider()),
      ],
      child: MaterialApp(
        title: 'Movie Search App',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          hintColor: Colors.cyan[600],
          fontFamily: 'Georgia',
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(171, 0, 0, 0),
            foregroundColor: Colors.white,
            elevation: 5,
            centerTitle: true,
            
            
          ),
          textTheme: TextTheme(
            displayLarge:
                TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        initialRoute: '/edit',
        routes: {
          '/': (context) => LoginScreen(),
          '/profile': (context) => ProfileScreen(),
          '/edit': (context) => ProfileEditScreen(),
          '/home': (context) => HomeScreen(),
          '/favorites': (context) => FavoritesScreen(),
        },
      ),
    );
  }
}
