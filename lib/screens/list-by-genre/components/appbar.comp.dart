import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String genreName;
  final AppBar appBar;

  CustomAppBar({this.genreName, this.appBar}) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => _onBackTap(context),
      ),
      title: Text(genreName),
    );
  }

  void _onBackTap(context) {
    Navigator.pop(context);
  }

  @override
  Widget get child => null;

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
