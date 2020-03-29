import 'package:flutter/material.dart';
import 'package:movie_helper/models/season.models.dart';
import 'package:movie_helper/screens/season-details/season-details.screen.dart';

class SeasonsOverviewList extends StatelessWidget {
  final List<SeasonOverview> seasons;
  final int tvId;

  SeasonsOverviewList({this.seasons, this.tvId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Saisons",
          style: TextStyle(fontSize: 20),
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
                    leading: Image.network(
                      "https://image.tmdb.org/t/p/w780/${season.posterPath}",
                      fit: BoxFit.contain,
                      // height: 100,
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
    print("id : $id - season : $seasonNumber");
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
}
