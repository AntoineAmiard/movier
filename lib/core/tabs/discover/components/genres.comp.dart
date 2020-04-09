import 'package:flutter/material.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/screens/list-by-genre/movie.screen.dart';
import 'package:movie_helper/screens/list-by-genre/tv.screen.dart';

class Genres extends StatelessWidget {
  final List<Genre> genres;
  final String mediaType;

  Genres({this.genres, this.mediaType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: genres.length,
      itemBuilder: (BuildContext context, index) {
        Genre genre = genres[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            child: GenreItem(name: genre.name, index: index),
            onTap: () => onTap(genre, context),
          ),
        );
      },
    );
  }

  void onTap(Genre genre, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (mediaType == "movie")
            return MovieListByGenre(genre: genre);
          else if (mediaType == "tv") return TvListByGenre(genre: genre);
        },
        maintainState: true,
      ),
    );
  }
}

class GenreItem extends StatelessWidget {
  final int index;
  final String name;
  final List<MaterialColor> colors = [
    Colors.cyan,
    Colors.indigo,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.deepPurple
  ];

  GenreItem({this.name, this.index});

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    MaterialColor color = colors[index % this.colors.length];
    return Container(
      height: 100,
      width: 200,
      child: Center(
        child: Text(this.name,
            textAlign: TextAlign.center, style: textStyle.headline),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            color[500],
            color[700],
          ],
        ),
      ),
    );
  }
}
