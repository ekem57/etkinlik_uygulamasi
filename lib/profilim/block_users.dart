import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:provider/provider.dart";

FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class BlockUserPage extends StatefulWidget {
  const BlockUserPage({Key key}) : super(key: key);

  @override
  _BlockUserPageState createState() => _BlockUserPageState();
}

class _BlockUserPageState extends State<BlockUserPage> {
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
          title: Text("Engellenenler",
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
        body: FutureBuilder<List<BlockedUser>>(
          future: _firestoreDBService.getBlockedUsers(context.read<UserModel>().user.userId),
          builder: (context, snapshot) {
            if(snapshot.hasData)
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Slidable(
                      actionPane: SlidableScrollActionPane(),
                      secondaryActions: [
                        IconSlideAction(
                          color: Colors.blue,
                          icon: Icons.delete_forever,
                          onTap: () async {
                            var blockedUserId = snapshot.data[index].userId;
                            var userId = context.read<UserModel>().user.userId;
                            await _firestoreDBService.deleteBlockedUser(blockedUserId, userId);
                            context.read<UserModel>().removeBlockUser(blockedUserId);
                            setState(() {
                            });
                          },
                        ),
                      ],
                      child: ListTile(
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0.spByWidth),
                        ),
                      ),
                    ));
            return Center(child: CircularProgressIndicator());
          }
        ));
  }
}
