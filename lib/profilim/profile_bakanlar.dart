import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import "package:provider/provider.dart";

FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class ProfileBakanlar extends StatefulWidget {
  const ProfileBakanlar({Key key}) : super(key: key);

  @override
  _ProfileBakanlarState createState() => _ProfileBakanlarState();
}

class _ProfileBakanlarState extends State<ProfileBakanlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 17.0.h,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Profilime Bakanlar",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 17.7.spByWidth),
              textAlign: TextAlign.center),
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: _firestoreDBService.getVisitorsData(context.read<UserModel>().user.userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slidable(
                            actionPane: SlidableScrollActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                  color: Colors.blue,
                                  icon: Icons.delete_forever,
                                  onTap: () => _firestoreDBService
                                      .deleteVisitorTile(
                                          context.read<UserModel>().user.userId, snapshot.data.docs[index].id)
                                      .then((value) => setState(() {}))),
                            ],
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data.docs[index]["image"].toString()),
                                radius: 25.70.w,
                              ),
                              onTap: () async {
                                var karsiUserId = snapshot.data.docs[index]["userId"] as String;
                                var karsiUser =
                                    await FirebaseFirestore.instance.collection('users').doc(karsiUserId).get();
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => KarsiKullaniciProfili(card: karsiUser.data())));
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data.docs[index]["name"].toString(),
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0.spByWidth),
                                  ),
                                  Text(
                                    formatTheDate(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            (snapshot.data.docs[index]["date"] as Timestamp).millisecondsSinceEpoch),
                                        format: DateFormat('dd.MM.yy HH:mm', "tr_TR")),
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        // fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.0.spByWidth),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
              }
              if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
