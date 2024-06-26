import 'package:app_movie_final/pages/sendEmailPass_screen.dart';
import 'package:app_movie_final/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var email;
  var password;
  @override
  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    send() async {
      var formData = formstate.currentState;
      if (formData != null && formData.validate()) {
        formData.save();
        bool result = await Provider.of<AuthProvider>(context, listen: false)
            .login(email, password);

        if (result) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("error")));
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text("Enter your credential to login"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        prefixIcon: Icon(Icons.account_circle_outlined),
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
                      decoration: const InputDecoration(
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
                        backgroundColor: const Color.fromARGB(255, 158, 20, 20),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SendEmailPassScreen()),
                    )
                  },
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
                          Navigator.pushReplacementNamed(context, '/register');
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
      ),
    );
  }
}
