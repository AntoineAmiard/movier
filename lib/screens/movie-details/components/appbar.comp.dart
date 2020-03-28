import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieAppBar extends StatelessWidget {
  final String title;
  final String posterPath;

  MovieAppBar({this.title, this.posterPath});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Icon(Icons.arrow_back),
      stretch: true,
      pinned: true,
      backgroundColor: Colors.purpleAccent[100],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(),
      ),
      expandedHeight: 220,
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          centerTitle: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(60, 0, 0, 30),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(title),
            ),
          )),
    );
  }
}
