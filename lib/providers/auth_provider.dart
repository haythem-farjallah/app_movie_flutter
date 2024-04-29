import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  Future<bool> signUp(String email, String password, String username) async {
    print('Type of email: ${email.runtimeType}');
    print('Type of password: ${password.runtimeType}');

    try {
      final AuthResponse response = await _client.auth.signUp(
          email: email, password: password, data: {'username': username});
      print("Signup response: $response");

      if (response.user != null) {
        print(
            'Registration successful. User ID: ${response.user!.id}, Username: ${response.user!.userMetadata?['username']}');
        notifyListeners();
        return true;
      } else {
        print('Registration failed: No user data received.');
        return false;
      }
    } catch (error) {
      print('Registration failed: $error');
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final AuthResponse res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print(res);
      // if (res != null) {
      //   // Correctly handle the case where there is an error
      //   print('Login failed: ${res}');
      //   return false;
      // }

      if (res.user != null) {
        // Correctly handle the success case
        print('Login successful. User ID: ${res.user!.id}');
        notifyListeners(); // Notify listeners of a successful login
        return true;
      } else {
        // This should theoretically never happen if error is null and user is null
        print('Login failed: No user data received.');
        return false;
      }
    } catch (error) {
      // Properly catch and handle any thrown errors
      print('Login failed: $error');
      return false;
    }
  }
}
