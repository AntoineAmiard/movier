import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  final String title;

  SliverDivider({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(fontSize: 40),
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
