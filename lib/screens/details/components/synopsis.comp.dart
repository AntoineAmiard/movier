import 'package:flutter/material.dart';

class Synopsis extends StatelessWidget {
  final String overview;

  Synopsis({this.overview});
  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Synopsis",
          style: textStyle.title,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          overview,
          style: textStyle.body1,
          // textAlign: ,
        )
      ],
    );
  }
}
