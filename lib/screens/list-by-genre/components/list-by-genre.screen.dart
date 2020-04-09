import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/tv.models.dart';
import 'package:movie_helper/screens/details/movie.screen.dart';
import 'package:movie_helper/screens/details/tv.screen.dart';

class Media {
  final int id;
  final String title;
  final String poster;
  final dynamic voteAverage;
  final String overview;

  Media({
    this.id,
    this.overview,
    this.poster,
    this.title,
    this.voteAverage,
  });
}

class ListByGenre extends StatelessWidget {
  final Genre genre;
  final String mediaType;
  final List<Media> medias;

  ListByGenre({this.genre, this.mediaType, this.medias});

  factory ListByGenre.fromMovie({List<MovieOverview> movies}) {
    return ListByGenre(
      medias: movies
          .map(
            (MovieOverview item) => Media(
                id: item.id,
                title: item.title,
                poster: item.posterPath,
                voteAverage: item.voteAverage,
                overview: item.overview),
          )
          .toList(),
      mediaType: "movie",
    );
  }

  factory ListByGenre.fromTv({List<TvOverview> tvs}) {
    return ListByGenre(
      medias: tvs
          .map((TvOverview item) => Media(
              id: item.id,
              title: item.title,
              poster: item.posterPath,
              voteAverage: item.voteAverage,
              overview: item.overview))
          .toList(),
      mediaType: "tv",
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medias.length,
      itemBuilder: (context, index) {
        Media item = medias[index];
        return GestureDetector(
          child: Card(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 175,
                    width: 115,
                    child: _buildPoster(item.poster),
                  ),
                  Expanded(
                    child: Container(
                      height: 175,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                item.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.subtitle,
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.stars,
                                        size: 16,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    TextSpan(
                                        text:
                                            " ${item.voteAverage ?? null} / 10"),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  item.overview ?? "null",
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.body1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () => _onCardTap(item.id, context),
        );
      },
    );
  }

  Widget _buildPoster(String poster) {
    return CachedNetworkImage(
      imageUrl: "https://image.tmdb.org/t/p/w500$poster",
      imageBuilder: (context, image) {
        return ClipRRect(
          child: Image(
            image: image,
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(5),
          // fit: BoxFit.fill,
        );
      },
      errorWidget: (context, string, object) {
        return Opacity(
          opacity: 0.7,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Text(
                  "Erreur de chargement de l'image",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
      placeholder: (context, string) {
        return Center(
          child: Icon(Icons.image),
        );
      },
    );
  }

  void _onCardTap(int id, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (mediaType == "movie")
            return MovieDetailsScreen(id: id);
          else if (mediaType == "tv") return TvDetailsScreen(id: id);
        },
        maintainState: true,
      ),
    );
  }

  void _onBackTap(context) {
    Navigator.pop(context);
  }
}
