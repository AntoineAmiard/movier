import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/tv.models.dart';
import 'package:movie_helper/screens/details/movie.screen.dart';
import 'package:movie_helper/screens/details/tv.screen.dart';

class Media {
  final int id;
  final String title;
  final String poster;

  Media({
    this.id,
    this.poster,
    this.title,
  });
}

class DiscoverList extends StatelessWidget {
  final List<Media> medias;
  final String mediaType;

  DiscoverList({this.medias, this.mediaType});

  factory DiscoverList.fromMovie({List<MovieOverview> movies}) {
    return DiscoverList(
      medias: movies
          .map((MovieOverview item) =>
              Media(id: item.id, title: item.title, poster: item.posterPath))
          .toList(),
      mediaType: "movie",
    );
  }

  factory DiscoverList.fromTv({List<TvOverview> tvs}) {
    return DiscoverList(
      medias: tvs
          .map((TvOverview item) =>
              Media(id: item.id, title: item.title, poster: item.posterPath))
          .toList(),
      mediaType: "tv",
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: medias.length,
      itemBuilder: (context, index) {
        Media item = medias[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            child: Item(name: item.title, posterPath: item.poster),
            onTap: () {
              mediaType == "movie"
                  ? onMovieTap(item.id, context)
                  : onTvTap(item.id, context);
            },
          ),
        );
      },
    );
  }

  void onTvTap(int id, context) {
    print("-> TV - id : $id");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TvDetailsScreen(
          id: id,
        ),
      ),
    );
  }

  void onMovieTap(int id, context) {
    print("-> MOVIE - id : $id");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(
          id: id,
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String name;
  final String posterPath;

  Item({this.name, this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 220,
              width: 150,
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w780${posterPath}",
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
                    child:
                        Icon(Icons.local_movies, size: 40, color: Colors.grey),
                  );
                },
              )),
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

  Widget _buildPoster(String poster) {
    return CachedNetworkImage(
      imageUrl: "https://image.tmdb.org/t/p/w780$poster",
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
          child: Icon(Icons.local_movies, size: 40, color: Colors.grey),
        );
      },
    );
  }
}
