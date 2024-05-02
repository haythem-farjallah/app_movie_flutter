import 'dart:convert';

class Favorite {
  final String imageUrl;
  final String title;
  final String imdbID;
  final double rating;

  Favorite({
    required this.imageUrl,
    required this.title,
    required this.imdbID,
    required this.rating,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      imageUrl: json['imageUrl'],
      title: json['title'],
      imdbID: json['imdbID'],
      rating: json['rating'],
    );
  }
}

List<Favorite> parseFavorites(String responseBody) {
  final parsed = jsonDecode(responseBody);
  final List<dynamic> favoriteMoviesData = parsed['data'];
  return favoriteMoviesData
      .map<Favorite>((json) => Favorite.fromJson(json))
      .toList();
}
