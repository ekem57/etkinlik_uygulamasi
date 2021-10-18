import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class UyeTipleri extends StatefulWidget {
  @override
  _UyeTipleriState createState() => _UyeTipleriState();
}

class _UyeTipleriState extends State<UyeTipleri> {
  String seciliPlus = "Aylık";
  String seciliGold = "Aylık";

  String ucretPlus = "50,00";
  String ucretGold = "70,00";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
          brightness: Brightness.light,
          title: Text("Üyelikler",
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 21.7.spByWidth),
              textAlign: TextAlign.center),
        ),
        body: ListView(children: [
          Container(
            height: 430.0.h,
            margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 15.0.h),
//              alignment: Alignment.bo,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/uyelik_tip_bg.png"),
                  alignment: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(17.0.h)),
                boxShadow: [
                  BoxShadow(color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14, spreadRadius: 0)
                ],
                color: Theme.of(context).backgroundColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 56.0.w,
                      height: 56.0.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x2e000000), offset: Offset(0, 5), blurRadius: 18, spreadRadius: 0)
                          ],
                          color: Theme.of(context).backgroundColor),
                      child: Icon(Icons.account_box),
                    ),
                    Text("STANDART ÜYELİK",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w700,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.7.spByWidth),
                        textAlign: TextAlign.center),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20.0.h,
                        ),

                        Text("Ücretsiz",
                            style: TextStyle(
                                color: const Color(0xffcc59d2),
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 17.3.spByWidth),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0.h,),
                Container(
                  height: 334.0.h,
                  child: Align(
                    alignment:Alignment.topLeft,
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text("Etkinlik Açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkinliğe Katılma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mesaj Gönderme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Arkadaş Ekleme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Profil Düzenleme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Gelen Mesajları Görme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 18.0.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Özel etkinlik daveti alma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Profil onaylatma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Herkese Mesaj Gönderme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Bölgeye göre eklinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Yaşa göre eklinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Özel Ekinlik Acma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Cinsiyete göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mesleğe göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Turnuva etkinliği oluşturma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkinliğe kimler katılmış görebilme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("İlişki durumuna göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkileşimde olduğu kişilere yorum yapma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkileşimde olduğu kişileri oylama",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),

                    ),
                  ),
                ),
                Spacer(),

              ],
            ),
          ),
          Container(
            height: 500.0.h,
            margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 15.0.h),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/uyelik_tip_bg.png"),
                  alignment: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(17.0.h)),
                boxShadow: [
                  BoxShadow(color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14, spreadRadius: 0)
                ],
                color: Theme.of(context).backgroundColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 56.0.w,
                      height: 56.0.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x2e000000), offset: Offset(0, 5), blurRadius: 18, spreadRadius: 0)
                          ],
                          color: Theme.of(context).backgroundColor),
                      child: Icon(Icons.account_box),
                    ),
                    Text("PLUS ÜYELİK",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w700,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.7.spByWidth),
                        textAlign: TextAlign.center),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20.0.h,
                        ),
                        DropdownButton<String>(
                          items: ["Aylık", "3 Aylık", "6 Aylık", "12 Aylık"]
                              .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e,
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7.spByWidth),
                                      textAlign: TextAlign.center)))
                              .toList(),
                          onChanged: (String string) {
                            setState(() {
                              seciliPlus=string;
                              if(seciliPlus=="Aylık"){
                                setState(() {
                                  ucretPlus="50,00";
                                });
                              }else if(seciliPlus=="3 Aylık"){
                                setState(() {
                                  ucretPlus="150,00";
                                });
                              }else if(seciliPlus=="6 Aylık"){
                                setState(() {
                                  ucretPlus="300,00";
                                });
                              }else if(seciliPlus=="12 Aylık"){
                                setState(() {
                                  ucretPlus="600,00";
                                });
                              }

                            });
                          },
                          value: seciliPlus,
                        ),
                        Text(ucretPlus+" TL",
                            style: TextStyle(
                                color: const Color(0xffcc59d2),
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 17.3.spByWidth),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0.h,),
                Container(
                  height: 334.0.h,
                  child: Align(
                    alignment:Alignment.topLeft,
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text("Etkinlik Açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkinliğe Katılma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mesaj Gönderme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Arkadaş Ekleme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Profil Düzenleme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Gelen Mesajları Görme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 18.0.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Özel etkinlik daveti alma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Profil onaylatma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Herkese Mesaj Gönderme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Bölgeye göre eklinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Yaşa göre eklinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Özel Ekinlik Acma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Cinsiyete göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mesleğe göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Turnuva etkinliği oluşturma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkinliğe kimler katılmış görebilme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("İlişki durumuna göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkileşimde olduğu kişilere yorum yapma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkileşimde olduğu kişileri oylama",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),

                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 157.3333333333333.w,
                  height: 35.666666666666664.h,
                  margin: EdgeInsets.only(bottom: 16.0.h),
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(65.7.w),
                    ),
                    onPressed: () {},
                    elevation: 8.3,
                    child: Text(
                      "Satın Al",
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 500.0.h,
            margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 15.0.h),
//              alignment: Alignment.bo,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/uyelik_tip_bg.png"),
                  alignment: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(17.0.h)),
                boxShadow: [
                  BoxShadow(color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14, spreadRadius: 0)
                ],
                color: Theme.of(context).backgroundColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 56.0.w,
                      height: 56.0.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x2e000000), offset: Offset(0, 5), blurRadius: 18, spreadRadius: 0)
                          ],
                          color: Theme.of(context).backgroundColor),
                      child: Icon(Icons.account_box),
                    ),
                    Text("GOLD ÜYELİK",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w700,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.7.spByWidth),
                        textAlign: TextAlign.center),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20.0.h,
                        ),
                        DropdownButton<String>(
                          items: ["Aylık", "3 Aylık", "6 Aylık", "12 Aylık"]
                              .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e,
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7.spByWidth),
                                      textAlign: TextAlign.center)))
                              .toList(),
                          onChanged: (String string) {
                            setState(() {
                              seciliGold=string;
                              if(seciliGold=="Aylık"){
                                setState(() {
                                  ucretGold="50,00";
                                });
                              }else if(seciliGold=="3 Aylık"){
                                setState(() {
                                  ucretGold="150,00";
                                });
                              }else if(seciliGold=="6 Aylık"){
                                setState(() {
                                  ucretGold="300,00";
                                });
                              }else if(seciliGold=="12 Aylık"){
                                setState(() {
                                  ucretGold="600,00";
                                });
                              }

                            });
                          },
                          value: seciliGold,
                        ),
                        Text(ucretGold+" TL",
                            style: TextStyle(
                                color: const Color(0xffcc59d2),
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 17.3.spByWidth),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 330.0.h,
                  child: Align(
                    alignment:Alignment.topLeft,
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text("Etkinlik Açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkinliğe Katılma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mesaj Gönderme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Arkadaş Ekleme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Profil Düzenleme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 18.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Gelen Mesajları Görme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 18.0.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Özel etkinlik daveti alma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Profil onaylatma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Herkese Mesaj Gönderme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("Bölgeye göre eklinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Yaşa göre eklinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Özel Ekinlik Acma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Cinsiyete göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mesleğe göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Turnuva etkinliği oluşturma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkinliğe kimler katılmış görebilme",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text("İlişki durumuna göre etkinlik açma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkileşimde olduğu kişilere yorum yapma",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Etkileşimde olduğu kişileri oylama",
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.left),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 16.0.h,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),

                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 157.3333333333333.w,
                  height: 35.666666666666664.h,
                  margin: EdgeInsets.only(bottom: 16.0.h),
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(65.7.w),
                    ),
                    onPressed: () {},
                    elevation: 8.3,
                    child: Text(
                      "Satın Al",
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
