import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/models/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SifremiUnuttum extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        brightness: Brightness.light, // status bar brightness
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 32.70),
          padding: EdgeInsets.symmetric(horizontal: 32.0.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_curve.png"),
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Text(
                "Şifrenizi mi Unuttunuz?",
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.italic,
                    fontSize: 25.0.spByWidth),
              ),
              Padding(
                padding: EdgeInsets.only(top: 17.0.h, bottom: 27.7.h),
                child: Image.asset(
                  "assets/balik.png",
                  width: 144.0.w,
                  height: 84.0.h,
                  fit: BoxFit.contain,
                ),
              ),
              Text("Lütfen Sistemde Kayıtlı E-Postanızı Girin!",
                  style: TextStyle(
                      color: const Color(0xff343633),
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.7.spByWidth),
                  textAlign: TextAlign.center),
              Padding(
                padding: EdgeInsets.only(top: 50.0.h),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: EmailValidator.validate,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => email = value,
                  style: TextStyle(fontSize: 15.0.spByWidth),
                  decoration: InputDecoration(
                    labelText: "E-Posta",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 15.0.spByWidth),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 292.3333333333333.w,
                height: 43.666666666666664.h,
                margin: EdgeInsets.only(top: 130.0.h),
                child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(65.7.w),
                  ),
                  onPressed: () async {
                    await _auth.sendPasswordResetEmail(
                      email: emailController.text,
                    );
                    Fluttertoast.showToast(
                      msg: "E-postanıza şifre sıfırlama linki gönderdik!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                    );
                  },
                  elevation: 8.3,
                  child: Text(
                    "Gönder",
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.7.spByWidth),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
