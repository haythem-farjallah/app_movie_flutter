import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _token = ''; // Token storage

  bool get isLoggedIn => _isLoggedIn;

  String get token => _token;

  Future<bool> login(String email, String password) async {
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/users/login');
    print({'email': email, 'password': password});
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        _token = responseData['token']; // Save the token
        _isLoggedIn = true;
        var userData = responseData['data'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('username', userData['username']);
        await prefs.setString('email', userData['email']);
        if (userData.containsKey('phone')) {
          await prefs.setString('phone', userData['phone'].toString());
        }
        notifyListeners();
        return true; // Return true to indicate successful login
      } else {
        return false; // Return false as login failed
      }
    } catch (e) {
      print('Failed to login: $e'); // This will print the error message

      return false; // Return false as an exception occurred
    }
  }

  Future<bool> register(String username, String email, String password) async {
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/users/signup');
    print({'username': username, 'email': email, 'password': password});
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        notifyListeners();
        return true; // Return true to indicate successful registration
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        return false; // Return false as registration failed
      }
    } catch (e) {
      print('Failed to register: $e'); // This will print the error message
      return false; // Return false as an exception occurred
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('phone'); // Remove if exists, no error if it doesn't

    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve the login token
    _isLoggedIn = token != null &&
        token
            .isNotEmpty; // If token is not null or empty, user is considered logged in
    notifyListeners(); // Notify listeners about change in login state
  }

  String _username = '';
  String _email = '';
  String _phoneNumber = 'No phone number';

  // Getters for user data
  String get username => _username;

  String get email => _email;

  String get phoneNumber => _phoneNumber;

  // Method to load user data from shared preferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    _username = prefs.getString('username') ?? 'Unknown';
    _email = prefs.getString('email') ?? 'No email';
    _phoneNumber = prefs.getString('phone') ?? 'No phone number';
    notifyListeners();
  }

  Future<bool> updateProfile(
      {String? username, String? email, String? phone}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print("No token found");
      return false;
    }

    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/users/update-profile');
    Map<String, dynamic> dataToUpdate = {};
    if (username != null) dataToUpdate['username'] = username;
    if (email != null) dataToUpdate['email'] = email;
    if (phone != null) dataToUpdate['phone'] = phone;

    try {
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(dataToUpdate),
      );

      if (response.statusCode == 200) {
        // Update shared preferences if necessary
        if (username != null) prefs.setString('username', username);
        if (email != null) prefs.setString('email', email);
        if (phone != null) prefs.setString('phone', phone);

        notifyListeners();
        return true;
      } else {
        print("Failed to update user profile: ${response.body}");
        return false;
      }
    } catch (e) {
      print('Failed to update profile: $e');
      return false;
    }
  }

  Future<bool> sendForgetPasswordEmail(String email) async {
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/users/sendEmail');

    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        return true;
      } else {
        // Handle failure
        print('Failed to send email: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  Future<bool> verifyCode(String code) async {
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/users/verify');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'code': code}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to verify code: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error verifying code: $e');
      return false;
    }
  }

  Future<bool> resetPassword(String newPassword, String code) async {
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/users/forgetpassword');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'password': newPassword, 'code': code}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to reset password: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error resetting password: $e');
      return false;
    }
  }
}
