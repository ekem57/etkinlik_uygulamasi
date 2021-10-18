import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:etkinlik_kafasi/models/profil_kafalar.dart';
import 'package:etkinlik_kafasi/profilim/profil_listTitle.dart';
import 'package:etkinlik_kafasi/profilim/profile_bakanlar.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  List<String> kafalar_sayilar;
  List<String> kafalarlar;
  List<Map<String, String>> kafalar_map_list_icon = [];
  List<Profil_kafalar> kafalar_profil = [];

  About({ this.kafalar_sayilar, this.kafalarlar, this.kafalar_map_list_icon, this.kafalar_profil});

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  List<Map<String, String>> kafalar_profil_iconlar_sayilar = [];

  List<int> Listsayilar = [];
  int tiklanan_index = 20;

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    return ListView(
      padding: EdgeInsets.only(top: 10.0, left: 8.0.w, right: 16.0.w),
      children: [
        //TODO ListTile ile arası padding sıkıştılılacak...

        ProfilListTile(
          title: "Doğum Tarihi",
          icon: Icon(
            Icons.cake,
            size: 24.0.h,
            color: Theme.of(context).primaryColor,
          ),
          trailingTitle: formatTheDate(_userModel.user.dogumTarihi, format: DateFormat("d.M.y")) ?? "",
        ),
        ProfilListTile(
          title: "İlişki Durumu",
          icon: Icon(
            Icons.favorite,
            size: 24.0.h,
            color: Colors.red,
          ),
          trailingTitle: _userModel.user.iliskiDurumu ?? "",
        ),
        ProfilListTile(
          title: "Meslek",
          icon: Icon(
            Icons.work,
            size: 24.0.h,
            color: Theme.of(context).accentColor,
          ),
          trailingTitle: _userModel.user.meslek ?? "",
        ),
        ProfilListTile(
          title: "Öğrenim Durumu:",
          icon: Icon(
            Icons.school,
            size: 24.0.h,
            color: Theme.of(context).accentColor,
          ),
          trailingTitle: _userModel.user.ogrenimDurumu ?? "",
        ),
        InkWell(
          onTap: (){
            if(_userModel.user.uyelikTipi != "gold"){
              Fluttertoast.showToast(
                msg: "Bu Özelliklik Sadece Gold Üyeler İçin Kullanılablir!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                backgroundColor: Colors.black,
              );
              return;
            }
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProfileBakanlar()));
          },
          child: ProfilListTile(
            title: "Profilime Kim Baktı?",
            icon: Icon(
              Icons.account_box,
              size: 24.0.h,
              color: Theme.of(context).primaryColor,
            ),
            trailingTitle: "",
          ),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL(_userModel.user.facebook);
                },
                child: Image.asset(
                  "assets/facebook_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
//                          alignment: Alignment.bottomRight,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(_userModel.user.twitter);
                },
                child: Image.asset(
                  "assets/twitter_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
//                          alignment: Alignment.bottomRight,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(_userModel.user.instagram);
                },
                child: Image.asset(
                  "assets/instagram_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
//                          alignment: Alignment.bottomRight,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(_userModel.user.tiktok);
                },
                child: Image.asset(
                  "assets/tiktok_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
//                          alignment: Alignment.bottomRight,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),

        widget.kafalar_profil.isNotEmpty
            ? GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                padding: EdgeInsets.fromLTRB(23.0.w, 25.0.h, 23.0.w, 30.0.h),
                mainAxisSpacing: 8.0.h,
                crossAxisSpacing: 18.0.w,
                children: List.generate(8, (index) {
                  var seletectedColor = widget.kafalarlar.contains(profil_iconlar[index]["title"]) ? Theme.of(context).accentColor : Colors.white;

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 80.66666666666667.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
                        boxShadow: [BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)],
                        color: seletectedColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.saturation),
                            child: Image.asset(
                              widget.kafalar_profil[index].icon,
                              width: 50.0.w,
                              height: 25.0.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.kafalar_profil[index].name,
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 11.3.spByWidth),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.kafalar_profil[index].sayi.toString(),
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 11.3.spByWidth),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            : Container(),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(
            _userModel.user.hakkimda.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),

        SizedBox(
          height: 100.0.h,
        ),
      ],
    );
  }

  _launchURL(String url) async {
    print("url " + url.toString());
    if (url != "") {
      if (await canLaunch(url)) {
        print("1");
        await launch(url);
      } else {
        print("2");
        Fluttertoast.showToast(
          msg: "Geçerli link yok!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.purpleAccent,
        );
      }
    } else {
      print("3");
      Fluttertoast.showToast(
        msg: "Link tanımsız!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
