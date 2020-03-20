import 'package:flutter/material.dart';

class SliverCustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      backgroundColor: Colors.transparent,
      expandedHeight: 175.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        title: Text(
          'Découverte',
          style: TextStyle(fontSize: 35),
        ),
        titlePadding: EdgeInsets.fromLTRB(20, 0, 0, 20),
        background: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10), right: Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue,
                Colors.cyan,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
