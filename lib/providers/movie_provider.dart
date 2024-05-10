import 'dart:convert';

import 'package:app_movie_final/Entity/Favorite.dart';
import 'package:app_movie_final/Entity/Movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;
  List<Favorite> favoriteMovies = [];

  Future<void> fetchMovies(String query) async {
    const String apiKey = '7e3b5a28';
    String url = 'http://www.omdbapi.com/?s=$query&apikey=$apiKey';
    if (query.isEmpty || query.length < 3) {
      url = 'http://www.omdbapi.com/?s=star&apikey=$apiKey';
    }
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        if (data['Response'] == 'True') {
          List<dynamic> results = data['Search'];
          _movies = results.map((result) => Movie.fromJson(result)).toList();
        } else {
          _movies = [];
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
      notifyListeners();
    } catch (error) {
      print('Error fetching movies: $error');
      _movies = [];
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> addFavorite(
      String imageUrl, String title, String imdbID, double rating) async {
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/favorite/add');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print("No token found");
      return false;
    }

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token' // Corrected here
        },
        body: json.encode({
          'imageUrl': imageUrl,
          'title': title,
          'imdbID': imdbID,
          "rating": rating
        }),
      );

      if (response.statusCode == 201) {
        // Handle successful response
        notifyListeners();
        return true;
      } else {
        // Handle error response
        print('Failed to add favorite: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error adding favorite: $e');
      return false;
    }
  }

  Future<bool> deleteFavorite(String imdbID) async {
    // Construct the URL with the imdbID as a path parameter
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/favorite/delete/$imdbID');

    // Retrieve the stored token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // Check if the token is available
    if (token == null) {
      print("No token found");
      return false;
    }

    try {
      // Send the DELETE request
      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Handle successful response
        notifyListeners();
        return true;
      } else {
        // Handle error response
        print('Failed to delete favorite: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exceptions
      print('Error deleting favorite: $e');
      return false;
    }
  }

  Future<void> fetchFavorites() async {
    var url = Uri.parse(
        'https://movieappbackend-e497.onrender.com/api/v1/favorite/all');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print("No token found");
      favoriteMovies = []; // Clear the list if no token is found
      notifyListeners();
      return;
    }

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response JSON into a list of Favorite objects
        favoriteMovies = parseFavorites(response.body);
        notifyListeners(); // Notify listeners to update the UI
      } else {
        // Handle error response
        print('Failed to fetch favorites: ${response.body}');
        favoriteMovies = [];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      favoriteMovies = [];
      notifyListeners();
    }
  }
}
