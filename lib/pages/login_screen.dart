import 'dart:ffi';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var usernames;
  var password;
  @override
  GlobalKey<FormState> formstate = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    send() {
      var formdata = formstate.currentState;
      if (formdata != null && formdata.validate()) {
        formdata.save();
        // ignore: avoid_print
        print("username: $usernames");
        // ignore: avoid_print
        print("password: $password");
      } else {
        return "not valid";
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                1, // Set the maximum height to 80% of the screen height
          ),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ignore: prefer_const_constructors
              Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, top: 60),
                      child: Image.asset(
                        "images/logo.png",
                        width: 100, // Set the desired width
                        height: 100, // Set the desired height
                      ),
                    ),
                  ),
                  Text(
                    "Welcome To Netflexy",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text("Enter your credential to login"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onSaved: (text) {
                      usernames = text;
                    },
                    decoration: InputDecoration(
                      hintText: "Write your name please",
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(31, 249, 247, 247),
                          fontSize: 20),
                      hintMaxLines: 2,
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      labelText: "username",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                      filled: false,
                      fillColor: Color.fromARGB(255, 227, 27, 27),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "username can't be empty";
                      }
                      if (text.trim().length < 2) {
                        return "username can't be less than 2 characters";
                      }
                      return null;
                    },
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 10),
                  TextFormField(
                    onSaved: (text) {
                      password = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Write your password please",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
                      ),
                      hintMaxLines: 2,
                      prefixIcon: Icon(Icons.lock),
                      labelText: "password",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                      filled: false,
                      fillColor: const Color.fromARGB(255, 233, 229, 229),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Text can't be empty";
                      }
                      if (text.trim().length < 2) {
                        return "Text can't be less than 2 characters";
                      }
                      return null;
                    },
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Color.fromARGB(255, 158, 20, 20),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Color.fromARGB(255, 200, 186, 186)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont have an account? "),
                  TextButton(
                      onPressed: () {
            },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
