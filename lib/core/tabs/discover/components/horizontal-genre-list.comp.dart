import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/discover/components/genre-item.comp.dart';
import 'package:movie_helper/models/genres.models.dart';

class HorizontalGenreList extends StatelessWidget {
  final List<Genre> list;

  HorizontalGenreList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, index) {
          Genre genre = list[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: GenreItem(name: genre.name, index: index),
          );
        });
  }
}
