import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/models/overview.models.dart';

class MovieCredits extends StatelessWidget {
  final List<Overview> credits;

  MovieCredits({this.credits});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          child: Text(
            "L'équipe",
            style: TextStyle(fontSize: 20),
          ),
          padding: EdgeInsets.only(bottom: 10),
        ),
        Container(
          constraints: BoxConstraints(minHeight: 100, maxHeight: 170),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: credits.length,
            itemBuilder: (BuildContext context, int index) {
              Overview item = credits[index];
              return Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.8,
                        child: item.posterPath != null
                            ? CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/w780/${item.posterPath}",
                                imageBuilder: (context, image) {
                                  return Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(90)),
                                      image: DecorationImage(
                                        image: image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                filterQuality: FilterQuality.high,
                                height: 100,
                                width: 100,
                                placeholderFadeInDuration: Duration(seconds: 1),
                                placeholder: (context, url) => SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: Icon(Icons.person,
                                          size: 40, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.purpleAccent[100],
                                child: Icon(
                                  Icons.person,
                                  size: 55,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          item.jobCharacter,
                          textAlign: TextAlign.center,
                        ),
                      )
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
}
