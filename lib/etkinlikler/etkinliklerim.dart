import 'package:etkinlik_kafasi/etkinlikler/aktifetkinlik.dart';
import 'package:etkinlik_kafasi/etkinlikler/bekleyen_etkinliklerim.dart';
import 'package:etkinlik_kafasi/etkinlikler/favorietkinliklerim.dart';
import 'package:etkinlik_kafasi/etkinlikler/gemisetkinliklerim.dart';
import 'package:etkinlik_kafasi/etkinlikler/katildiklarim.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Etkinliklerim extends StatefulWidget {
  final EtkinlikModel etkinlikBilgileri;

  Etkinliklerim({this.etkinlikBilgileri});
  @override
  _EtkinliklerimState createState() => _EtkinliklerimState();
}

class _EtkinliklerimState extends State<Etkinliklerim>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  int getirilecek=2;
  bool _elemanyukle=false;
  int gelen;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        getirilecek+=2;
        _elemanyukle=true;
      });
    }
  }
  Future<Null> _sayfaYenile() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _sayfaYenile,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("Etkinliklerim",
              style: TextStyle(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0.spByWidth),
              textAlign: TextAlign.center),
          elevation: 0.0,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.70),
                topRight: Radius.circular(20.70)),
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: const Color(0x5c000000),
                  offset: Offset(0, 0),
                  blurRadius: 33.06,
                  spreadRadius: 4.94)
            ],
          ),
          child: Column(

            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: const Color(0xff343633),
                  labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0.spByWidth),
                  labelColor: Theme.of(context).primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Theme.of(context).buttonColor,
                  isScrollable: true,
                  tabs: [
                    Tab(child: Text("Etkinliklerim")),
                    Tab(child: Text("Katıldıklarım")),
                    Tab(child: Text("Bekleyenler")),
                    Tab(child: Text("Favoriler")),
                    Tab(child: Text("Geçmiş")),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AktifEtkinlik2(),
                    MyJoiningEvents(),
                    BekleyenEtkinliklerim(),
                    FavorEtkinliklerim(),
                    GecmisEtkinliklerim(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}

