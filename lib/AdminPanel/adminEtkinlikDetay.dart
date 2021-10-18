import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/kullaniciKarsiProfil.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/fullresim.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class AdminEtkinlikDetay extends StatefulWidget {

  final DocumentSnapshot card;
  AdminEtkinlikDetay({this.card});

  @override
  _AdminEtkinlikDetayState createState() => _AdminEtkinlikDetayState();
}

class _AdminEtkinlikDetayState extends State<AdminEtkinlikDetay> {
  DocumentSnapshot etsahibi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    etSahibiGetir();
  }


  Future<void> etSahibiGetir() async {

    DocumentSnapshot documentSnapshot=  await FirebaseFirestore.instance.collection('users').doc(widget.card['userId']).get();
    etsahibi=documentSnapshot;


    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();


    return Scaffold(
      backgroundColor: Renkler.backGroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Renkler.appbarIconColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light, // status bar brightness
      ),
      body: Stack(
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName:  widget.card['etkinlikFoto'].toString())),);

            },
            child: CachedNetworkImage(
              imageUrl: widget.card['etkinlikFoto'].toString(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                   ),
                ),
              ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 190),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 35.0.w,top: 20.0.w,right: 28.0.w),
              child: ListView(
                shrinkWrap: true,
                padding:EdgeInsets.only() ,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.card['baslik'].toString(),
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w800,
                            fontFamily: 'OpenSans',
                            fontStyle: FontStyle.normal,
                            fontSize: 18.3.spByWidth),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: 21.0.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 20.0.h,
                      ),
                      SizedBox(
                        width: 13.0.w,
                      ),
                      Text(widget.card['keywords'][5].toString(),
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 13.3.spByWidth),
                          textAlign: TextAlign.center)
                    ],
                  ),
                  SizedBox(
                    height: 21.0.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 20.0.h,
                      ),
                      SizedBox(
                        width: 13.0.w,
                      ),
                      Text(formatTheDate(widget.card['tarih'].toDate()),
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 13.3.spByWidth),
                          textAlign: TextAlign.center)
                    ],
                  ),
                  SizedBox(
                    height: 21.0.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 20.0.h,
                      ),
                      SizedBox(
                        width: 13.0.w,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminKarsiKullaniciProfili(card: etsahibi.data(),)),
                          );
                        },
                        child: Text(widget.card['yayinlayanAdSoyad'].toString(),
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 13.3.spByWidth),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        width: 8.0.w,
                      ),
                      Icon(
                        Icons.check,
                        color: Theme.of(context).accentColor,
                        size: 20.0.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 21.0.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).buttonColor,
                        size: 20.0.h,
                      ),
                      SizedBox(
                        width: 13.0.w,
                      ),
                      Expanded(
                        child: Text(widget.card['konum'].toString(),
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 13.3.spByWidth),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 21.0.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("HAKKINDA",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w700,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.7.spByWidth),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: 18.0.h,
                  ),
                  Text(widget.card['hakkinda'].toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0.spByWidth),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20.0.w,),
//                Spacer(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(text: "Onayla", butonColor: Renkler.onayButonColor,width: 220.0.w,height: 43.0.h,onPressed: (){
                      var dialog = CustomAlertDialog(
                          message: "Bu etkinliği onaylamak istediğinize emin misiniz?",
                          onPostivePressed: () {
                            _adminIslemleri.adminEtkinlikOnayla(widget.card);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          onNegativePressed: (){
                            Navigator.pop(context);
                          },
                          positiveBtnText: 'Evet',
                          negativeBtnText: 'Hayır');

                      showDialog(
                          context: context,
                          builder: (BuildContext context) => dialog);
                    },),
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(text: "Reddet", butonColor: Renkler.reddetButonColor,width: 220.0.w,height: 43.0.h,onPressed: (){

                      _showPickerEtkinlikReddet(context,widget.card);
                    }),
                  ),
                  SizedBox(height: 40.0.h,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPickerEtkinlikReddet(context,DocumentSnapshot _card) {
    AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Uygunsuz Fotoğraf'),
                      onTap: () async {
                        var dialog = CustomAlertDialog(
                            message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                            onPostivePressed: () {
                              String mesaj= _card['baslik']+" başlıklı etkinliğiniz uygunsuz fotoğraftan dolayı reddedildi.";
                              _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
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

                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Uygunsuz Başlık'),
                    onTap: () async {
                      var dialog = CustomAlertDialog(
                          message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                          onPostivePressed: () {
                            String mesaj= _card['baslik']+" başlıklı etkinliğiniz uygunsuz başlıktan dolayı reddedildi.";
                            _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
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

                    },
                  ),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Uygunsuz İçerik'),
                    onTap: () async {
                      var dialog = CustomAlertDialog(
                          message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                          onPostivePressed: () {
                            String mesaj= _card['baslik']+" başlıklı etkinliğiniz uygunsuz içerikten dolayı reddedildi.";
                            _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
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

                    },
                  ),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Diğer'),
                    onTap: () async {
                      var dialog = CustomAlertDialog(
                          message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                          onPostivePressed: () {
                            String mesaj= _card['baslik']+" başlıklı etkinliğiniz  reddedildi.";
                            _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
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

                    },
                  ),


                ],
              ),
            ),
          );
        });
  }
}