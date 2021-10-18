import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminReklamOlustur.dart';
import 'package:etkinlik_kafasi/AdminPanel/reklamDuzenle.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;



class AdminReklamlar extends StatefulWidget {
  @override
  _AdminReklamlarState createState() => _AdminReklamlarState();
}

class _AdminReklamlarState extends State<AdminReklamlar> {
  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();
  ScrollController _scrollController = ScrollController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int getirilecek = 5;
  int gelen;
  bool _elemanyukle = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        getirilecek += 5;
        _elemanyukle = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      backgroundColor: Renkler.backGroundColor,
      appBar: AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text("Reklamlar",
            style: TextStyle(
                color: Renkler.appbarTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
            textAlign: TextAlign.center),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 20.0.w,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.email,
              color: Renkler.appbarButonColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton:  _userModel.user.yoneticiyetkileri.reklam_yetkisi ?
      Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom == 0
                ? 65.0.h
                : MediaQuery.of(context).viewPadding.bottom + 35.0.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xa3000000),
                  offset: Offset(3.6739403974420594e-16, 6),
                  blurRadius: 17,
                  spreadRadius: 0)
            ],
            color: Theme.of(context).buttonColor,
          ),
          child: FloatingActionButton(
            onPressed: () {

            },
            child: Icon(
              Icons.add,
              size: 28.0.h,
              color: const Color(0xff343633),
            ),
            backgroundColor: Theme.of(context).buttonColor,
          ),
        ),
      ) : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
          child:  _userModel.user.yoneticiyetkileri.reklam_yetkisi ?
          ListView(
            controller: _scrollController,
            children: [
              SizedBox(height: 20.0.h,),
              InkWell(
                onTap: () {},
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('reklamlar')
                      .orderBy('tarih', descending: true)
                      .limit(50)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      _elemanyukle = false;
                    }
                    final int cardLength = snapshot.data.docs.length;
                    gelen = cardLength;

                    return cardLength == 0
                        ? Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("Reklam Yok")),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cardLength,
                            itemBuilder: (_, int index) {
                              final DocumentSnapshot _card = snapshot.data.docs[index];
                              return _card['link'].toString() == ""
                                  ? Padding(
                                      padding:  EdgeInsets.only(left: 30.0.w, right: 30.0.w, top: 20.0.h, bottom: 20.0.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(11.70.w),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color(0x29000000),
                                                offset: Offset(0, 2),
                                                blurRadius: 22.70,
                                                spreadRadius: 0)
                                          ],
                                          color: Theme.of(context).backgroundColor,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                  child: Container(
                                                    color: Colors.redAccent,
                                                    height: (MediaQuery.of(context).size.height * 25) / 100,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: CachedNetworkImage(
                                                      imageUrl: _card['foto'].toString(),
                                                      fit: BoxFit.fill,
                                                      placeholder: (context, url) =>
                                                          Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 6.0,
                                                  right: (MediaQuery.of(context).size.width * 67) / 100,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(4.0)),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(1.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.visibility,
                                                            color: Colors.black,
                                                            size: 25.0.w,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.all(3.0.w),
                                                            child: Text(
                                                              _card['gorulmesayisi'].toString(),
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10.0.w), bottomRight: Radius.circular(10.0.w)),
                                              child: Container(
                                                color: Colors.white,
                                                height: MediaQuery.of(context).size.height * 0.4,
                                                width: MediaQuery.of(context).size.width,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 4.0.h,
                                                    ),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 5.0.w, top: 10.0.h),
                                                      child: Row(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(
                                                              "Başlangıç tarihi:     ",
                                                              style:  TextStyle(
                                                                color: const Color(0xff343633),
                                                                fontFamily: "OpenSans",
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15.3.h,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(
                                                             _saatDakikaGoster(_card['tarih'] ?? Timestamp(1, 1)),
                                                              style: TextStyle(
                                                                color: const Color(0xff343633),
                                                                fontFamily: "OpenSans",
                                                                fontSize: 15.3.h,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 15.0.w, top: 10.0.h),
                                                      child: Row(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Container(
                                                              width: 250.0.w,
                                                              child: Text(
                                                                _card['baslik'].toString(),
                                                                maxLines: 2,
                                                                overflow: TextOverflow.clip,
                                                                style:  TextStyle(
                                                                  color: const Color(0xff343633),
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: "OpenSans",
                                                                  fontSize: 18.3.h,
                                                                ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 15.0.w, right: 7.0.w, top: 10.0.h),
                                                      child: Text(_card['aciklama'].toString(),
                                                          maxLines: 2,
                                                          style:  TextStyle(
                                                              color: const Color(0xff343633),
                                                              fontWeight: FontWeight.w400,
                                                              fontFamily: "OpenSans",
                                                              fontStyle: FontStyle.normal,
                                                              fontSize: 14.0.h),
                                                          textAlign: TextAlign.left),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0.h,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: MyButton(
                                                        text: "Düzenle",
                                                        butonColor: Renkler.onayButonColor,
                                                        width: 220.0.w,
                                                        height: 35.0.h,
                                                        onPressed: () {
                                                          Navigator.of(context, rootNavigator: true).push(
                                                            MaterialPageRoute(
                                                                builder: (context) => AdminReklamDuzenle(
                                                                      card: _card,
                                                                    )),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:  EdgeInsets.all(8.0.w),
                                                      child: MyButton(
                                                          text: "Sil",
                                                          butonColor: Renkler.reddetButonColor,
                                                          width: 220.0.w,
                                                          height: 35.0.h,
                                                          onPressed: () {
                                                            var dialog = CustomAlertDialog(
                                                                message: "Bu reklamı silmek istediğinize emin misiniz?",
                                                                onPostivePressed: () {
                                                                  _adminIslemleri.adminReklamSil(_card);
                                                                  Navigator.pop(context);
                                                                },
                                                                onNegativePressed: () {},
                                                                positiveBtnText: 'Evet',
                                                                negativeBtnText: 'Hayır');
                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => dialog);
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        await launch(_card['link']);
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 30.0.w, right: 30.0.w, top: 20.0.h, bottom: 20.0.h),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(11.70.w),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color(0x29000000),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 22.70,
                                                  spreadRadius: 0)
                                            ],
                                            color: Theme.of(context).backgroundColor,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                    child: Container(
                                                      color: Colors.redAccent,
                                                      height: (MediaQuery.of(context).size.height * 25) / 100,
                                                      width: MediaQuery.of(context).size.width,
                                                      child: CachedNetworkImage(
                                                        imageUrl: _card['foto'].toString(),
                                                        fit: BoxFit.fill,
                                                        placeholder: (context, url) =>
                                                            Center(child: CircularProgressIndicator()),
                                                        errorWidget: (context, url, error) => Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 6.0,
                                                    right: (MediaQuery.of(context).size.width * 67) / 100,
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4.0.w)),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(1.0.w),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.visibility,
                                                              color: Colors.black,
                                                              size: 25.0.h,
                                                            ),
                                                            Padding(
                                                              padding:  EdgeInsets.all(3.0.w),
                                                              child: Text(
                                                                _card['gorulmesayisi'].toString(),
                                                                style: TextStyle(
                                                                  fontSize: 10.0.spByWidth,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0.w), bottomRight: Radius.circular(10.0.w)),
                                                child: Container(
                                                  color: Colors.white,
                                                  height: MediaQuery.of(context).size.height * 0.4,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 4.0.h,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 15.0.w, top: 10.0.h),
                                                        child: Row(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Container(
                                                                width:250.0.w,
                                                                child: Text(
                                                                  _card['baslik'].toString(),
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.clip,
                                                                  style:  TextStyle(
                                                                    color: const Color(0xff343633),
                                                                    fontWeight: FontWeight.bold,
                                                                    fontFamily: "OpenSans",
                                                                    fontSize: 18.3.spByWidth,

                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 15.0.w, right: 7.0.w, top: 10.0.h),
                                                        child: Text(_card['aciklama'].toString(),
                                                            maxLines: 5,
                                                            style: TextStyle(
                                                                color: const Color(0xff343633),
                                                                fontWeight: FontWeight.w400,
                                                                fontFamily: "OpenSans",
                                                                fontStyle: FontStyle.normal,
                                                                fontSize: 14.0.spByWidth),
                                                            textAlign: TextAlign.left),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:  EdgeInsets.all(8.0.w),
                                                        child: MyButton(
                                                          text: "Düzenle",
                                                          butonColor: Renkler.onayButonColor,
                                                          width: 220.0.w,
                                                          height: 35.0.h,
                                                          onPressed: () {
                                                            print(_card.data());
                                                            Navigator.of(context, rootNavigator: true).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) => AdminReklamDuzenle(
                                                                        card: _card,
                                                                      )),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:  EdgeInsets.all(8.0.w),
                                                        child: MyButton(
                                                            text: "Sil",
                                                            butonColor: Renkler.reddetButonColor,
                                                            width: 220.0.w,
                                                            height: 35.0.h,
                                                            onPressed: () {
                                                              var dialog = CustomAlertDialog(
                                                                  message:
                                                                      "Bu reklamı silmek istediğinize emin misiniz?",
                                                                  onPostivePressed: () {
                                                                    _adminIslemleri.adminReklamSil(_card);
                                                                    Navigator.pop(context);
                                                                  },
                                                                  onNegativePressed: () {},
                                                                  positiveBtnText: 'Evet',
                                                                  negativeBtnText: 'Hayır');
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) => dialog);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          );
                  },
                ),
              ),
              _elemanyukle == false
                  ? SizedBox(
                      height: 5.0.h,
                    )
                  : (gelen + 5) == getirilecek
                      ? Platform.isIOS
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                      : getirilecek > gelen
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(
                                  child: Text(
                                "Daha Fazla Reklam Yok",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                            )
                          : Platform.isIOS
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
              SizedBox(
                height: 50.0.h,
              ),
            ],
          ) :
          Center(child: Text("Buraya Erişiminiz Yoktur.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
  String _saatDakikaGoster(Timestamp date) {
    var _formatterTime = DateFormat.Hm('tr_TR');
    var _formatterDate = DateFormat.yMd('tr_TR');
    var _formatlanmisTarih="";
    String time= timeago.format(date.toDate()).toString();
    print(time);
    if( time.contains("hours") || time.contains("minute") || time.contains("moment")  ){
      _formatlanmisTarih = _formatterTime.format(date.toDate());
    }else{
      _formatlanmisTarih = _formatterDate.format(date.toDate());
    }



    return _formatlanmisTarih;
  }
}
