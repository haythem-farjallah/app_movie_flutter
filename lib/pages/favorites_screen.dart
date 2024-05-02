import 'package:app_movie_final/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch favorites once when the widget is initialized
    Future.microtask(() =>
        Provider.of<MovieProvider>(context, listen: false).fetchFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.favoriteMovies.isEmpty) {
            return const Center(child: Text("No favorites added yet."));
          }
          return ListView.builder(
            itemCount: provider.favoriteMovies.length,
            itemBuilder: (context, index) {
              final favorite = provider.favoriteMovies[index];
              return ListTile(
                leading: Image.network(
                  favorite.imageUrl,
                  width: 50,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
                title: Text(favorite.title),
                subtitle: favorite.rating != null
                    ? Text("Rating: ${favorite.rating}")
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Implement functionality to delete this favorite when needed
                  },
                ),
                onTap: () {
                  // Optional: Implement functionality for tap if needed
                },
              );
            },
          );
        },
      ),
    );
  }
}
