import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(
          child: Text("Login"),
          onPressed: () {
            // Simulate a login process
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
    );
  }
}