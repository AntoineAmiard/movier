import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/search/Search-bar-focus.screen.dart';
import 'package:movie_helper/screens/search-list/components/list-by-research.screen.dart';
import 'package:movie_helper/services/storage.service.dart';

typedef void Callback(String searchString);

class LastSearches extends StatefulWidget {
  List<String> searches;
  Callback onCallback;

  LastSearches({this.searches, this.onCallback});
  @override
  LastSearchesState createState() => LastSearchesState();
}

class LastSearchesState extends State<LastSearches> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, width: 0.3),
              borderRadius: BorderRadius.circular(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Dernières recherches",
                  style: textStyle.subhead,
                ),
              ),
              Opacity(
                opacity: 0.7,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.delete),
                  onPressed: () => _onDeleteTap(),
                ),
              ),
            ],
          ),
        ),
        widget.searches.length != 0
            ? Container(
                child: AnimatedList(
                  shrinkWrap: true,
                  key: listKey,
                  physics: ScrollPhysics(),
                  initialItemCount: widget.searches.length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(context, index, animation);
                  },
                ),
              )
            : Container(
                height: 100,
                child: Center(
                  child: Text("Aucune recherches récentes"),
                ),
              ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index, animation) {
    String search = widget.searches[index];
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeIn),
        ),
        child: ListTile(
          onTap: () => widget.onCallback(search),
          title: Text(search),
          trailing: GestureDetector(
            child: Opacity(
              opacity: 0.7,
              child: Icon(
                Icons.remove_circle,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
            onTap: () => _onRemoveTap(index),
          ),
        ),
      ),
    );
  }

  void _onRemoveTap(int index) async {
    listKey.currentState.removeItem(
        index, (_, animation) => _buildItem(context, index, animation),
        duration: const Duration(milliseconds: 200));
    await storage.removeSearch(widget.searches[index]);
    setState(() => widget.searches.removeAt(index));
  }

  void _onDeleteTap() async {
    for (int i = widget.searches.length - 1; i >= 0; i--) {
      await Future.delayed(
        Duration(milliseconds: 100),
        () async {
          await storage.removeSearch(widget.searches[i]);
          setState(() => widget.searches.removeAt(i));

          listKey.currentState.removeItem(
              i, (_, animation) => _buildItem(context, 0, animation),
              duration: const Duration(milliseconds: 200));
        },
      );
    }
  }
}
