import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/discover/components/overview-item.comp.dart';
import 'package:movie_helper/models/TV.models.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/overview.models.dart';
import 'package:movie_helper/services/http.service.dart';

class HorizontalOverviewList extends StatelessWidget {
  final List<Overview> list;

  HorizontalOverviewList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        Overview item = list[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: OverviewItem(name: item.title, posterPath: item.posterPath),
        );
      },
    );
  }
}
