import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

import 'turnuva/katilim_istekleri.dart';

class AktifEtkinlikCard extends StatefulWidget {
  final EtkinlikModel etkinlikModel;

  const AktifEtkinlikCard({Key key, @required this.etkinlikModel})
      : super(key: key);

  @override
  _AktifEtkinlikCardState createState() => _AktifEtkinlikCardState();
}

class _AktifEtkinlikCardState extends State<AktifEtkinlikCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.3.w,
      height: MediaQuery.of(context).size.height * 0.6,
      margin: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.0.h),
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
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          widget.etkinlikModel.etkinlikFoto.toString()),
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
                        spreadRadius: 0)
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.70)),
                                    color: Theme.of(context).backgroundColor),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.0.w),
                                  child: Icon(Icons.supervisor_account,
                                      size: 18.0.h),
                                ),
                                Text(
                                    widget.etkinlikModel.katilimciSayisi
                                        .toString(),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.70)),
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
                            Container(
                              width: 256.0.w / 4,
                              child: Text("Dakika",
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
                              child: Text("Saniye",
                                  style: TextStyle(
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0.spByWidth),
                                  textAlign: TextAlign.center),
                            )
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
                              child: Text("15",
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
                              child: Text(
                                  widget.etkinlikModel.tarih.hour.toString(),
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
                              child: Text(
                                  widget.etkinlikModel.tarih.minute.toString(),
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
                              child: Text(
                                  widget.etkinlikModel.tarih.second.toString(),
                                  style: TextStyle(
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18.0.spByWidth),
                                  textAlign: TextAlign.center),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 9.30.w),
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6.0.w),
                        child: Text(widget.etkinlikModel.baslik.toString(),
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w800,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 18.3.spByWidth),
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).buttonColor,
                              size: 25.0.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.0.w),
                              child: Text(
                                widget.etkinlikModel.konum,
                                style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.3.spByWidth,
                                ),
//                                      textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                          size: 25.0.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.0.w),
                          child: Text(
                            widget.etkinlikModel.yayinlayanAdSoyad,
                            style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w400,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.spByWidth,
                            ),
//                                      textAlign: TextAlign.start,
                          ),
                        ),
                      ]),
                    ])),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KatilimIstekleri(

                            )));
                  },
                  child: Text("2 Katılım İsteği",
                      style: TextStyle(
                        color: const Color(0xffcc59d2),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: Color(0xff91c4f2),
                      size: 18.0.h,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Align(
          alignment: Alignment(1, 0.0),
          child: Container(
            width: 70.66666666666667.w,
            height: 64.33333333333333.w,
            margin: EdgeInsets.only(right: 9.0.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11.70)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 2),
                    blurRadius: 12.70,
                    spreadRadius: 0)
              ],
              color: Theme.of(context).buttonColor,
            ),
            child: Center(
              child: Text(
                  widget.etkinlikModel.tarih.day.toString() +
                      "\n" +
                      widget.etkinlikModel.tarih.month.toString(),
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
    );
  }
}
