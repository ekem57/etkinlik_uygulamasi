import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/etkinlikler/favorilerimEtkinlikCard.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class FavorEtkinliklerim extends StatefulWidget {
  @override
  _FavorEtkinliklerimState createState() => _FavorEtkinliklerimState();
}

class _FavorEtkinliklerimState extends State<FavorEtkinliklerim> {
  ScrollController _scrollController = ScrollController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int getirilecek=2;
  int gelen;
  bool _elemanyukle=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      body: ListView(
        controller: _scrollController,
        children: [
          SizedBox(height: 20.0.h,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('favoriEtkinliklerim')

                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else{
                _elemanyukle=false;
              }
              final int cardLength = snapshot.data.docs.length;
              gelen=cardLength;

              return cardLength == 0 ?
              Center(child: Text("Etkinlik Yok")) :
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cardLength,
                itemBuilder: (_, int index) {
                  final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
                  return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('etkinlik').doc(_cardYonetici['etid'].toString()).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      if(snapshot.data.exists == false)
                        return Container();
                      final DocumentSnapshot _card = snapshot.data;
                      return  FavorilerimCard(etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),card: _card,);
                    },
                  );
                },
              );

            },
          ),
          // _elemanyukle == false ? SizedBox(height: 5.0.h,) :
          // (gelen+2)== getirilecek ?  Platform.isIOS ? Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(child: CupertinoActivityIndicator(),),
          // ):Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(child: CircularProgressIndicator(),),
          // ) :
          //
          // getirilecek > gelen ? Padding(
          //   padding:  EdgeInsets.only(top: 20.0.h),
          //   child: Center(child: Text("Daha Fazla Etkinlik Yok",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0.spByWidth),)),
          // ) : Platform.isIOS ? Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(child: CupertinoActivityIndicator(),),
          // ):Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(child: CircularProgressIndicator(),),
          // ),
          SizedBox(
            height: 50.0.h,
          ),

        ],),



    );

  }

}
