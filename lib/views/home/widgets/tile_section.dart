import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../widgets/category_card.dart';
class TileSection extends StatefulWidget {
  @override
  _TileSectionState createState() => _TileSectionState();
}

class _TileSectionState extends State<TileSection> {
  int selectedCardIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCategoryCard(0, CustomColors.orange, 'SouthWest/American Air', 'Flight S123', context),
            _buildCategoryCard(1, CustomColors.green, 'ADD', 'Flight', context),

          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      int index,
      Color color,
      String top,
      String bottom,
      BuildContext context,
      ) {
    return CategoryCard(
      index: index,
      selectedCardIndex: selectedCardIndex,
      color: color,
      top: top,
      bottom: bottom,
      onPressed: () => selectCategory(index),
    );
  }

  void selectCategory(int index) {
    setState(() {
      selectedCardIndex = index;
    });
  }
}