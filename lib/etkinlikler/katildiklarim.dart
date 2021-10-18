import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/widgets/etkinliklerimCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class JoiningEventBloc{
  final _eventStreamController = StreamController<List<QueryDocumentSnapshot>>();
  StreamSink<List<QueryDocumentSnapshot>> get _eventSink => _eventStreamController.sink;
  Stream<List<QueryDocumentSnapshot>> get eventStream=>_eventStreamController.stream;

  JoiningEventBloc(){
    var othersEvents = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("katilim")
        .snapshots();

    othersEvents.listen((event) async {
      for(var document in event.docs){
        print(document.id);
        var otherEvent =
        await FirebaseFirestore.instance
            .collection('etkinlik')
            .where("etid", isEqualTo: document["etid"])
            .where("tarih", isGreaterThan: DateTime.now())
            .orderBy('tarih', descending: false)
            .get();
        _eventSink.add(otherEvent.docs);
      }

      if(event.docs.length == 0)
        _eventSink.addError("Etkinlik Yok");
    });

  }

  void dispose(){
    _eventStreamController.close();
  }


}

class MyJoiningEvents extends StatefulWidget {
  @override
  _MyJoiningEventsState createState() => _MyJoiningEventsState();
}

class _MyJoiningEventsState extends State<MyJoiningEvents> {
  ScrollController _scrollController = ScrollController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int getirilecek = 5;
  int gelen;
  bool _elemanyukle = false;
  Stream etkinliklerim;
  JoiningEventBloc eventBloc = JoiningEventBloc();



  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }
  @override
  void dispose() {
    eventBloc.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        getirilecek += 5;
        _elemanyukle = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      body: ListView(
        controller: _scrollController,
        children: [
          SizedBox(
            height: 20.0.h,
          ),
          StreamBuilder<List<QueryDocumentSnapshot>>(
            stream: eventBloc.eventStream,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final int cardLength = snapshot.data.length;
                gelen = cardLength;
                print(cardLength);
                return cardLength == 0
                    ? Center(child: Text("Etkinlik Yok"))
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cardLength,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot _cardYonetici = snapshot.data[index];
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('etkinlik')
                          .doc(_cardYonetici['etid'].toString())
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final DocumentSnapshot _card = snapshot.data;
                          return EtkinliklerimCard(
                            etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),
                            card: _card,
                          );
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text(snapshot.error);
                        }
                        return Container();
                      },
                    );
                  },
                );
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text(snapshot.error));
              }
              print(snapshot.connectionState);
              if(snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Container();

            },
          ),
          _elemanyukle == false
              ? SizedBox(
            height: 5.0.h,
          )
              : (gelen + 5) == getirilecek
              ? Platform.isIOS
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : getirilecek > gelen
              ? Padding(
            padding: EdgeInsets.only(top: 20.0.h),
            child: Center(
                child: Text(
                  "Daha Fazla Etkinlik Yok",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
          )
              : Platform.isIOS
              ? Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
              : Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          SizedBox(
            height: 50.0.h,
          ),
        ],
      ),
    );
  }
}
