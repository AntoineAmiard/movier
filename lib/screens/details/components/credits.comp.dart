import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/models/people.models.dart';

class Credits extends StatelessWidget {
  final List<Credit> credits;

  Credits({this.credits});
  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          child: Text(
            "L'équipe",
            style: textStyle.title,
          ),
          padding: EdgeInsets.only(bottom: 10),
        ),
        Container(
          constraints: BoxConstraints(minHeight: 100, maxHeight: 170),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: credits.length,
            itemBuilder: (BuildContext context, int index) {
              Credit credit = credits[index];
              return Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        child: _buildAvatar(credit.profilePath),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          credit.name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        credit.jobCharacter,
                        style: textStyle.caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String profile) {
    return CachedNetworkImage(
      imageUrl: "https://image.tmdb.org/t/p/w780/$profile",
      imageBuilder: (context, image) {
        return CircleAvatar(
          backgroundImage: image,
        );
      },
      filterQuality: FilterQuality.high,
      placeholderFadeInDuration: Duration(seconds: 1),
      errorWidget: (context, string, object) {
        return Opacity(
          opacity: 0.6,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: Colors.white)),
            child: Icon(
              Icons.person,
              size: 40,
            ),
          ),
        );
      },
      placeholder: (context, string) {
        return Center(
          child: Icon(Icons.person),
        );
      },
    );
  }
}
