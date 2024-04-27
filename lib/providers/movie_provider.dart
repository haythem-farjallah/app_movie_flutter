import 'dart:convert';

import 'package:app_movie_final/Entity/Movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  Future<void> fetchMovies(String query) async {
    if (query.isEmpty) {
      _movies = [];
      notifyListeners();
      return;
    }

    final String apiKey = '7e3b5a28';
    final String url = 'http://www.omdbapi.com/?s=$query&apikey=$apiKey';

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
      throw error;
    }
  }
}
