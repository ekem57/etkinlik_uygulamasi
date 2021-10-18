import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

import 'telefononayla.dart';


class TelefonKayit extends StatefulWidget {
  final Users userdoc;
  TelefonKayit({Key key, @required this.userdoc}) : super(key: key);
  @override
  _TelefonKayitState createState() => _TelefonKayitState();
}

class _TelefonKayitState extends State<TelefonKayit> {
  final TextEditingController _phoneNumberController = TextEditingController();
  var _phoneNumberController2 = new MaskTextInputFormatter(mask: '### - ### - ## - ##', filter: { "#": RegExp(r'[0-9]') });
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationId;
  bool isCodeSent = false;
  Timer _timer;
  int _zaman = 120;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: const Color(0xffcc59d2),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
            child: Text(
                "Telefon Numaranız",
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
          SizedBox(height: 80.0.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.0.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 53.0.h,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 0,left: 40.0.w),
                    child:  TextFormField(

                      controller: _phoneNumberController,
                      inputFormatters: [_phoneNumberController2],
                      autocorrect: false,
                      maxLengthEnforced: true,
                      style:  const TextStyle(
                        color:  const Color(0xff343633),
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans",
                      fontStyle:  FontStyle.normal,
                      fontSize: 25
                       ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(

                      errorStyle: TextStyle(fontSize: 15.0.spByWidth),
                      border: InputBorder.none,
                     // contentPadding:  const EdgeInsets.only(top: 40,left: 30),
                      hintText: "5xx - xxx - xx - xx",hintStyle: TextStyle(color: Colors.black87,),

                    ),

                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0.h,),
              Text(
                  "Telefonunuza 4 haneli onay kodu göndereceğiz",
              style: const TextStyle(
                  color:  const Color(0xff343633),
              fontWeight: FontWeight.w400,
              fontFamily: "OpenSans",
              fontStyle:  FontStyle.normal,
              fontSize: 18.3
              ),
              textAlign: TextAlign.center
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
                    print(_phoneNumberController2.getUnmaskedText());
                    if (_phoneNumberController2.getUnmaskedText().length==10) {

                      print(_phoneNumberController2.getUnmaskedText());

                      final validtelefon = await ceptelcheck("+9"+_phoneNumberController2.getUnmaskedText());

                      if(!validtelefon){
                        Fluttertoast.showToast(
                          msg: "Bu telefon numarası daha önce kullanılmıştır.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
                        );

                      }else{

                        startTimer();
                        _onVerifyCode(widget.userdoc.email,widget.userdoc.password);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => TelefonOnay(userdoc: Users(email: widget.userdoc.email,dogumTarihi: widget.userdoc.dogumTarihi,password: widget.userdoc.password,adsoyad: widget.userdoc.adsoyad,meslek: widget.userdoc.meslek,iliskiDurumu: widget.userdoc.iliskiDurumu,cinsiyet: widget.userdoc.cinsiyet,telefon:_phoneNumberController2.getUnmaskedText() ),verificationid: _verificationId,),
                          ),
                        );
                        setState(() {
                          _zaman=120;
                        });
                      }

                    } else {
                      Fluttertoast.showToast(
                        msg: "Lütfen 10 Haneli Telefon Numaranızı Giriniz",
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


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if(_zaman==1){
            _basitAlertDialog(context);
          }
          if (_zaman < 1) {
            timer.cancel();


          } else {
            _zaman = _zaman - 1;
          }
        },
      ),
    );
  }
  Future<bool> ceptelcheck(String tel) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('telefon', isEqualTo: tel)
        .get();
    return result.docs.isEmpty;
  }
  _basitAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text("Malesef Süre Doldu",style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,),
          ),

          titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
          // İçerik kısmı
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("120 saniye içerisinde işlem yapmadınız.Lütfen yeni kod isteyin.",textAlign: TextAlign.center,),
          ),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(5),

          actions: <Widget>[
            FlatButton(
                child: Text("Tamam"),

                onPressed:(){
                  Navigator.of(context).pop();
                  startTimer();
                }
            )
          ],
        );
      },
    );
  }
  void _onVerifyCode(String email,String sifre) async {
    print("onverify kod çalıştı");
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      print("onverifycode a gelmiştir");
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {

        _firebaseAuth.signInWithCredential(phoneAuthCredential).then((user){
          user.user.updateEmail(email).then((aaa){

            user.user.updatePassword(sifre).then((aaa){
              debugPrint("email ve sifre eklenmistir: $user");
            });

          });
        });
        if (value.user != null) {

          print(value.user.phoneNumber);

        } else {
          Fluttertoast.showToast(
            msg: "Telefon Onaylamada HATA Lütfen Tekrar Deneyiniz.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red,
            backgroundColor: Theme
                .of(context)
                .primaryColor,
          );
        }
      }).catchError((error) {
        Fluttertoast.showToast(
          msg: "Telefon Onaylamada HATA Lütfen Tekrar Deneyiniz.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Theme
              .of(context)
              .primaryColor,
        );
      });
    };
    final PhoneVerificationFailed verificationFailed =
        ( authException) {
          Fluttertoast.showToast(
            msg: "Telefon Onaylamada HATA Lütfen Tekrar Deneyiniz.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red,
            backgroundColor: Theme
                .of(context)
                .primaryColor,
          );
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+90${_phoneNumberController2.getUnmaskedText()}",
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
