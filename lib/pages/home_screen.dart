import 'package:app_movie_final/pages/MovieDetailScreen.dart';
import 'package:app_movie_final/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "Star Wars"; // Default search term
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch movies as soon as the widget is built and rendered
      Provider.of<MovieProvider>(context, listen: false)
          .fetchMovies(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/favorites');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) =>
                  Provider.of<MovieProvider>(context, listen: false)
                      .fetchMovies(value),
              decoration: InputDecoration(
                labelText: 'Search Movies',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (context, provider, child) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: provider.movies.length,
                  itemBuilder: (context, index) {
                    final movie = provider.movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailsScreen(imdbId: movie.imdbID),
                          ),
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              movie.poster,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 200,
                                color: Colors.grey,
                                child: Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Text('${movie.year} (${movie.type})'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
