import 'package:flutter/material.dart';
import 'package:movie_helper/core/home.screen.dart';
import 'package:movie_helper/core/tabs/search/Search-bar-focus.screen.dart';
import 'package:movie_helper/core/tabs/search/search.view.dart';
import 'package:movie_helper/models/genres.models.dart';
import 'package:movie_helper/screens/details/movie.screen.dart';
import 'package:movie_helper/screens/details/season.screen.dart';
import 'package:movie_helper/screens/details/tv.screen.dart';
import 'package:movie_helper/screens/list-by-genre/movie.screen.dart';
import 'package:movie_helper/screens/list-by-genre/tv.screen.dart';
import 'package:movie_helper/screens/login/components/Google-button.comp.dart';
import 'package:movie_helper/screens/login/login.screen.dart';
import 'package:movie_helper/screens/root/root.screen.dart';
import 'package:movie_helper/services/authentification.service.dart';

import 'package:movie_helper/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      // home: TvListByGenre(genre: Genre(id: 28, name: "Action")),
      // home: MainScreen(),
      // home: SeasonDetailsScreen(id: 42009, seasonNumber: 1),
      // home: TvDetailsScreen(id: 62688),
      // home: MovieDetailsScreen(id: 569547),
      // home: SearchView(),
      home: RootPage(
        auth: Auth(),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}
