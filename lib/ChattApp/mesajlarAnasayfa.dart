import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/ChattApp/chat_view_model.dart';
import 'package:etkinlik_kafasi/ChattApp/mesajkisiSec.dart';
import 'package:etkinlik_kafasi/ChattApp/search_message.dart';
import 'package:etkinlik_kafasi/ChattApp/sohbetPage.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/models/konusma.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MesajlarNewAnasayfa extends StatefulWidget {
  @override
  _MesajlarNewAnasayfaState createState() => _MesajlarNewAnasayfaState();
}

class _MesajlarNewAnasayfaState extends State<MesajlarNewAnasayfa> {
  bool isSearching = false;
  List<Users> totalUsers = [];
  List<Konusma> totalKonusma = [];
  List<Users> otherUsers = [];
  List data = [];

  Stream messagesCollectionStream;
  String userId;

  @override
  void initState() {
    super.initState();
    userId = context.read<UserModel>().user.userId;
    messagesCollectionStream = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("sohbetler")
        .orderBy("olusturulma_tarihi", descending: true)
        .snapshots();
  }

  Widget usersWidget() {
    return Consumer<UserModel>(
      builder: (context, model ,child)=>StreamBuilder<QuerySnapshot>(
          stream: messagesCollectionStream,
          builder: (buildContext, snapshot) {
            if (snapshot.hasData) {
              totalKonusma.clear();
              otherUsers.clear();
              var blockIds = model.user.blockedUsers.map((e) => e.userId).toList();
              var list = snapshot.data.docs
                  .where((e) => !blockIds.contains(e.get("kimle_konusuyor"))).toList();
              list = list
                  .where((element) => (element.data() as Map<String, dynamic>).containsKey("blockedMe")==false).toList();
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    var map = list[index].data() as Map<String, dynamic>;
                    var konusma = Konusma.fromMap(map);

                    return FutureBuilder<Users>(
                        future: getOtherUserData(konusma.kimle_konusuyor),
                        builder: (_, userSnapshot) {
                          if (userSnapshot.hasData) {
                            konusma.name = userSnapshot.data.adsoyad;
                            totalKonusma.add(konusma);
                            otherUsers.add(userSnapshot.data);
                            return messageTile(context, konusma: konusma, otherUser: userSnapshot.data);
                          }
                          return Container();
                        });
                  });
            }
            return Center(child: Text("Yükleniyor..."));
          })
    );
  }

  Widget messageTile(BuildContext context, {Konusma konusma, Users otherUser}) {
    var userModel = context.read<UserModel>();
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.45,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => ChatViewModel(currentUser: userModel.user, sohbetEdilenUser: otherUser),
                  child: SohbetPage(
                    fotourl: otherUser.avatarImageUrl,
                    userad: otherUser.adsoyad,
                    userid: otherUser.userId,
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 323.3333333333333.w,
            height: 66.0.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11.70)),
                boxShadow: [
                  BoxShadow(color: const Color(0x26000000), offset: Offset(0, 0), blurRadius: 5.50, spreadRadius: 0.5)
                ],
                color: Theme.of(context).backgroundColor),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0.w),
                title: Text(
                  otherUser.adsoyad,
                  style: TextStyle(
                      color: const Color(0xff343633),
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.7.h),
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(otherUser.avatarImageUrl),
                  radius: 26.0,
                ),
                trailing: Padding(
                  padding: EdgeInsets.only(top: 4.0.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "",
                        // // konusmalar[index].sonOkunmaZamani != null
                        // //     ? _saatDakikaGoster(konusmalar[index].sonOkunmaZamani)
                        //     : "",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Arial",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.3.h),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        konusma.son_yollanan_mesaj,
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight:konusma.goruldu?  FontWeight.w400: FontWeight.bold,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.3.h),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      formatTheDate(DateTime.fromMillisecondsSinceEpoch(konusma.olusturulma_tarihi.millisecondsSinceEpoch)),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight:konusma.goruldu?  FontWeight.w400: FontWeight.bold,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 10.3.h),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.70)),
          ),
          child: IconSlideAction(
              caption: 'Sil',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userModel.user.userId)
                    .collection("sohbetler")
                    .doc(otherUser.userId)
                    .delete();
              }),
        ),
      ],
    );
  }

  Future<Users> getOtherUserData(String userId) async {
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return Users.fromMap(userDoc.data());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Mesajlarım",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: "OpenSans",
              fontStyle: FontStyle.normal,
              fontSize: 21.7.spByWidth),
        ),
        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        // status bar brightness
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            onPressed: () {
              showSearch<String>(context: context, delegate: SearchMessage(totalKonusma, otherUsers));
            },
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => ChattKisiSec()),
            );
          },
          child: Icon(
            Icons.add,
            size: 30.0.w,
            color: const Color(0xff343633),
          ),
        ),
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
