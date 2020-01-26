import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/second_section.dart';
import 'widgets/tab_section.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/header.dart';

class NotificationsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final _headerText = Header(isHome: false);

    final _tabSection = TabSection();

    final _firstSection = Container(
      height: screenHeight * 0.35,
      padding: EdgeInsets.only(top: 7.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_headerText, _tabSection],
      ),
    );


    final _secondSection = SecondSection();

    return Scaffold(
      appBar: CustomAppBar(isHome: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[_firstSection, _secondSection],
          ),
        ),
      ),
    );
  }
}
