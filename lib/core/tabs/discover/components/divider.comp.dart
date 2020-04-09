import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  final String title;

  SliverDivider({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Divider(
              thickness: 4,
              indent: 10,
              endIndent: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textStyle.display3,
            ),
            Divider(
              thickness: 4,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }
}
