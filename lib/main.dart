import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/core/main.screen.dart';
import 'package:movie_helper/screens/movie-details/movie-details.screen.dart';
import 'package:movie_helper/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      home: MovieDetailsScreen(id: 454626),
      debugShowCheckedModeBanner: false,
    );
  }
}
