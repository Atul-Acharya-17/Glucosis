import 'package:flutter/material.dart';
import '../controller/AuthenticationMgr.dart';

/// App Bar for common use across all UI screens.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({@required this.title});
  final String title;
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);
  final double appBarHeight = 45;

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    final double appBarTextSize = appBarHeight * 0.4;
    final double appBarIconSize = appBarHeight * 0.6;
    return AppBar(
      backgroundColor: green,
      iconTheme: IconThemeData(color: Colors.pink.shade100),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: appBarIconSize,
          color: pink,
        ),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: appBarTextSize,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    final double appBarTextSize = appBarHeight * 0.6;
    final double appBarIconSize = appBarHeight * 0.6;
    return AppBar(
      backgroundColor: green,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: appBarIconSize,
          color: pink,
        ),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: appBarTextSize,
            color: Color.fromRGBO(254, 179, 189, 1),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: new Image.asset('images/user_icon.jpeg'),
          iconSize: appBarIconSize,
          padding: EdgeInsets.only(right: 18.0),
          onPressed: () {

            //Navigator.of(context).pushNamed('/profile');
          },
        ),
      ],
    );
  }

 */
}
