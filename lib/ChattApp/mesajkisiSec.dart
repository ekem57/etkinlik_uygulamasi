import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/ChattApp/chat_view_model.dart';
import 'package:etkinlik_kafasi/ChattApp/sohbetPage.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class ChattKisiSec extends StatefulWidget {
  @override
  _ChattKisiSecState createState() => _ChattKisiSecState();
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

class _ChattKisiSecState extends State<ChattKisiSec> {
  bool isSearching = false;
  List<DocumentSnapshot> totalUsers = [];
  List data = [];

  void _searchUser(String searchQuery) {
    List<Map<dynamic, dynamic>> searchResult = [];

    userBloc.userController.sink.add(null);
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsers);
      return;
    }
    totalUsers.forEach((DocumentSnapshot user) {
      String tamad = user['ad'];
      if (tamad.toLowerCase().contains(searchQuery.toLowerCase()) ||
          tamad.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(user.data());
      }
    });

    userBloc.userController.sink.add(searchResult);
  }

  Widget usersWidget() {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return StreamBuilder(
        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext, AsyncSnapshot<List> snapshot) {
          if (snapshot.data == null) {
            List<String> ids = _userModel.user.blockedUsers.map((e) => e.userId).toList();
            print(ids);
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_userModel.user.userId)
                  .collection("takipEttiklerim")
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var blockIds = _userModel.user.blockedUsers.map((e) => e.userId).toList();
                var list = snapshot.data.docs
                    .where((e) => !blockIds.contains(e.get("userid"))).toList();
                list = list
                    .where((element) => (element.data() as Map<String, dynamic>).containsKey("blockedMe")==false).toList();
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot _cardYonetici = list[index];

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where("userId", isEqualTo: _cardYonetici['userid'])
                          .limit(50)
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
                            final DocumentSnapshot _card = snapshot.data.docs[index];
                            if (cardLength > totalUsers.length) {
                              totalUsers.add(_card);
                            }
                            return _userModel.user.userId == _card['userId'].toString()
                                ? Container()
                                : ResimliCard(
                                    textSubtitle: null,
                                    textTitle: _card['ad'].toString(),
                                    fontSize: 12.0.spByWidth,
                                    img: _card['avatarImageUrl'].toString(),
                                    tarih: null,
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true).push(
                                        MaterialPageRoute(
                                          builder: (context) => ChangeNotifierProvider(
                                            create: (context) => ChatViewModel(
                                                currentUser: _userModel.user,
                                                sohbetEdilenUser: Users.fromMap(_card.data())),
                                            child: SohbetPage(
                                                fotourl: _card['avatarImageUrl'].toString(),
                                                userad: _card['ad'].toString(),
                                                userid: _card['userId']),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          },
                        );
                      },
                    );
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
        //snapshot.data[index].toString()

        return ResimliCard(
            textSubtitle: null,
            textTitle: snapshot.data[index]['ad'].toString(),
            onPressed: () {},
            fontSize: 12.0.spByWidth,
            img: snapshot.data[index]['avatarImageUrl'].toString(),
            tarih: null);
      },
      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: !isSearching
            ? Text(
                "Kişi Seç",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 21.7.spByWidth),
              )
            : TextField(
                onChanged: (text) => _searchUser(text),
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: "Arayınız...",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
        leading: IconButton(
          icon: Platform.isAndroid
              ? Icon(
                  Icons.arrow_back,
                  color: Colors.deepPurpleAccent,
                  size: 18.0.h,
                )
              : Icon(
                  Icons.arrow_back_ios,
                  color: Colors.deepPurpleAccent,
                  size: 18.0.h,
                ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0.0,
        brightness: Brightness.light,
        // status bar brightness
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    // totalUsers=[];
                    setState(() {
                      isSearching = false;
                      userBloc.userController.sink.add(null);
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    // totalUsers=[];
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: usersWidget(),
      ),
    );
  }
}
