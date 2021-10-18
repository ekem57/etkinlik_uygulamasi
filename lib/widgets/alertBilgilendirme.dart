import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class AlertBilgilendirme extends StatefulWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  AlertBilgilendirme({
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
//    this.positiveButonColor = const Color(0xfff7cb15),
//    this.negativeButonColor = const Color(0xff91c4f2),
    this.positiveBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  _AlertBilgilendirmeState createState() => _AlertBilgilendirmeState();
}

class _AlertBilgilendirmeState extends State<AlertBilgilendirme> {
  final Color positiveButonColor = Renkler.onayButonColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: widget.title != null ? Text(widget.title) : null,
        content: widget.message != null
            ? Padding(
          padding:
           EdgeInsets.only(top: 30.0.h),
          child: Text(
            widget.message,
            style: TextStyle(
              fontSize: 15.0.spByWidth,
              fontWeight: FontWeight.w600,
              fontFamily: "OpenSans",
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
        )
            : null,
        backgroundColor: widget.bgColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.circularBorderRadius)),
        actions: <Widget>[

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 90.0.w,vertical: 20.0.h),
            child: Center(
              child: MyButton(
                  text: "Tamam",
                  onPressed: widget.onPostivePressed,
                  butonColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  fontSize: 12.3.spByWidth,
                  width: 120.0.w,
                  height: 29.0.h),
            ),
          ),


        ],
      ),
    );
  }
}
