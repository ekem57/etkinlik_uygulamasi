import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../etkinlikler/aktifetkinlik.dart';
import '../etkinlikler/etkinlik_card.dart';
import '../etkinlikler/gecmis_etkinlik_card.dart';

class NewEtkinliklerim extends StatefulWidget {
  final EtkinlikModel etkinlikBilgileri;

  NewEtkinliklerim({this.etkinlikBilgileri});
  @override
  _NewEtkinliklerimState createState() => _NewEtkinliklerimState();
}

class _NewEtkinliklerimState extends State<NewEtkinliklerim>
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
    _tabController = new TabController(length: 1, vsync: this);

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                tabs: [
                  Tab(child: Text("Aktif")),
                  Tab(child: Text("Geçmiş")),
                  Tab(child: Text("Favoriler")),

                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                 AktifEtkinlik2(),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .collection('etkinliklerim')
                        .orderBy('tarih', descending: true)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        print(snapshot.error);
                        return Center(
                            child: Text(
                              "Herhangi bir etkinlik yok!",
                              style: Theme.of(context).textTheme.caption,
                            ));
                      }
                      final int cardLength = snapshot.data.docs.length;

                      return cardLength == 0
                          ? Center(child: Text("Herhangi bir etkinlik yok!",   style: Theme.of(context).textTheme.caption,))
                          : ListView.builder(
                        itemCount: cardLength,
                        itemBuilder: (_, int index) {
                          final DocumentSnapshot _cardetkinlikler = snapshot.data.docs[index];
                          print("etkinlik idlerim:"+_cardetkinlikler['etid'].toString());
                          return   StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('etkinlik').doc(_cardetkinlikler['etid'].toString()).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }


                              return cardLength == 0
                                  ? Center(child: Text("Herhangi bir etkinlik yok!",   style: Theme.of(context).textTheme.caption,))
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (_, int index) {
                                  final DocumentSnapshot _card = snapshot.data;

                                  return GecmisEtkinlikCard(card: _card,);
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .collection('favoriEtkinliklerim')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        print(snapshot.error);
                        return Center(
                            child: Text(
                              "Herhangi bir etkinlik yok!",
                              style: Theme.of(context).textTheme.caption,
                            ));
                      }
                      final int cardLength = snapshot.data.docs.length;

                      return cardLength == 0
                          ? Center(child: Text("Herhangi bir etkinlik yok!",   style: Theme.of(context).textTheme.caption,))
                          : ListView.builder(
                        itemCount: cardLength,
                        itemBuilder: (_, int index) {
                          final DocumentSnapshot _cardetkinlikler = snapshot.data.docs[index];
                          return   StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('etkinlik').doc(_cardetkinlikler['etid'].toString()).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }


                              return cardLength == 0
                                  ? Center(child: Text("Herhangi bir etkinlik yok!",   style: Theme.of(context).textTheme.caption,))
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (_, int index) {
                                  final DocumentSnapshot _card = snapshot.data;
                                  print("gelencard:"+_card.data().toString());
                                  return EtkinlikCard(etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),card: _card,);
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}



