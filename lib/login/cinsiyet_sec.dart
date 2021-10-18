import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/login/TelefonGiris.dart';
import 'package:etkinlik_kafasi/main_navigation.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/widgets/right_arrow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CinsiyetSec extends StatefulWidget {
  final Users userdoc;

  CinsiyetSec({
    Key key,
    @required this.userdoc,
  }) : super(key: key);

  @override
  _CinsiyetSecState createState() => _CinsiyetSecState();
}

class _CinsiyetSecState extends State<CinsiyetSec> {
  String cinsiyet = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 17.0.w,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          brightness: Brightness.light, // status bar brightness
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 32.70.h),
          child: Column(
            children: [
              Text(
                "Cinsiyetiniz",
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.italic,
                    fontSize: 25.0.spByWidth),
              ),
              Padding(
                padding: EdgeInsets.only(top: 41.0.h, bottom: 28.0.h),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cinsiyet = "Kadın";
                      Provider.of<Users>(context, listen: false).cinsiyet = cinsiyet;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: 120.0.w,
                        height: 120.0.w,
//                    margin: EdgeInsets.only(top: 41.3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.0.w),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x24000000),
                                offset: Offset(6.123233995736766e-16, 10),
                                blurRadius: 31.70,
                                spreadRadius: 0)
                          ],
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/kadin_logo.png",
                              width: 31.70.w,
                              height: 55.30.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 3.0.h,
                            ),
                            Text(
                              "Kadın",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.3.spByWidth),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: cinsiyet == "Kadın",
                        child: Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: Container(
                            width: 35.0.w,
                            height: 35.0.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.0.w),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x24000000),
                                    offset: Offset(6.123233995736766e-16, 10),
                                    blurRadius: 31.70,
                                    spreadRadius: 0)
                              ],
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 25.0.w,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cinsiyet = "Erkek";
                    Provider.of<Users>(context, listen: false).cinsiyet = cinsiyet;
                  });
                },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 120.0.w,
                      height: 120.0.w,
//                    margin: EdgeInsets.only(top: 41.3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0.w),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x24000000),
                              offset: Offset(6.123233995736766e-16, 10),
                              blurRadius: 31.70,
                              spreadRadius: 0)
                        ],
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/erkek_logo.png",
                            width: 44.30.w,
                            height: 46.70.h,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: 3.0.h,
                          ),
                          Text(
                            "Erkek",
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 18.3.spByWidth),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: cinsiyet == "Erkek",
                      child: Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          width: 35.0.w,
                          height: 35.0.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0.w),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x24000000),
                                  offset: Offset(6.123233995736766e-16, 10),
                                  blurRadius: 31.70,
                                  spreadRadius: 0)
                            ],
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 25.0.w,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0.h),
                child: ArrowRight(
                  onPressed: () {
                    if (cinsiyet.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Lütfen Cinsiyet seçimi yapınız!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        textColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => TelefonGiris(
                            userdoc: Users(
                                email: widget.userdoc.email,
                                dogumTarihi: widget.userdoc.dogumTarihi,
                                password: widget.userdoc.password,
                                adsoyad: widget.userdoc.adsoyad,
                                meslek: widget.userdoc.meslek,
                                iliskiDurumu: widget.userdoc.iliskiDurumu,
                                cinsiyet: cinsiyet,
                                sehir: widget.userdoc.sehir,
                                ogrenimDurumu: widget.userdoc.ogrenimDurumu,
                                uyelikTipi: widget.userdoc.hesapTipi)),
                      ),
                    );
                    // yeniKullaniciOlustur(widget.userdoc.email,widget.userdoc.password,widget.userdoc);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // Future<void> yeniKullaniciOlustur(String mail, String password, Users usersNotifier) async {
  //   print(usersNotifier.toString());
  //   UserCredential _credential;
  //   try {
  //     _credential = await _auth.createUserWithEmailAndPassword(
  //       email: mail,
  //       password: password,
  //     );
  //     print("kullanıcı kaydedildi*********");
  //   } catch (e) {
  //     print("HATAA***** VERİLER KAYDEDİLMEDİİİ....." + e.toString());
  //   }
  //   User _yeniUser = _credential.user;
  //   await _yeniUser.sendEmailVerification();
  //   var user = Provider.of<Users>(context, listen: false);
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(_credential.user.uid)
  //       .set(user.toMap(usersNotifier, _credential.user.uid))
  //       .then((a) {
  //     Provider.of<Users>(context, listen: false).userId = _credential.user.uid;
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => MainNavigation()), (route) => false);
  //   });
  // }
}
