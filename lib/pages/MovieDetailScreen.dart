import 'package:app_movie_final/providers/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String imdbId;

  const MovieDetailsScreen({super.key, required this.imdbId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MovieDetailsProvider>(context, listen: false)
            .fetchMovieDetails(widget.imdbId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: Consumer<MovieDetailsProvider>(
        builder: (context, provider, child) {
          var details = provider.movieDetails;
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(details['Poster'], fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(details['Title'],
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(details['Plot']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
