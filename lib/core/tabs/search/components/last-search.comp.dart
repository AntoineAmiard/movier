import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_helper/services/storage.service.dart';

class LastSearches extends StatefulWidget {
  List<String> searches;

  LastSearches({this.searches});
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
        Container(
          child: AnimatedList(
            shrinkWrap: true,
            key: listKey,
            initialItemCount: widget.searches.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(context, index, animation);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index, animation) {
    String search = widget.searches[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeIn),
      ),
      child: ListTile(
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
    );
  }

  void _onRemoveTap(int index) async {
    listKey.currentState.removeItem(
        index, (_, animation) => _buildItem(context, index, animation),
        duration: const Duration(milliseconds: 250));
    await storage.removeSearch(widget.searches[index]);
    widget.searches.removeAt(index);
  }

  void _onDeleteTap() async {
    for (int i = 0; i <= widget.searches.length; i++) {
      listKey.currentState.removeItem(
          i, (_, animation) => _buildItem(context, 0, animation),
          duration: const Duration(milliseconds: 250));
      await storage.removeSearch(widget.searches[i]);
      widget.searches.removeAt(i);
      sleep(Duration(milliseconds: 200));
    }
  }
}
