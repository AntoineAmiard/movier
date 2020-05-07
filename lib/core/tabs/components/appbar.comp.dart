import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color topLeftColor;
  final Color bottomRightColor;

  CustomAppBar({this.title, this.topLeftColor, this.bottomRightColor});
  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return SliverAppBar(
      stretch: true,
      backgroundColor: Colors.transparent,
      expandedHeight: 125.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        title: Text(
          title,
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
                topLeftColor,
                bottomRightColor,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
