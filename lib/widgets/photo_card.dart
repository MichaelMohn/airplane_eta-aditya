import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  final String photo;

  const PhotoCard({Key key, @required this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.height;

    final BorderRadius br = BorderRadius.circular(40.0);

    final bool isPhoto = photo.isNotEmpty ? true : false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, right: 2.0),
      child: Material(
        elevation: isPhoto ? 4.0 : 0,
        borderRadius: br,
        child: Container(
          width: screenWidth * 0.3,
          height: screenWidth * 0.3,
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: br,
              image: isPhoto
                  ? DecorationImage(image: AssetImage(photo), fit: BoxFit.cover)
                  : null),

        ),
      ),
    );
  }
}
