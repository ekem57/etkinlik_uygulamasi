import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/adminuyeprofilsayfasi.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminkullaniciprofilgorme.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/fullresim.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class MaviTikIcerik extends StatefulWidget {

  final DocumentSnapshot card;
  final String tarih;
  MaviTikIcerik({this.card,this.tarih});

  @override
  _MaviTikIcerikState createState() => _MaviTikIcerikState();
}

class _MaviTikIcerikState extends State<MaviTikIcerik> {

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
                fontSize: 20.0
            ),
            textAlign: TextAlign.center
        ),
        leading:  Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
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
              SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.only(left: 30,bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.date_range,color: Colors.blue,),
                    SizedBox(width: 7,),
                    Text(
                        widget.tarih.toString(),
                        style: const TextStyle(
                            color:  const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Arial",
                            fontStyle:  FontStyle.normal,
                            fontSize: 12.3
                        ),
                        textAlign: TextAlign.center
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.email,color: Colors.blue,),
                    SizedBox(width: 7,),
                    GestureDetector(
                      onTap: () async {
                        DocumentSnapshot _docuser = await FirebaseFirestore.instance.collection("users").doc(widget.card['gonderenUserId']).get();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminUyeKullaniciProfili(card: _docuser.data(),)),);

                      },
                      child: Text(
                          widget.card['gonderenEmail'].toString(),
                          style: const TextStyle(
                            color:  const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle:  FontStyle.normal,
                            fontSize: 13.3,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: 312.0.w,
                height: 166.0.h,
                alignment: Alignment.center,

                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: GestureDetector(
                    onTap: (){

                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: widget.card['foto'].toString())),);

                    },
                    child: Image.network(
                      widget.card['foto'],
                      width: 312.0.w,
                      height: 166.0.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                    widget.card['mesaj'].toString(),
                    style: TextStyle(
                        color:  const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle:  FontStyle.normal,
                        fontSize: 17.0.spByWidth
                    ),
                    textAlign: TextAlign.left
                ),
              ),
              SizedBox(height: 60,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 120.0.w,
                      child: RaisedButton(color: Colors.blue,
                        child: Text("Onayla"),
                        onPressed: (){
                          FirebaseFirestore.instance.collection("users").doc(widget.card['gonderenUserId']).update({'mavitik':true});
                          var dialogBilgi = AlertBilgilendirme(
                            message: "Mavi Tik Verildi.",
                            onPostivePressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );

                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialogBilgi);
                        },),
                    ),
                    SizedBox(width: 40,),
                    Container(
                      height: 30,
                      width: 120.0.w,
                      child: RaisedButton(color: Colors.blue,
                        child: Text("Reddet"),
                        onPressed: (){
                          FirebaseFirestore.instance.collection('iletisim').doc("mavitik").collection("mavitikler").doc(widget.card.id).delete();
                        },),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),



    );
  }
}
