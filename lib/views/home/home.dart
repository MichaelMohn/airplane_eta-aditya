import 'package:flutter/material.dart';
import 'widgets/tile_section.dart';
import '../../widgets/media_section.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/header.dart';
import '../../utils/utils.dart';

class HomePage extends StatelessWidget {
  final List<String> _photos = [
    AvailableImages.Capture,

  ];

  @override
  Widget build(BuildContext context) {
    final _headerText = Header(isHome: true);


    final _tileSection = TileSection();


    final _photosSection = MediaSection(title: "Airport Status", media: _photos,);


    return Scaffold(
      appBar: CustomAppBar(isHome: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric (horizontal: 12.0, vertical: 1.0),
          child: Container(
            padding: EdgeInsets.only(top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _headerText,
                _tileSection,
                _photosSection,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
