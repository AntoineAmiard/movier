import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/core/main.screen.dart';
import 'package:movie_helper/screens/TV-details/tv-details.screen.dart';
import 'package:movie_helper/screens/movie-details/movie-details.screen.dart';
import 'package:movie_helper/screens/season-details/season-details.screen.dart';
import 'package:movie_helper/screens/youtube-player/youtube-player.screen.dart';
import 'package:movie_helper/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      home: MainScreen(),
      // home: SeasonDetailsScreen(id: 42009, seasonNumber: 1),
      // home: TVDetailsScreen(id: 42009),
      // home: MovieDetailsScreen(id: 569547),
      debugShowCheckedModeBanner: false,
    );
  }
}
