import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OverviewItem extends StatelessWidget {
  final String name;
  final String posterPath;

  OverviewItem({this.name, this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w780/${this.posterPath}",
            imageBuilder: (context, image) {
              return Container(
                height: 240,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            filterQuality: FilterQuality.high,
            height: 220,
            width: 150,
            placeholderFadeInDuration: Duration(seconds: 1),
            placeholder: (context, url) => SizedBox(
              height: 220,
              width: 150,
              child: Container(
                height: 220,
                width: 150,
                child: Center(
                  child: Icon(Icons.local_movies, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
