import 'dart:async';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class TelefonOnay extends StatefulWidget {
  final Users userdoc;
  String verificationid;
  TelefonOnay({Key key, @required this.userdoc,this.verificationid}) : super(key: key);
  @override
  _TelefonOnayState createState() => _TelefonOnayState();
}
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
class _TelefonOnayState extends State<TelefonOnay> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;


  String data="";
  Timer _timer;
  int _zaman = 120;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {

    if (value.length == 1) {
      focusNode.requestFocus();
    }
    setState(() {
      data+=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Text(
                "Onay Kodu",
                style: const TextStyle(
                    color:  const Color(0xff343633),
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    fontStyle:  FontStyle.italic,
                    fontSize: 25.0
                ),
                textAlign: TextAlign.center
            ),
          ),
          SizedBox(height: 40),
          Text(
              "4 haneli onay kodunu girin!",
              style: const TextStyle(
                  color:  const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle:  FontStyle.normal,
                  fontSize: 18.3
              ),
              textAlign: TextAlign.center
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 56.0.w,
                height: 56.0.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextFormField(
                  autofocus: true,
                  style: TextStyle(fontSize: 24.0.spByWidth),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  ),
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextFormField(
                  autofocus: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  focusNode: pin2FocusNode,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                  ),
                    onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextFormField(
                  autofocus: true,
                  focusNode: pin3FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                  ),
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              Container(
                width: 56.0.w,
                height: 56.0.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextFormField(
                  autofocus: true,
                  focusNode: pin4FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                  ),
                  onChanged: (value) => nextField(value, pin5FocusNode),
                ),
              ),


              Container(
                width: 56.0.w,
                height: 56.0.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextFormField(
                  autofocus: true,
                  focusNode: pin5FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                  ),
                  onChanged: (value) => nextField(value, pin6FocusNode),
                ),
              ),






              Container(
                width: 56.0.w,
                height: 56.0.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextFormField(
                  autofocus: true,
                  focusNode: pin6FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                     nextField(value, pin6FocusNode);
                      pin6FocusNode.unfocus();
                    }
                  },
                ),
              ),

            ],
          ),
          SizedBox(height: 120.0.h,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0.h,horizontal: 120.0.w),
              child: Container(
                width: 121.33333333333333.w,
                height: 43.666666666666664.h,
                child: RaisedButton(
                  color: Renkler.onayButonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(65.7.w),
                  ),
                  onPressed: () async {
                    print("GELEN VERİ:"+data);
                    if (data.length == 6) {
                      _onFormSubmitted(widget.userdoc.email,widget.userdoc.password);


                    } else {
                      Fluttertoast.showToast(
                        msg: "Telefon Onaylamada HATA Lütfen Tekrar Deneyiniz.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                      );
                    }
                  },
                  elevation: 8.3,
                  child: Image.asset(
                    "assets/arrow_right.png",
                    width: 40.3.w,
                    height: 21.0.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<Users> _onFormSubmitted(String email,String sifre) async {

    AuthCredential _authCredential = PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: data);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((user) {

      if (user != null) {
        print("on form submit aut credatial "+_authCredential.toString());
        user.user.updateEmail(email).then((aaa){

          user.user.updatePassword(sifre).then((aaa){
            debugPrint("email ve sifre eklenmistir: $user");

          });

          return gelen(user.user);

        });


      } else {
        Fluttertoast.showToast(
          msg: "Doğrulamada hata lütfen tekrar deneyiniz",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Theme
              .of(context)
              .primaryColor,
        );

      }
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Girilen kod geçersiz.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      );

    });


  }


  @override
  Future<Users> gelen(User user) async {
    _timer.cancel();
    return _userFromFirebase(user);
  }

  Users _userFromFirebase(User user) {

    if (user == null) {
      print("user from firebase null");
      return null;
    } else {

      final _userModel = Provider.of<UserModel>(context);
    //  _userModel.createtel(user.email,widget.userdoc.password,widget.userdoc,);


    }
  }




}
