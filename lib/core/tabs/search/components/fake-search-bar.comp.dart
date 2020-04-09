import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/search/Search-bar-focus.screen.dart';

class FakeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        // focusNode: FocusNode(canRequestFocus: false),
        enabled: false,
        // onTap: () => _onTap(context),
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(Icons.search),
          hintText: "Recherche",
          fillColor: Theme.of(context).cardColor,
          focusColor: Colors.grey,
          // hoverColor: Colors.grey,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
