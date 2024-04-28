import 'dart:ffi';

import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  var usernames;
  var email;
  var phone;
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
        print("password: $email");
      } else {
        return "not valid";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/netflix.png", width: 100),
      ),
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
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ignore: prefer_const_constructors
              SizedBox(height: 40),
              Stack(
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            const Image(image: AssetImage("images/man.png"))),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 255, 20, 3)),
                      child: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 243, 238, 238),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
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
                      email = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Write your email please",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
                      ),
                      hintMaxLines: 2,
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Email",
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
                  SizedBox(height: 10),
                  TextFormField(
                    onSaved: (text) {
                      phone = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Write your phone please",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
                      ),
                      hintMaxLines: 2,
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Phone",
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
                      "Edit",
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
