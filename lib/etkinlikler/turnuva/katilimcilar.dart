import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:etkinlik_kafasi/profilim/profildetay/kullaniciProfili.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class Katilimcilar extends StatefulWidget {
  final QuerySnapshot qn;

  const Katilimcilar({Key key, this.qn}) : super(key: key);

  @override
  _KatilimcilarState createState() => _KatilimcilarState();
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

class _KatilimcilarState extends State<Katilimcilar> {
  final TextEditingController _araController = TextEditingController();
  List<DocumentSnapshot> totalUsers = [];
  List data;
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _primaryColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Katılımcılar",
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
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Container(
                width: 243.3333333333333.w,
                height: 41.666666666666664.h,
                margin: EdgeInsets.symmetric(vertical: 20.0.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.8.h)),
                  boxShadow: [BoxShadow(color: const Color(0x2b000000), offset: Offset(0, 2), blurRadius: 14.30.w, spreadRadius: 0)],
                  color: Theme.of(context).backgroundColor,
                ),
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
            usersWidget(),
          ],
        ),
      ),
    );
  }

  void _searchUser(String searchQuery) {
    List<Map<dynamic, dynamic>> searchResult = [];

    userBloc.userController.sink.add(null);

    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsers);
      return;
    }
    totalUsers.forEach((DocumentSnapshot user) {
      String tamad = user['ad'];

      if (tamad.toLowerCase().contains(searchQuery.toLowerCase()) || tamad.toLowerCase().contains(searchQuery.toLowerCase())) {
        // print("bulunan user: "+user['ad'].toString());
        searchResult.add(user.data());
      }
    });
    // print(searchResult.length);

    userBloc.userController.sink.add(searchResult);
  }

  Widget usersWidget() {
    print("userwidget çalıştı");
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return StreamBuilder(
        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext, AsyncSnapshot<List> snapshot) {
          if (snapshot.data == null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.qn.docs.length,
              itemBuilder: (_, int index) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('userId', isEqualTo: widget.qn.docs[index]['userid'].toString())
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (widget.qn.docs.length > totalUsers.length) {
                      totalUsers.add(snapshot.data.docs[0]);
                    }
                    String id = snapshot.data.docs[0]['userId'].toString();

                    return _userModel.user.userId != snapshot.data.docs[0]['userId'].toString()
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KarsiKullaniciProfili(
                                          card: snapshot.data.docs[0].data(),
                                        )),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 6.0.h),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data.docs[0]['avatarImageUrl'].toString()),
                                  radius: 25.70.w,
                                ),
                                title: Text(
                                  snapshot.data.docs[0]['ad'].toString(),
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0.spByWidth),
                                ),
                                trailing: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(_userModel.user.userId)
                                        .collection("takipEttiklerim")
                                        .where('userid', isEqualTo: snapshot.data.docs[0]['userId'].toString())
                                        .snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) return const Text('Yükleniyor...');

                                      return snapshot.data.docs.toString() != "[]"
                                          ? Container(
                                              width: 88.70.w,
                                              height: 30.70.h,
                                              child: RaisedButton(
                                                color: Renkler.reddetButonColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(65.7.w),
                                                ),
                                                onPressed: () {
                                                  _firestoreDBService.takipCikButonu(_userModel.user.userId.toString(), id);
                                                },
                                                elevation: 8.3,
                                                child: Text(
                                                  "Bırak",
                                                  style: TextStyle(
                                                      color: const Color(0xff343633),
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "OpenSans",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12.40.spByWidth),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 88.70.w,
                                              height: 30.70.h,
                                              child: RaisedButton(
                                                color: Theme.of(context).buttonColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(65.7.w),
                                                ),
                                                onPressed: () {
                                                  _firestoreDBService.takipetButonu(_userModel.user.userId.toString(), id);
                                                },
                                                elevation: 8.3,
                                                child: Text(
                                                  "Takip Et",
                                                  style: TextStyle(
                                                      color: const Color(0xff343633),
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "OpenSans",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 11.30.spByWidth),
                                                ),
                                              ),
                                            );
                                    }),
                              ),
                            ),
                          )
                        : Container();
                  },
                );
              },
            );
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _randomUsers(snapshot: snapshot);
        });
  }

  Widget _randomUsers({AsyncSnapshot<List> snapshot}) {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        String gelenid = snapshot.data[index]['userId'].toString();
        //snapshot.data[index].toString()
        Map<String, dynamic> userbilgiler = Map();
        if (snapshot.data.runtimeType.toString() == 'List<Map<dynamic, dynamic>>') {
          userbilgiler.addAll(snapshot.data[index]);
        } else {
          QueryDocumentSnapshot veri = snapshot.data[index];
          userbilgiler.addAll(veri.data());
        }
        // userbilgiler.addAll(snapshot.data[index]);
        return _userModel.user.userId != snapshot.data[index]['userId'].toString()
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KarsiKullaniciProfili(
                              card: userbilgiler,
                            )),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 6.0.h),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data[index]['avatarImageUrl'].toString()),
                      radius: 25.70.w,
                    ),
                    title: Text(
                      snapshot.data[index]['ad'].toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0.spByWidth),
                    ),
                    trailing: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(_userModel.user.userId)
                            .collection("takipEttiklerim")
                            .where('userid', isEqualTo: snapshot.data[index]['userId'].toString())
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return const Text('Yükleniyor...');

                          return snapshot.data.docs.toString() != "[]"
                              ? Container(
                                  width: 88.70.w,
                                  height: 30.70.h,
                                  child: RaisedButton(
                                    color: Renkler.reddetButonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(65.7.w),
                                    ),
                                    onPressed: () {
                                      _firestoreDBService.takipCikButonu(_userModel.user.userId.toString(), gelenid);
                                    },
                                    elevation: 8.3,
                                    child: Text(
                                      "Bırak",
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.40.spByWidth),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 88.70.w,
                                  height: 30.70.h,
                                  child: RaisedButton(
                                    color: Theme.of(context).buttonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(65.7.w),
                                    ),
                                    onPressed: () {
                                      _firestoreDBService.takipetButonu(_userModel.user.userId.toString(), gelenid);
                                    },
                                    elevation: 8.3,
                                    child: Text(
                                      "Takip Et",
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 11.30.spByWidth),
                                    ),
                                  ),
                                );
                        }),
                  ),
                ),
              )
            : Container();
      },
      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
    );
  }
}
