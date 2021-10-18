import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:etkinlik_kafasi/models/profil_kafalar.dart';
import 'package:etkinlik_kafasi/profilim/profil_listTitle.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class KarsiProfilAbout extends StatefulWidget {
  String userid;
  String karsiuserid;
  String hakkimda;
  List<String> kafalar_sayilar;
  List<String> kafalarlar;
  List<Map<String,String>> kafalar_map_list_icon = [];
  List<Profil_kafalar> kafalar_profil = [];
  final Map<String, dynamic> card;
  KarsiProfilAbout({this.userid,this.karsiuserid,this.kafalar_sayilar,this.kafalarlar,this.kafalar_map_list_icon,this.kafalar_profil,this.hakkimda,this.card});
  @override
  _KarsiProfilAboutState createState() => _KarsiProfilAboutState();
}

class _KarsiProfilAboutState extends State<KarsiProfilAbout> {
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  List<Map<String,String>> kafalar_profil_iconlar_sayilar = [];

  List<int> Listsayilar=[];
  int tiklanan_index=20;
  @override
  Widget build(BuildContext context) {
    print("karsi profil about dayim");
    final _userModel = Provider.of<UserModel>(context);

    return  ListView(
      padding: EdgeInsets.only(top: 10.0, left: 8.0.w, right: 16.0.w),
      children: [


        ProfilListTile(
          title: "Doğum Tarihi",
          icon: Icon(
            Icons.cake,
            size: 24.0.h,
            color: Theme.of(context).primaryColor,
          ),
          trailingTitle: formatTheDate(widget.card['dogumTarihi'].toDate(), format: DateFormat("d.M.y")) ?? "",
        ),
        ProfilListTile(
          title: "İlişki Durumu",
          icon: Icon(
            Icons.favorite,
            size: 24.0.h,
            color: Colors.red,
          ),
          trailingTitle: widget.card['iliskiDurumu'] ?? "",
        ),
        ProfilListTile(
          title: "Meslek",
          icon: Icon(
            Icons.work,
            size: 24.0.h,
            color: Theme.of(context).accentColor,
          ),
          trailingTitle:  widget.card['meslek'] ?? "",
        ),
        ProfilListTile(
          title: "Öğrenim Durumu:",
          icon: Icon(
            Icons.school,
            size: 24.0.h,
            color: Theme.of(context).accentColor,
          ),
          trailingTitle: widget.card['ogrenimdurumu'] ?? "",
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
                onTap: (){
                  _launchURL(widget.card['facebook']);
                },
                child: Image.asset(
                  "assets/facebook_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: (){
                  _launchURL(widget.card['twitter']);
                },
                child: Image.asset(
                  "assets/twitter_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: (){
                  _launchURL(widget.card['instagram']);
                },
                child: Image.asset(
                  "assets/instagram_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: (){
                  _launchURL(widget.card['tiktok']);
                },
                child: Image.asset(
                  "assets/tiktok_icon.png",
                  width: 24.0.w,
                  height: 24.0.w,
                  fit: BoxFit.contain,
                ),
              ),

            ],

          ),
        ),


        widget.kafalar_profil.isNotEmpty ?

        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          padding: EdgeInsets.fromLTRB(23.0.w, 25.0.h, 23.0.w, 30.0.h),
          mainAxisSpacing: 8.0.h,
          crossAxisSpacing: 18.0.w,
          children: List.generate(8, (index)
          {

            print("card user id: "+  widget.card['userId']);



            var seletectedColor = widget.kafalarlar.contains(profil_iconlar[index]["title"])
                ? Theme.of(context).accentColor
                : Colors.white;



            return  GestureDetector(
              onTap: () async {
                setState(() {

                });
                if(widget.kafalarlar.contains(profil_iconlar[index]["title"])){

                  widget.kafalarlar.contains(profil_iconlar[index]["title"].toString())
                      ?
                  !widget.kafalarlar.remove(profil_iconlar[index]["title"].toString())
                      : null;
                  await _firestoreDBService.usersProfil_Kafaya_Oydan_Cikar(

                    widget.card['userId'],
                    widget.kafalarlar,
                    _userModel.user.userId,
                    widget.kafalar_profil[index].name,
                    widget.kafalar_profil[index].sayi,
                  ).then((value) {
                    widget.kafalar_profil[index].sayi=widget.kafalar_profil[index].sayi-1;
                    setState(() {});
                  });



                }else {
                  !widget.kafalarlar.contains(profil_iconlar[index]["title"].toString())
                      ?
                  widget.kafalarlar.add(profil_iconlar[index]["title"].toString())
                      : null;
                  await _firestoreDBService.usersProfil_Kafaya_Oy_Ver(
                    widget.card['userId'],
                    widget.kafalarlar,
                    _userModel.user.userId,
                    widget.kafalar_profil[index].name,
                    widget.kafalar_profil[index].sayi,
                  ).then((value) {
                    widget.kafalar_profil[index].sayi=widget.kafalar_profil[index].sayi+1;
                    setState(() {});
                  });


                }
              },
              child: Container(
                width: 80.66666666666667.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
                  boxShadow: [
                    BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
                  ],
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
        ) : Container(),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(widget.hakkimda.toString(),style: TextStyle(fontSize: 16.0.spByWidth),),
        ),

        SizedBox(height: 100.0.h,),
      ],
    );
  }

  _launchURL(String url) async {
    if (url != "" ) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("url gelen:"+url);
      }
    }else{
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
