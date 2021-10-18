import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/widgets/etkinliklerimCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class BekleyenEtkinliklerim extends StatefulWidget {
  @override
  _BekleyenEtkinliklerimState createState() => _BekleyenEtkinliklerimState();
}

class _BekleyenEtkinliklerimState extends State<BekleyenEtkinliklerim> {
  ScrollController _scrollController = ScrollController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        key: _scaffoldKey,
        body: ListView(controller: _scrollController, children: [
          SizedBox(
            height: 20.0.h,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('etkinlikOnayBekleyenler')
                .where("userId", isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .where("tarih", isGreaterThan: DateTime.now())
                .orderBy('tarih', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final int cardLength = snapshot.data.docs.length;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cardLength,
                itemBuilder: (_, int index) {
                  return EtkinliklerimCard(
                    etkinlikBilgileri: EtkinlikModel.fromMap(snapshot.data.docs[index].data()),
                    card: snapshot.data.docs[index],
                    onaylandi: false,
                  );
                },
              );
            },
          )
        ]));
  }
}
