import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final AppBar appBar;

  CustomAppBar({this.title, this.appBar}) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => _onBackTap(context),
      ),
      title: Text(title),
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
