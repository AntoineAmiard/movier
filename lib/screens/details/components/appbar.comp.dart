import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String posterPath;

  CustomAppBar({this.title, this.posterPath});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => _onTapAction(context),
      ),
      stretch: true,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(),
      ),
      expandedHeight: 220,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        centerTitle: false,
        titlePadding: EdgeInsets.fromLTRB(150, 0, 50, 50),
        title: Align(
          child: Text(
            title,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.clip,
          ),
          alignment: Alignment.bottomRight,
        ),

        // child: Container(
        //   // width: MediaQuery.of(context).size.width * 0.35,
        //   child:
        //     Text(
        //   title,
        //   maxLines: 3,
        //   style: textStyle.title,
        //   overflow: TextOverflow.ellipsis,
        // ),
        // ),
      ),
    );
  }

  void _onTapAction(context) {
    Navigator.pop(context);
  }
}
