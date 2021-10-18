import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/login/sifre_degistir.dart';
import 'package:etkinlik_kafasi/profilim/block_users.dart';
import 'package:etkinlik_kafasi/profilim/profil_ayarlari.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class AyarlarView extends StatefulWidget {
  @override
  _AyarlarViewState createState() => _AyarlarViewState();
}

class _AyarlarViewState extends State<AyarlarView> {
  bool bildirimlerSwitch = true;
  bool gizlilikSwitch = false;
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    FirebaseFirestore.instance
        .doc("tokens/" + _userModel.user.userId).get().then((value) async {

          print("value init gelen: "+value['token'].toString());
      if(value['token']== "false"){
       setState(() {
         bildirimlerSwitch=false;
       });
      }else{
       setState(() {
         bildirimlerSwitch=true;
       });
      }

    });


   gizlilikSwitch=_userModel.user.profilgizlilik;
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
       // permissionStatusFuture = getCheckNotificationPermStatus();
      });
    }
  }
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {

    final _userModel = Provider.of<UserModel>(context);
    return Scaffold(
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
            title: Text("Ayarlar",
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
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg_curve.png"),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                  child: Container(
                    width: 329.6666666666667.w,
                    height: 60.333333333333336.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14.30, spreadRadius: 0)
                        ],
                        color: Theme.of(context).backgroundColor),
                    child: ListTile(
                      title: Text("Profil Ayarları",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.spByWidth),
                          textAlign: TextAlign.left),
                      leading: Icon(
                        Icons.person,
                        size: 24.0.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => ProfilAyarlari(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: 329.6666666666667.w,
                  height: 60.333333333333336.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14.30, spreadRadius: 0)
                      ],
                      color: Theme.of(context).backgroundColor),
                  child: ListTile(
                    title: Text("Şifre Değiştir",
                        style:
                        TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.7.spByWidth),
                        textAlign: TextAlign.left),
                    leading: Icon(
                      Icons.lock,
                      size: 24.0.h,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (c) => SifreDegistir()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16.0.h),
                  child: Container(
                    width: 329.6666666666667.w,
                    height: 60.333333333333336.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14.30, spreadRadius: 0)
                        ],
                        color: Theme.of(context).backgroundColor),
                    child: ListTile(
                      title: Text("Engelli Kullanıcılar",
                          style:
                          TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.spByWidth),
                          textAlign: TextAlign.left),
                      leading: Icon(
                        Icons.block,
                        size: 24.0.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (c) => BlockUserPage()));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                  child: Container(
                    width: 329.6666666666667.w,
                    height: 60.333333333333336.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14.30, spreadRadius: 0)
                        ],
                        color: Theme.of(context).backgroundColor),
                    child: ListTile(
                        title: Text("Bildirimler",
                            style:  TextStyle(
                                color:  Color(0xff343633),
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.7.spByWidth),
                            textAlign: TextAlign.left),
                        leading: Icon(
                          Icons.notifications,
                          size: 24.0.h,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {},
                        trailing: Switch(
                          value: bildirimlerSwitch,
                          onChanged: (bool newValue)  async {
                            FirebaseFirestore.instance
                                .doc("tokens/" + _userModel.user.userId).get().then((value) async {

                            print("gelen token degeri:"+value['token']);


                              if(value['token'] == "false"){


                                setState(() {
                                  bildirimlerSwitch=true;
                                });

                                await firebaseMessaging.getToken().then((value) async {
                                  FirebaseFirestore.instance
                                      .doc("tokens/" + _userModel.user.userId)
                                      .set({"token": value});
                                });

                                await FirebaseMessaging.instance.subscribeToTopic('allusers');

                                await FirebaseMessaging.instance.unsubscribeFromTopic('false');






                              }else{
                                setState(() {
                                  bildirimlerSwitch=false;
                                });

                                FirebaseFirestore.instance
                                    .doc("tokens/" + _userModel.user.userId)
                                    .set({"token": "false"});

                                await FirebaseMessaging.instance.subscribeToTopic('false');

                                await FirebaseMessaging.instance.unsubscribeFromTopic('allusers');

                              }



                            });
                          },
                          activeTrackColor: Theme.of(context).accentColor,
                          activeColor: Theme.of(context).buttonColor,
                        )),
                  ),
                ),



                Container(
                  width: 329.6666666666667.w,
                  height: 60.333333333333336.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14.30, spreadRadius: 0)
                      ],
                      color: Theme.of(context).backgroundColor),
                  child: ListTile(
                      title: Text("Profilimi Gizle",
                          style:  TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.spByWidth),
                          textAlign: TextAlign.left),
                      leading: Icon(
                        Icons.lock,
                        size: 24.0.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {},
                      trailing: Switch(
                        value: gizlilikSwitch,
                        onChanged: (bool newValue) {
                          setState(() {
                            gizlilikSwitch = newValue;
                          });
                          _userModel.user.profilgizlilik=gizlilikSwitch;
                          _firestoreDBService.updategizlilik(_userModel.user.userId, gizlilikSwitch);
                        },
                        activeTrackColor: Theme.of(context).accentColor,
                        activeColor: Theme.of(context).buttonColor,
                      )),
                  ),

              ],
            ),
          ));
  }
}
