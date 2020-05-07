import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/models/movie.models.dart';
import 'package:movie_helper/models/tv.models.dart';
import 'package:movie_helper/screens/details/movie.screen.dart';
import 'package:movie_helper/screens/details/tv.screen.dart';

class Similar {
  final int id;
  final String title;
  final String poster;
  final String mediaType;

  Similar({this.id, this.poster, this.title, this.mediaType});
}

class Similars extends StatelessWidget {
  final List<Similar> similars;

  Similars({this.similars});

  factory Similars.fromMovie({List<MovieOverview> movies}) {
    return Similars(
      similars: movies
          .map((MovieOverview item) => Similar(
              id: item.id,
              title: item.title,
              poster: item.posterPath,
              mediaType: "movie"))
          .toList(),
    );
  }

  factory Similars.fromTv({List<TvOverview> tvs}) {
    return Similars(
      similars: tvs
          .map((TvOverview item) => Similar(
              id: item.id,
              title: item.title,
              poster: item.posterPath,
              mediaType: "tv"))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Titres similaires',
            style: textStyle.title,
          ),
        ),
        similars.length != 0
            ? Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: similars.length,
                  itemBuilder: (context, index) {
                    Similar similar = similars[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        child: SimilarItem(
                            name: similar.title, posterPath: similar.poster),
                        onTap: () => onSimilarTap(
                            similar.id, similar.mediaType, context),
                      ),
                    );
                  },
                ),
              )
            : Container(
                height: 220,
                child: Center(
                  child: Text("Aucun resultats trouvés"),
                ),
              ),
      ],
    );
  }

  void onSimilarTap(int id, String mediaType, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (mediaType == "movie")
            return MovieDetailsScreen(
              id: id,
            );
          else if (mediaType == "tv") return TvDetailsScreen(id: id);
        },
        maintainState: true,
      ),
    );
  }
}

class SimilarItem extends StatelessWidget {
  final String name;
  final String posterPath;

  SimilarItem({this.name, this.posterPath});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;

    return Container(
      height: 240,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 220,
            width: 150,
            child: _buildPoster(this.posterPath),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.name,
            style: textStyle.subtitle,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _buildPoster(String poster) {
    return CachedNetworkImage(
      imageUrl: "https://image.tmdb.org/t/p/w780/$poster",
      imageBuilder: (context, image) {
        return ClipRRect(
          child: Image(
            image: image,
            // fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(5),
        );
      },
      filterQuality: FilterQuality.high,
      placeholderFadeInDuration: Duration(seconds: 1),
      errorWidget: (context, string, object) {
        return Opacity(
          opacity: 0.5,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white)),
            child: Icon(Icons.image),
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
}
