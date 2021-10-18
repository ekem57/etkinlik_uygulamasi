import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
class SifreDegistir extends StatefulWidget {
  @override
  _SifreDegistirState createState() => _SifreDegistirState();
}

class _SifreDegistirState extends State<SifreDegistir> {
  final mevcutSifreController = TextEditingController();
  final yeniSifreController = TextEditingController();
  final yeniTekrarSifreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Şifre Değiştir",
            style: TextStyle(
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 20.0.spByWidth),
            textAlign: TextAlign.center),
//          backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.70), topRight: Radius.circular(20.70)),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(color: const Color(0x5c000000), offset: Offset(0, 0), blurRadius: 33.06, spreadRadius: 4.94)
          ],
        ),
        child: Column(children: [
          TextFormField(
            controller: mevcutSifreController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            obscureText: true,
            textInputAction: TextInputAction.next,
//              onSaved: (value) => _email = value,
            style: TextStyle(fontSize: 15.0.spByWidth),
            decoration: InputDecoration(
              labelText: "Mevcut Şifre",
              labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0.h),
            child: TextFormField(
              controller: yeniSifreController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              obscureText: true,
              textInputAction: TextInputAction.next,
//              onSaved: (value) => _email = value,
              style: TextStyle(fontSize: 15.0.spByWidth),
              decoration: InputDecoration(
                labelText: "Yeni Şifre",
                labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
          TextFormField(
            controller: yeniTekrarSifreController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            obscureText: true,
            textInputAction: TextInputAction.next,
//              onSaved: (value) => _email = value,
            style: TextStyle(fontSize: 15.0.spByWidth),
            decoration: InputDecoration(
              labelText: "Yeni Şifre Tekrar",
              labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0,
                ),
              ),
            ),
          ),
          Container(
            width: 292.3333333333333.w,
            height: 43.666666666666664.h,
            margin: EdgeInsets.only(top: 38.0.h),
            child: RaisedButton(
              color: Theme.of(context).buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(65.7.w),
              ),
              onPressed: () {},
              elevation: 8.3,
              child: Text(
                "Değiştir",
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.7.spByWidth),
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
