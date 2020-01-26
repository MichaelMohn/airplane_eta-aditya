import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AppConstants {
  static const appName = "flutter-ghana-ui-challenge-week-1";
}

class AppTextStyles {
  static const headerTextStyle = const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w800,
      color: Colors.white
  );

  static const subHeaderTextStyle = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  static const unselectedTabTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const selectedTabTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: CustomColors.primaryColor,
  );
}

class AvailableFonts {
  static const primaryFont = "Quicksand";
}

class AvailableImages {
  static const image = 'assets/images/admin.png';
  static const Capture = 'assets/images/Capture.jpg';
  static const lines = 'assets/images/lines.png';
  static const Capture2 = 'assets/images/Capture2.jpg';
  static const Capture3 = 'assets/images/Capture3.jpg';
  static const Capture7 = 'assets/images/Capture7.jpg';
  static const Capture5 = 'assets/images/Capture5.jpg';
  static const maxresdefault = 'assets/images/maxresdefault.jpg';
  static const Capture4 = 'assets/images/Capture4.jpg';
  static const facebook = 'assets/images/facebook.jpg';
  static const marvel = 'assets/images/marvel.jpg';
  static const amazon = 'assets/images/amazon.jpg';
  static const settings = 'assets/images/settings.png';
  static const billing = 'assets/images/billing.png';
  static const giftcard = 'assets/images/giftcard.png';

}
