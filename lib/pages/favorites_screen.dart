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
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.red,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.favoriteMovies.isEmpty) {
            return const Center(child: Text("No favorites added yet."));
          }
          return ListView.builder(
            itemCount: provider.favoriteMovies.length,
            itemBuilder: (context, index) {
              final favorite = provider.favoriteMovies[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    favorite.imageUrl,
                    width: 50,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(
                    favorite.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  subtitle: favorite.rating != null
                      ? Text("Rating: ${favorite.rating}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ))
                      : null,
                  trailing: Container(
                    padding: EdgeInsets.all(0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(100),
                      color: Color.fromARGB(97, 66, 67, 66),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Implement functionality to delete this favorite when needed
                      },
                    ),
                  ),
                  onTap: () {
                    // Optional: Implement functionality for tap if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
