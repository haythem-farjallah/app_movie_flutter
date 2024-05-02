import 'package:app_movie_final/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  var usernames;
  var password;
  var email;
  @override
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    send() async {
      var formData = formstate.currentState;
      if (formData != null && formData.validate()) {
        formData.save();
        bool success = await Provider.of<AuthProvider>(context, listen: false)
            .register(usernames, email, password);

        if (success) {
          // If signup is successful, navigate to the login screen
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Registration sucess")));
          Navigator.pushReplacementNamed(context, '/');
        } else {
          // Show an error message or handle the failure
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Registration failed, please try again.")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Form is not valid")));
      }
    }

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
            child: Form(
              key: formstate,
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
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Text("Enter your credential to Register"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        onSaved: (text) {
                          usernames = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "Write your name please",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(31, 249, 247, 247),
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
                          email = text;
                        },
                        decoration: const InputDecoration(
                          hintText: "Write your email please",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(31, 249, 247, 247),
                              fontSize: 20),
                          hintMaxLines: 2,
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: "Email",
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
                            return "Email can't be empty";
                          }
                          if (text.trim().length < 2) {
                            return "Email can't be less than 2 characters";
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
                        decoration: const InputDecoration(
                          hintText: "Write your password please",
                          hintStyle: TextStyle(
                            color: Colors.black12,
                            fontSize: 20,
                          ),
                          hintMaxLines: 2,
                          prefixIcon: Icon(Icons.lock_clock_outlined),
                          labelText: "password",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                          filled: false,
                          fillColor: Color.fromARGB(255, 233, 229, 229),
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
                        onPressed: () async {
                          await send();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor:
                              const Color.fromARGB(255, 158, 20, 20),
                        ),
                        child: const Text(
                          "Register",
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
                      style:
                          TextStyle(color: Color.fromARGB(255, 200, 186, 186)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont you  have an account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
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
            )),
      ),
    );
  }
}
