import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/models/season.models.dart';
import 'package:movie_helper/screens/details/season.screen.dart';

class SeasonsList extends StatelessWidget {
  final List<SeasonOverview> seasons;
  final int tvId;

  SeasonsList({this.seasons, this.tvId});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Saisons",
          style: textStyle.title,
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: seasons.length,
          itemBuilder: (BuildContext context, int index) {
            SeasonOverview season = this.seasons[index];
            return GestureDetector(
              onTap: () => onSeasonTap(tvId, season.seasonNumber, context),
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  width: double.infinity,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    leading: Container(
                      height: 100,
                      width: 40,
                      margin: EdgeInsets.all(3),
                      child: _buildPoster(season.posterPath),
                    ),
                    title: Text(season.name),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  void onSeasonTap(int id, int seasonNumber, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeasonDetailsScreen(
          id: id,
          seasonNumber: seasonNumber,
        ),
      ),
    );
  }

  Widget _buildPoster(String poster) {
    return CachedNetworkImage(
      imageUrl: "https://image.tmdb.org/t/p/w500$poster",
      imageBuilder: (context, image) {
        return ClipRRect(
          child: Image(
            image: image,
            // fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(3),
        );
      },
      errorWidget: (context, string, object) {
        return Opacity(
          opacity: 0.5,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
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
