import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/etkinlikler/turnuva/katilimciYorumlari.dart';
import 'package:etkinlik_kafasi/etkinlikler/turnuva/katilimciYorumlariTurnuva.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class GecmisEtkinlikCard extends StatefulWidget {
  final DocumentSnapshot card;

  const GecmisEtkinlikCard({Key key, this.card}) : super(key: key);

  @override
  _GecmisEtkinlikCardState createState() => _GecmisEtkinlikCardState();
}


class _GecmisEtkinlikCardState extends State<GecmisEtkinlikCard> {



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.3.w,
      height: MediaQuery.of(context).size.height * 0.55,
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
                      image: NetworkImage(widget.card['etkinlikFoto'].toString(),),
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

                                    widget.card['katilimci'].toString(),
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
                        child: Text( widget.card['baslik'].toString(),
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w800,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 18.3.spByWidth),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0.h),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(

                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).buttonColor,
                                  size: 25.0.h,
                                ),

                                Flexible(
                                  child: Text(
                                    widget.card['konum'].toString(),
                                    style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.3.h,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),

                              ],
                            ),
                          ),
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
                            widget.card['yayinlayanAdSoyad'].toString(),

                            style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w400,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.3.h,
                            ),
//                                      textAlign: TextAlign.start,
                          ),
                        ),
                      ]),
                    ])),
              ),
            ),
            Container(
              width: 221.0.w,
              height: 35.0.h,
              child: RaisedButton(
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(65.7.w),
                ),
                onPressed: () {
                widget.card['etkinlikTipi'] != "Turnuva"  ? Navigator.of(context).push(MaterialPageRoute(builder: (c) => KatilimciYorumlari(card: widget.card,)))
                    : Navigator.of(context).push(MaterialPageRoute(builder: (c) => KatilimciYorumlariTurnuva(card: widget.card,)));
                },
                elevation: 8.3,
                child: Text(
                  "Katılımcı Oyla",
                  style: TextStyle(
                      color: const Color(0xff343633),
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 13.30.spByWidth),
                ),
              ),
            ),
            SizedBox(
              height: 16.0.h,
            )
          ],
        ),
      ]),
    );
  }
}
