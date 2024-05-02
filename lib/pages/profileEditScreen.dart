import 'package:app_movie_final/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  void _loadUserData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserData();
    // Now that data is loaded, update the controllers with actual values.
    _usernameController.text = authProvider.username;
    _emailController.text = authProvider.email;
    _phoneController.text = authProvider.phoneNumber;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void updateProfile() {
    if (_formKey.currentState!.validate()) {
      Provider.of<AuthProvider>(context, listen: false)
          .updateProfile(
              username: _usernameController.text,
              email: _emailController.text,
              phone: _phoneController.text)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully!')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update profile')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
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
                      controller: _usernameController,
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Write your email please",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                          fontSize: 20,
                        ),
                        hintMaxLines: 2,
                        prefixIcon: Icon(Icons.email),
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
                      controller: _phoneController,
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
                      onPressed: () {
                        updateProfile();
                      },
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
      ),
    );
  }
}
