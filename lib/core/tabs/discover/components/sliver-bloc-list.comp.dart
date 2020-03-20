import 'package:flutter/material.dart';

class SliverBloc extends StatelessWidget {
  final Widget list;
  final String title;
  final double maxHeight;
  final double minHeight;
  final IconData icon;

  SliverBloc({
    this.maxHeight,
    this.minHeight,
    this.title,
    this.list,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 0, 10),
            child: RichText(
              text: TextSpan(
                text: title,
                style: TextStyle(fontSize: 30),
                children: icon != null
                    ? [
                        WidgetSpan(
                          child: Icon(
                            icon,
                            size: 30,
                          ),
                        ),
                      ]
                    : null,
              ),
            ),
          ),
          Container(
            constraints:
                BoxConstraints(maxHeight: maxHeight, minHeight: minHeight),
            child: list,
          ),
        ],
      ),
    );
  }
}
