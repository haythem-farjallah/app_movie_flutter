import 'package:app_movie_final/providers/movie_details_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String imdbId;

  MovieDetailsScreen({required this.imdbId});

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
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/netflix.png", width: 100),
      ),
      body: Consumer<MovieDetailsProvider>(
        builder: (context, provider, child) {
          var details = provider.movieDetails;
          var ratings = details["Ratings"].firstWhere((rating) =>
              rating["Source"] == "Internet Movie Database")["Value"];
          var doubleRating = double.parse(ratings.split("/").first) / 2;
          print(doubleRating.toInt());
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.network(details['Poster'], fit: BoxFit.cover),
                      // SizedBox(
                      //   width: media.width,
                      //   height: media.width * 1.35,
                      //   child: ClipRect(
                      //     child: Image.network(
                      //       details['Poster'],
                      //       width: media.width,
                      //       height: media.width,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      details['Title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: RatingBar(
                      initialRating: doubleRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 18,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                        full: Image.asset("images/starfill.png"),
                        half: Image.asset("images/star.png"),
                        empty: Image.asset("images/star.png"),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      backgroundColor: Color.fromARGB(255, 158, 20, 20),
                    ),
                    child: Text(
                      "Add To Favorite",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    width: double.infinity,
                    child: Text(
                      "Genre : " + details['Genre'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 213, 213, 213),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    width: double.infinity,
                    child: Text(
                      "Released : " + details['Released'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 213, 213, 213),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    width: double.infinity,
                    child: Text(
                      "Director : " + details['Director'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 213, 213, 213),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    width: double.infinity,
                    child: Text(
                      "Language : " + details['Language'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 213, 213, 213),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(details['Plot']),
                  ),
                ]),

           
          );
        },
      ),
    );
  }
}
