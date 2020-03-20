import 'dart:math';

import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  final int index;
  final String name;
  final List<MaterialColor> colors = [
    Colors.cyan,
    Colors.indigo,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.deepPurple
  ];

  GenreItem({this.name, this.index});

  @override
  Widget build(BuildContext context) {
    MaterialColor color = colors[index % this.colors.length];
    return Container(
      height: 100,
      width: 200,
      child: Center(
        child: Text(
          this.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            color[500],
            color[700],
          ],
        ),
      ),
    );
  }
}
