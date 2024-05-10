import 'package:app_movie_final/pages/login_screen.dart';
import 'package:app_movie_final/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                1, // Set the maximum height to 80% of the screen height
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ignore: prefer_const_constructors
              Column(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 60),
                      child: Image.asset(
                        "images/logo.png",
                        width: 100, // Set the desired width
                        height: 100, // Set the desired height
                      ),
                    ),
                  ),
                  const Text(
                    "Welcome To Netflexy",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                      "To start our application, please click on the button"),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      )
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 60),
                      backgroundColor: Color.fromARGB(255, 178, 0, 0),
                    ),
                    child: const Text(
                      "Start App",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
