import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminAlertUyelik extends StatefulWidget {

  final String userid;


  AdminAlertUyelik({
   @required this.userid,
  });

  @override
  _AdminAlertUyelikState createState() => _AdminAlertUyelikState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _AdminAlertUyelikState extends State<AdminAlertUyelik> {
  final Color positiveButonColor = Renkler.onayButonColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Center(child: Text("Üyelik Tipi Ne Olsun?")),


        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        actions: <Widget>[

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.0.w,vertical: 20.0.h),
            child: Center(
              child: MyButton(
                  text: "Gold",
                  onPressed: (){
                    _firestoreDBService.adminPaketDegistir(widget.userid,"gold");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Üye Paketi Gold Yapıldı.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.purpleAccent,
                    );
                  },
                  butonColor: positiveButonColor,
                  textColor: Colors.black,
                  fontSize: 15.0.spByWidth,
                  width: 180.0.w,
                  height: 40.0.h),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.0.w,vertical: 20.0.h),
            child: Center(
              child: MyButton(
                  text: "Plus",
                  onPressed: (){
                    _firestoreDBService.adminPaketDegistir(widget.userid,"plus");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Üye Paketi Plus Yapıldı.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.purpleAccent,
                    );
                  },
                  butonColor: positiveButonColor,
                  textColor: Colors.black,
                  fontSize: 15.0.spByWidth,
                  width: 180.0.w,
                  height: 40.0.h),
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.0.w,vertical: 20.0.h),
            child: Center(
              child: MyButton(
                  text: "Standart",
                  onPressed: (){
                    _firestoreDBService.adminPaketDegistir(widget.userid,"standart");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Üye Paketi Standart Yapıldı.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.purpleAccent,
                    );
                  },
                  butonColor: positiveButonColor,
                  textColor: Colors.black,
                  fontSize: 15.0.spByWidth,
                  width: 180.0.w,
                  height: 40.0.h),
            ),
          ),

        ],
      ),
    );
  }
}
