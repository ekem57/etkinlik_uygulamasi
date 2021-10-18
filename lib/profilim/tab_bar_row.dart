import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class ProfilTabItems extends StatefulWidget {
  final TabController tabController;

  const ProfilTabItems({Key key, this.tabController}) : super(key: key);

  @override
  _ProfilTabItemsState createState() => _ProfilTabItemsState();
}

class _ProfilTabItemsState extends State<ProfilTabItems> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(top: 60.0.h),
      child: TabBar(
        controller: widget.tabController,
        unselectedLabelColor: const Color(0xff343633),
        labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
            fontFamily: "OpenSans",
            fontStyle: FontStyle.normal,
            fontSize: 11.3.spByWidth),
        labelColor: Theme.of(context).primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Theme.of(context).buttonColor,
        tabs: [
          Tab(child: Icon(Icons.person)),
          Tab(child: Icon(Icons.emoji_emotions)),
          Tab(child: Icon(Icons.location_on)),
          Tab(child: Icon(Icons.star_rate)),
          Tab(child: Icon(Icons.photo_album)),
        ],
      ),
    );
  }
}
