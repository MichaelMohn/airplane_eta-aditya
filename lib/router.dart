import 'package:flutter/material.dart';
import 'package:flutter_map_route/TravelPage.dart';
import 'views/notifications/notifications.dart';
import 'views/home/home.dart';

const String homeViewRoute = '/';
const String notificationsViewRoute = '/notifications';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeViewRoute:
      return MaterialPageRoute(builder: (_) => MapSample());
    case notificationsViewRoute:
      return MaterialPageRoute(builder: (_) => NotificationsPage());

      break;
    default:
      return MaterialPageRoute(builder: (_) => HomePage());
  }
}
