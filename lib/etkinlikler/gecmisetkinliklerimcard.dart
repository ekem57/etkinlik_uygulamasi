import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'etkinlik_detay.dart';

class GecmisEtkinliklerimCard extends StatefulWidget {
  final EtkinlikModel etkinlikBilgileri;
  final DocumentSnapshot card;
  int kalanGun;
  int kalanSaat;
  int kalanDakika;
  int kalanSaniye;

  GecmisEtkinliklerimCard({
    Key key,
    @required this.etkinlikBilgileri,
    @required this.card,
    this.kalanGun,
    this.kalanSaat,
    this.kalanDakika,
    this.kalanSaniye,
  }) : super(key: key);

  @override
  _GecmisEtkinliklerimCardState createState() => _GecmisEtkinliklerimCardState();
}



class _GecmisEtkinliklerimCardState extends State<GecmisEtkinliklerimCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var tarih = widget.etkinlikBilgileri.tarih;
    var saat = widget.etkinlikBilgileri.saat;
    var hour = int.parse(saat.split(":")[0]);
    var min = int.parse(saat.split(":")[1]);
    TimeOfDay time = TimeOfDay(hour: hour, minute: min);

    var etkinlikTime = DateTime(tarih.year, tarih.month, tarih.day, time.hour, time.minute);
    widget.kalanGun = etkinlikTime.difference(DateTime.now()).inDays;
    widget.kalanSaat = etkinlikTime.difference(DateTime.now()).inHours.remainder(24);
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => EtkinlikDetay(etkinlikBilgileri: widget.etkinlikBilgileri,card: widget.card,),
          ),
        );
      },
      child: Container(
        width: 312.3.w,
        height: MediaQuery.of(context).size.height * 0.6,
        //313.0.h,
        margin: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(11.70.w),
          ),
          boxShadow: [
            BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Stack(children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.etkinlikBilgileri.etkinlikFoto),
                        alignment: Alignment.topCenter),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(11.70.w),
                      topLeft: Radius.circular(11.70.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 2),
                        blurRadius: 22.70,
                        spreadRadius: 0,
                      ),
                    ],
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.65,
                                child: Container(
                                  width: 62.666666666666664.w,
                                  height: 22.666666666666668.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(6.70)),
                                      color: Theme.of(context).backgroundColor),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                                    child: Icon(Icons.supervisor_account, size: 18.0.h),
                                  ),
                                  Text(widget.etkinlikBilgileri.katilimci.toString(),
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.7.spByWidth),
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ],
                            alignment: Alignment.centerLeft,
                          ),
                          top: 12.30.h,
                          left: 13.30.w),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: 0.4,
                          child: Container(
                              width: 256.0.w,
                              height: 71.0.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(6.70)),
                                  color: const Color(0xff000000))),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 256.0.w / 4,
                                child: Text("Gün",
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: 256.0.w / 4,
                                child: Text("Saat",
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 256.0.w / 8,
                                child: Text(NumberFormat("00").format(widget.kalanGun),
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: 256.0.w / 8,
                                child: Text(":",
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: 256.0.w / 8,
                                child: Text(NumberFormat("00").format(widget.kalanSaat),
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 9.30.w),
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 6.0.w,right: 60.0.w),
                                child: Text(widget.etkinlikBilgileri.baslik,
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.3.spByWidth),
                                    textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).buttonColor,
                                      size: 25.0.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.etkinlikBilgileri.konum.replaceAll(RegExp("\n"), " "),
                                        style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 13.3.spByWidth,
                                        ),
//                                    overflow: TextOverflow.ellipsis,

//                                      textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Icon(
                                        Icons.person,
                                        color: Theme.of(context).primaryColor,
                                        size: 25.0.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.0.w),
                                        child: Text(
                                          widget.etkinlikBilgileri.yayinlayanAdSoyad.toString().toUpperCase(),
                                          style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.3.spByWidth,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    Expanded(
                                      child: Row(
                                          children: []..addAll(widget.etkinlikBilgileri.kategori
                                              .map(
                                                (e) => Padding(
                                                padding: EdgeInsets.only(left: 3.0.w),
                                                child: Image.asset(
                                                  "assets/kafalar/"+convertAssetName(e),
                                                  width: 25.0,
                                                  height: 25.0,
                                                  fit: BoxFit.contain,
                                                )),
                                          )
                                              .cast<Widget>()
                                              .toList()
                                            ..addAll([
                                              Spacer(),

                                            ]))),
                                    )
                                  ],
                                ),
                              )
                            ])),
                  )),

            ],
          ),
          Align(
            alignment: Alignment(1, 0.2),
            child: Container(
              width: 70.66666666666667.w,
              height: 64.33333333333333.w,
              margin: EdgeInsets.only(right: 9.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11.70)),
                boxShadow: [
                  BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 12.70, spreadRadius: 0)
                ],
                color: Theme.of(context).buttonColor,
              ),
              child: Center(
                child: Text(
                    "${widget.etkinlikBilgileri.tarih.day.toString()}\n${formatTheDate(widget.etkinlikBilgileri.tarih, format: DateFormat("MMM", "tr_TR"))}",
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.3.spByWidth),
                    textAlign: TextAlign.center),
              ),
            ),
          ),

        ]),
      ),
    );
  }

  String convertAssetName(String kategoriName){
    var turkish = ['ı', 'ğ', 'İ', 'Ğ', 'ç', 'Ç', 'ş', 'Ş', 'ö', 'Ö', 'ü', 'Ü'];
    var english = ['i', 'g', 'I', 'G', 'c', 'C', 's', 'S', 'o', 'O', 'u', 'U'];

    for(var i=0; i<turkish.length; i++){
      kategoriName = kategoriName.toLowerCase().replaceAll(RegExp(turkish[i]),english[i]);
    }
    kategoriName = kategoriName.replaceAll(RegExp(" "), "_");
    kategoriName += ".png";
    return kategoriName;

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
