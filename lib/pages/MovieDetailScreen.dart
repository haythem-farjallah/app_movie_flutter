import 'package:app_movie_final/providers/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String imdbId;

  MovieDetailsScreen({required this.imdbId});

  @override
  Widget build(BuildContext context) {
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .fetchMovieDetails(imdbId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: Consumer<MovieDetailsProvider>(
        builder: (context, provider, child) {
          var details = provider.movieDetails;
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(details['Poster'], fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(details['Title'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(details['Plot']),
                ),

                // Add more widgets as needed for other details
              ],
            ),
          );
        },
      ),
    );
  }
}
