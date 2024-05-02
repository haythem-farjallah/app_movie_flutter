import 'package:app_movie_final/pages/favorites_screen.dart';
import 'package:app_movie_final/pages/home_screen.dart';
import 'package:app_movie_final/pages/login_screen.dart';
import 'package:app_movie_final/pages/profileEditScreen.dart';
import 'package:app_movie_final/pages/profileScreen.dart';
import 'package:app_movie_final/pages/register_screen.dart';
import 'package:app_movie_final/providers/auth_provider.dart';
import 'package:app_movie_final/providers/movie_details_provider.dart';
import 'package:app_movie_final/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(create: (context) => MovieDetailsProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Movie Search App',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          hintColor: Colors.cyan[600],
          fontFamily: 'Georgia',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(171, 0, 0, 0),
            foregroundColor: Colors.white,
            elevation: 5,
            centerTitle: true,
          ),
          textTheme: const TextTheme(
            displayLarge:
                TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        initialRoute: '/register',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          "/edit": (context) => ProfileEditScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/register': (context) => const RegisterScreen(),
          '/favorites': (context) => const FavoritesScreen(),
        },
      ),
    );
  }
}
