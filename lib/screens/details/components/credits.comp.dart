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
                      Opacity(
                        opacity: 0.8,
                        child: credit.profilePath != null
                            ? CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/w780/${credit.profilePath}",
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
}
