import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieDetailsProvider with ChangeNotifier {
  Map<String, dynamic> _movieDetails = {};
  bool _isLoading = true;

  Map<String, dynamic> get movieDetails => _movieDetails;

  bool get isLoading => _isLoading;

  // This should be securely stored and retrieved
  final String _apiKey = '7e3b5a28';

  Future<void> fetchMovieDetails(String imdbId) async {
    _isLoading = true;
    notifyListeners();
    final String apiKey = '7e3b5a28';
    final String url = 'http://www.omdbapi.com/?i=$imdbId&apikey=$apiKey';

    print("Requesting: $url");

    try {
      final response = await http.get(Uri.parse(url));
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        _movieDetails = json.decode(response.body);
        _isLoading = false;
        notifyListeners();
      } else {
        print(
            'Failed to load movie details with status code: ${response.statusCode}');
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Failed to load movie details: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
}
