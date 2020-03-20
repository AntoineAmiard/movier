import 'package:flutter/material.dart';
import 'package:movie_helper/models/genres.models.dart';

class GenreMovieWrap extends StatelessWidget {
  final List<Genre> genres;

  GenreMovieWrap({this.genres});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: genres
            .map(
              (Genre genre) => Padding(
                padding: EdgeInsets.only(right: 5),
                child: Chip(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent,
                  label: Text(genre.name),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
