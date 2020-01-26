import 'package:flutter/material.dart';
import '../utils/utils.dart';

class Header extends StatelessWidget {
  final bool isHome;

  const Header({Key key, @required this.isHome}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isHome? Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Text( "Airport ETA",
        style: AppTextStyles.headerTextStyle,
      ),
    ) : Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "⚙️Settings",
            style: AppTextStyles.headerTextStyle,
          ),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }
}