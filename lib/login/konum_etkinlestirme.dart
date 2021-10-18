import 'package:etkinlik_kafasi/landingPage.dart';
import 'package:etkinlik_kafasi/login/kayit_bilgileri.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:geolocator/geolocator.dart';

class KonumEtkinlestirme extends StatefulWidget {
  @override
  _KonumEtkinlestirmeState createState() => _KonumEtkinlestirmeState();
}

class _KonumEtkinlestirmeState extends State<KonumEtkinlestirme> {
  final Geolocator geolocator = Geolocator();
  Position _currentPosition;

  String _currentAddress;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
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
          backgroundColor: theme.backgroundColor,
          elevation: 0.0,
          brightness: Brightness.light, // status bar brightness
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
//            margin: EdgeInsets.only(top: 32.70),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_curve.png"),
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/konum.png",
                width: 109.30.w,
                height: 131.30.h,
                fit: BoxFit.contain,
              ),
              Padding(
                padding:  EdgeInsets.only(top: 30.0.h),
                child: Text("Yakınınızdaki etkinlikleri öğrenin",
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 19.0.spByWidth),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding:  EdgeInsets.all(13.0.w),
                child: Text(
                    """Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua""",
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0.spByWidth),
                    textAlign: TextAlign.center),
              ),
              Container(
                width: 292.3333333333333.w,
                height: 43.666666666666664.h,
                margin: EdgeInsets.only(top: 125.0.h, bottom: 15.0.h),
                child: RaisedButton(
                  color: theme.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(65.7.w),
                  ),
                  onPressed: () {
                    print("object");

                  },
                  elevation: 8.3,
                  child: Text(
                    "Konumu Etkinleştir",
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.7.spByWidth),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {

                  Navigator.of(context).push(MaterialPageRoute(builder: (c) => LandingPage()));
                },
                child: Text(
                  "Şimdi Değil",
                  style: TextStyle(
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.7.spByWidth),
                ),
              )
            ],
          ),
        ));
  }



}
