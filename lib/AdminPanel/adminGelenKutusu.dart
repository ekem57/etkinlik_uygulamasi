import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/GelenKutusuBolumler/diger.dart';
import 'package:etkinlik_kafasi/AdminPanel/GelenKutusuBolumler/mavitiktalepleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/GelenKutusuBolumler/oneriler.dart';
import 'package:etkinlik_kafasi/AdminPanel/GelenKutusuBolumler/reklamTalepleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminSikayetler.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/widgets/ResimsizCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class AdminGelenKutusu extends StatefulWidget {
  @override
  _AdminGelenKutusuState createState() => _AdminGelenKutusuState();
}

class _AdminGelenKutusuState extends State<AdminGelenKutusu> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Renkler.appbarIconColor),
        toolbarHeight: 70.0,
        title: Text(
            "Gelen Kutusu",
            style:  TextStyle(
                color:  Renkler.appbarTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle:  FontStyle.normal,
                fontSize: 20.0.spByWidth
            ),
            textAlign: TextAlign.center
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 8,
                blurRadius: 7,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: ListView(
            children: [
              SizedBox(height: 40.0.h,),
              ResimsizCard(textTitle: "Şikayetler", onPressed: (){
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AdminSikayetler()),);

              }, bildirimSayisi: 1,collec1:"iletisim",doc: "sikayet",collec2: "sikayetler",),
              ResimsizCard(textTitle: "Öneriler", onPressed: (){
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AdminOneriler()),);
              }, bildirimSayisi: 1,collec1:"iletisim",doc: "oneri",collec2: "oneriler",),
              ResimsizCard(textTitle: "Reklam Talepleri", onPressed: (){
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AdminReklamTalepleri()),);
              }, bildirimSayisi: 3,collec1:"iletisim",doc: "reklam",collec2: "reklamlar",),
              ResimsizCard(textTitle: "Mavi Tik Talepleri", onPressed: (){
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AdminMaviTalepleri()),);
              }, bildirimSayisi: 1,collec1:"iletisim",doc: "mavitik",collec2: "mavitikler",),
              ResimsizCard(textTitle: "Diğer", onPressed: (){
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>Diger()),);
              }, bildirimSayisi: 3,collec1:"iletisim",doc: "diger",collec2: "digerleri",),
            ],
          ),
        ),
      ),



    );
  }
}
