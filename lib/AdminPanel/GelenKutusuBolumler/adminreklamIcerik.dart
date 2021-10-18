import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/adminuyeprofilsayfasi.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminkullaniciprofilgorme.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class AdminReklamIcerik extends StatefulWidget {

  final DocumentSnapshot card;
  final String tarih;
  AdminReklamIcerik({this.card,this.tarih});

  @override
  _AdminReklamIcerikState createState() => _AdminReklamIcerikState();
}

class _AdminReklamIcerikState extends State<AdminReklamIcerik> {
  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();


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
            widget.card['gonderenIsim'].toString(),
            style:  TextStyle(
                color:  Renkler.appbarTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle:  FontStyle.normal,
                fontSize: 20.0.spByWidth
            ),
            textAlign: TextAlign.center
        ),
        leading:  Padding(
          padding:  EdgeInsets.only(left: 20.0.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,size: 20.0.w,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 20.0.w),
            child: IconButton(onPressed: (){
              var dialog = CustomAlertDialog(
                  message: "Bu içerği silmek istediğinize emin misiniz?",
                  onPostivePressed: () async {

                    await _adminIslemleri.adminReklamlarSil(widget.card);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onNegativePressed: (){

                  },
                  positiveBtnText: 'Evet',
                  negativeBtnText: 'İptal');
              showDialog(
                  context: context,
                  builder: (BuildContext context) => dialog);
            }, icon: Icon(Icons.delete,color: Colors.white,size: 25.0.w,)),
          ),
        ],
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

              Padding(
                padding:  EdgeInsets.only(left: 30.0.w,bottom: 10.0.h),
                child: Row(
                  children: [
                    Icon(Icons.date_range,color: Colors.blue,),
                    SizedBox(width: 7,),
                    Text(
                        widget.tarih.toString(),
                        style:  TextStyle(
                            color:  const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Arial",
                            fontStyle:  FontStyle.normal,
                            fontSize: 12.3.spByWidth
                        ),
                        textAlign: TextAlign.center
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 30.0.w,bottom: 10.0.w),
                child: Row(
                  children: [
                    Icon(Icons.email,color: Colors.blue,),
                    SizedBox(width: 7.0.w,),
                    GestureDetector(
                      onTap: () async {
                        DocumentSnapshot _docuser = await FirebaseFirestore.instance.collection("users").doc(widget.card['gonderenUserId']).get();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminUyeKullaniciProfili(card: _docuser.data(),)),);

                      },
                      child: Text(
                          widget.card['gonderenEmail'].toString(),
                          style:  TextStyle(
                            color:  const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle:  FontStyle.normal,
                            fontSize: 13.3.spByWidth,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 30.0.h,),
              Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.0.w),
                  child: Text(
                      widget.card['mesaj'].toString(),
                      style:  TextStyle(
                          color:  const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle:  FontStyle.normal,
                          fontSize: 14.0.spByWidth
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
              ),


            ],
          ),
        ),
      ),



    );
  }
}
