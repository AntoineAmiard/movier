import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayerScreen extends StatefulWidget {
  @override
  MoviePlayerScreenState createState() => MoviePlayerScreenState();
}

class MoviePlayerScreenState extends State<MoviePlayerScreen> {
  final Key _mapKey = UniqueKey();
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '-yuWIevIClU',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
        hideControls: false,
        disableDragSeek: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        // topActions: <Widget>[Icon(Icons.arrow_back)],
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        onReady: () {
          _controller.play();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
