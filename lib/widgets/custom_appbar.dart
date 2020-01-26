import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;

  const CustomAppBar({Key key, @required this.isHome}) : super(key: key);

  @override
  Size get preferredSize => Size(null,  50.0);

  @override
  Widget build(BuildContext context) {
    final _userImage = GestureDetector(
      onTap: () => Navigator.pushNamed(context, isHome ? notificationsViewRoute : homeViewRoute),
      child: Container(
        margin: EdgeInsets.only(right: 15.0, top: 5.0),
        height: 40.0,
        width: 42.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(AvailableImages.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, isHome ? notificationsViewRoute : homeViewRoute),
          child: Image.asset(
            AvailableImages.lines,
            width: 2.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
      actions: <Widget>[_userImage],
    );
  }
}