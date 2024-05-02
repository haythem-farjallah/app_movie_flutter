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
    var url = Uri.parse('http://10.0.2.2:8000/api/v1/users/login');
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
    var url = Uri.parse('http://10.0.2.2:8000/api/v1/users/signup');
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

    var url = Uri.parse('http://10.0.2.2:8000/api/v1/users/update-profile');
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

  Future<void> performAuthenticatedRequest(String apiUrl) async {
    var url = Uri.parse(apiUrl);
    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      // Handle your response here
    } catch (e) {
      throw Exception('Failed to make authenticated request');
    }
  }
}
