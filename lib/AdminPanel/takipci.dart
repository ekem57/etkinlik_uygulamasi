import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:etkinlik_kafasi/profilim/profildetay/kullaniciProfili.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class AdminTakipci extends StatefulWidget {
  final Map<String, dynamic> card;

  const AdminTakipci({Key key, this.card}) : super(key: key);
  @override
  _AdminTakipciState createState() => _AdminTakipciState();
}


class UserBloc extends Bloc {
  final userController = StreamController<List>.broadcast();


  @override
  void dispose() {
    // TODO: implement dispose
    userController.close();
  }
}
abstract class Bloc {
  void dispose();
}



UserBloc userBloc = UserBloc();
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _AdminTakipciState extends State<AdminTakipci>  with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool isSearching = false;
  List<DocumentSnapshot> totalUsers = [];
  List totalBilgi = [];
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  final yorumController = TextEditingController();
  void _searchUser(String searchQuery) {

    List<Map<dynamic,dynamic>> searchResult = [];

    userBloc.userController.sink.add(null);
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsers);
      return;
    }
    totalUsers.forEach((DocumentSnapshot user) {
      String tamad=user['ad'];
      if (tamad.toLowerCase().contains(searchQuery.toLowerCase()) ||
          tamad.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(user.data());
      }
    });


    userBloc.userController.sink.add(searchResult);
  }
  Widget usersWidget(String userid) {
    return StreamBuilder(

        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List> snapshot) {

          if (snapshot.data == null) {

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(widget.card['userId']).collection("takipcilerim").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final int cardLength = snapshot.data.docs.length;

                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];

                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users').where('userId',isEqualTo: _cardYonetici['userid'])
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }



                            return  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (_, int index) {
                                final DocumentSnapshot _card = snapshot.data.docs[0];

                                totalUsers.add(_card);
                                totalBilgi.add(_card);

                                return ResimliCard(textSubtitle: null, textTitle: _card['ad'].toString(), onPressed: (){
                                  final _userModel = Provider.of<UserModel>(context, listen: false);

                                  if(_userModel.user.userId==_card['userId'].toString()){

                                  }else {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            KarsiKullaniciProfili(
                                              card: _card.data(),)),);
                                  }
                                }, fontSize: 12,
                                    img: _card['avatarImageUrl'].toString(), tarih: null);

                              },
                            );
                          }

                      );
                    }


                );

              },
            );
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : _randomUsers(snapshot: snapshot,);
        });
  }

  Widget _randomUsers({AsyncSnapshot<List> snapshot}) {

    return snapshot.data.length != 0 ?
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> userbilgiler = Map();
        if(snapshot.data.runtimeType.toString()=='List<Map<dynamic, dynamic>>'){
          userbilgiler.addAll(snapshot.data[index]);
        }else{
          QueryDocumentSnapshot veri=snapshot.data[index];
          userbilgiler.addAll(veri.data());
        }
        return ResimliCard(textSubtitle: null, textTitle: snapshot.data[index]['ad'], onPressed: (){
          final _userModel = Provider.of<UserModel>(context, listen: false);

          if(_userModel.user.userId== snapshot.data[index]['userId'].toString()){

          }else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card:  userbilgiler)),);

          }

        }, fontSize: 12.0.spByWidth,
            img: snapshot.data[index]['avatarImageUrl'].toString(), tarih: null);
      },
      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Takipciler",
            style: TextStyle(
                color: const Color(0xff343633),
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 21.7.spByWidth),
            textAlign: TextAlign.center),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: ListView(

        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0.w),
            child: Container(
              width: 293.3333333333333.w,
              height: 41.666666666666664.h,
              margin: EdgeInsets.symmetric(vertical: 20.0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.8.h)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x2b000000), offset: Offset(0, 2), blurRadius: 14.30.w, spreadRadius: 0)
                ],
                color: Theme.of(context).backgroundColor,),
              child: TextFormField(
                onChanged: (text) => _searchUser(text),
                keyboardType: TextInputType.text,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.disabled,
                textInputAction: TextInputAction.done,
                style: TextStyle(fontSize: 15.0.spByWidth),
                decoration: InputDecoration(
                  hintText: "Katılımcı Ara",
                  border: InputBorder.none,
                  icon: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 18.0.h,
                    ),
                  ),
                  labelStyle: TextStyle(
                      color: const Color(0xbf343633),
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.italic,
                      fontSize: 15.3.spByWidth),
                ),
              ),

            ),
          ),
          usersWidget(widget.card['userId']),
        ],
      ),
    );
  }


}
