import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/landingPage.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class TelefonGiris extends StatefulWidget {
  final Users userdoc;

  TelefonGiris({Key key, @required this.userdoc}) : super(key: key);

  @override
  _TelefonGirisState createState() => _TelefonGirisState();
}

class _TelefonGirisState extends State<TelefonGiris> {
  bool isValid = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isloading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  var controllertel = new MaskedTextController(mask: '### - ### - ## - ##');
  var controller = new MaskedTextController(mask: '000-000-00-00');

  TextEditingController _pinEditingController = TextEditingController();
  TextEditingController _pinEditing1 = TextEditingController();
  TextEditingController _pinEditing2 = TextEditingController();
  TextEditingController _pinEditing3 = TextEditingController();
  TextEditingController _pinEditing4 = TextEditingController();
  TextEditingController _pinEditing5 = TextEditingController();
  TextEditingController _pinEditing6 = TextEditingController();
  bool isCodeSent = false;
  String _verificationId;
  String _email;
  String _sifre;
  String _sifretekrar;
  String _nicktext;
  String _ad;
  String _soyad;
  bool _autoValidate = false;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  bool _validate = false;
  FocusNode _focusNode;
  String errortextad = "";
  String errortextsoyad = "";
  String errortextnickname = "";
  String errortextemail = "";
  String errortextsifre = "";

  PageController _controller = PageController(initialPage: 0);
  Timer _timer;
  int _zaman = 60;
  double genislik;
  double yukseklik;
  double kyuvarlak;

  FocusNode pin1FocusNode;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  String data = "";

  @override
  void initState() {
    super.initState();
    _firebaseAuth.setLanguageCode("tr");
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    pin1FocusNode.requestFocus();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
    setState(() {
      data = _pinEditing1.text +
          _pinEditing2.text +
          _pinEditing3.text +
          _pinEditing4.text +
          _pinEditing5.text +
          _pinEditing6.text;
    });
    print("veri:" + data);
  }

  double a;

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _isloading = !_isloading;
    });
  }

  @override
  Widget build(BuildContext context) {
    genislik = MediaQuery.of(context).size.width;
    yukseklik = MediaQuery.of(context).size.height;
    kyuvarlak = (genislik - 60) / 5;
    //Bu nedir ne işe yarıyor ? Variable isimlerini daha anlamı bir şekilde vermemiz lazım
    a = (MediaQuery.of(context).size.width) / 2.3;
    return WillPopScope(
      onWillPop: () async {
        await _controller.animateToPage(0, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
        _timer.cancel();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Platform.isIOS
                ? Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  )
                : Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
            color: Colors.black,
            onPressed: () {
              _controller.animateToPage(0, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
              if (_controller.page == 0) {
                if (_timer != null) {
                  _timer.cancel();
                }
                Navigator.pop(context);
              }
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: genislik,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: <Widget>[
                sayfa1(),
                sayfa2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sayfa1() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),
          child: Column(
            children: [
              Center(
                child: Text("Telefon Numaranız",
                    style: const TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 80.0.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey.withOpacity(0.8), offset: const Offset(4, 4), blurRadius: 8),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 53,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 20),
                        child: TextFormField(
                          controller: controller,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 25.0,
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 15),
                            border: InputBorder.none,
                            // contentPadding:  const EdgeInsets.only(top: 40,left: 30),
                            hintText: "5xx - xxx - xx - xx",
                            hintStyle: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0.h,
              ),
              Text("Telefonunuza 6 haneli onay kodu göndereceğiz",
                  style: TextStyle(
                    color: Color(0xff343633),
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 19.3.spByWidth,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 120.0.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 120.0.w),
                  child: Container(
                    width: 121.33333333333333.w,
                    height: 43.666666666666664.h,
                    child: RaisedButton(
                      color: Renkler.onayButonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(65.7.w),
                      ),
                      onPressed: () async {
                        print("gelen deger:" + controller.value.text.replaceAll('-', ''));
                        if (controller.value.text.replaceAll('-', '').length == 10) {
                          print(controller.value.text.replaceAll('-', ''));

                          _onVerifyCode(widget.userdoc.email, widget.userdoc.password);
                          print(widget.userdoc.toString());
                          _controller.animateToPage(1, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
                          setState(() {
                            _zaman = 60;
                            startTimer();
                          });
                        } else {
                          Fluttertoast.showToast(
                            msg: "Lütfen 10 Haneli Telefon Numaranızı Giriniz",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
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
        ),
      ],
    );
  }

  Widget sayfa2() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          margin: EdgeInsets.only(top: 12.70),
          child: _isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                          border: Border.all(style: BorderStyle.solid, width: 3, color: Colors.black87)),
                      child: Center(
                        child: Text(
                          _zaman.toString(),
                          style: TextStyle(fontSize: 17.0.spByWidth, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    Center(
                      child: Text("Onay Kodu",
                          style: const TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w700,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.italic,
                              fontSize: 25.0),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 20.0.w),
                    Text("6 haneli onay kodunu girin!",
                        style: const TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.3),
                        textAlign: TextAlign.center),
                    SizedBox(height: 70.0.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 56.0.w,
                          height: 56.0.w,
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
                            focusNode: pin1FocusNode,
                            controller: _pinEditing1,
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
                              if (_pinEditing1.text.length == 1) {
                                nextField(value, pin2FocusNode);
                              } else if (_pinEditing1.text.length >= 2) {
                                _pinEditing1.text = _pinEditing1.text[0];
                              } else {
                                pin1FocusNode.requestFocus();
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 56.0.w,
                          height: 56.0.w,
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
                            controller: _pinEditing2,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (_pinEditing2.text.length == 1) {
                                nextField(value, pin3FocusNode);
                              } else if (_pinEditing2.text.length >= 2) {
                                _pinEditing2.text = _pinEditing2.text[0];
                              } else {
                                pin1FocusNode.requestFocus();
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 56.0.w,
                          height: 56.0.w,
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
                            controller: _pinEditing3,
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
                              if (_pinEditing3.text.length == 1) {
                                nextField(value, pin4FocusNode);
                              } else if (_pinEditing3.text.length >= 2) {
                                _pinEditing3.text = _pinEditing3.text[0];
                              } else {
                                pin2FocusNode.requestFocus();
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 56.0.w,
                          height: 56.0.w,
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
                            controller: _pinEditing4,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (_pinEditing4.text.length == 1) {
                                nextField(value, pin5FocusNode);
                              } else if (_pinEditing4.text.length >= 2) {
                                _pinEditing4.text = _pinEditing4.text[0];
                              } else {
                                pin3FocusNode.requestFocus();
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 56.0.w,
                          height: 56.0.w,
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
                            controller: _pinEditing5,
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
                              if (_pinEditing5.text.length == 1) {
                                nextField(value, pin6FocusNode);
                              } else if (_pinEditing5.text.length >= 2) {
                                _pinEditing5.text = _pinEditing5.text[0];
                              } else {
                                pin4FocusNode.requestFocus();
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 56.0.w,
                          height: 56.0.w,
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
                            controller: _pinEditing6,
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
                              if (_pinEditing6.text.length == 1) {
                                nextField(value, pin6FocusNode);
                              } else if (_pinEditing6.text.length >= 2) {
                                _pinEditing6.text = _pinEditing6.text[0];
                              } else {
                                pin1FocusNode.requestFocus();
                                _pinEditing1.clear();
                                _pinEditing2.clear();
                                _pinEditing3.clear();
                                _pinEditing4.clear();
                                _pinEditing5.clear();
                                _pinEditing6.clear();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0.h),
                    _zaman != 0
                        ? TextButton(
                            onPressed: (){},
                            child: Text(
                            "Tekrar Gönder",
                            style: TextStyle(color: Colors.black12, decoration: TextDecoration.underline),
                          ))
                        : TextButton(
                            onPressed: () {
                              _onVerifyCode(_email, _sifre);
                              setState(() {
                                _zaman = 60;
                              });
                              startTimer();
                            },
                            child: Text("Tekrar Gönder",
                                style: TextStyle(
                                  color: const Color(0xffcc59d2),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.3,
                                  decoration: TextDecoration.underline,
                                ))),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 120.0.w),
                        child: Container(
                          width: 121.33333333333333.w,
                          height: 43.666666666666664.h,
                          child: RaisedButton(
                            color: Renkler.onayButonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(65.7.w),
                            ),
                            onPressed: () async {
                              if (data.length != 6) return;
                              _changeLoadingVisible();
                              await _onFormSubmitted(widget.userdoc.email, widget.userdoc.password);
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
        ),
      ],
    );
  }

  void _onVerifyCode(String email, String password) async {
    await _firebaseAuth
        .verifyPhoneNumber(
            phoneNumber: "+90${controller.value.text.replaceAll('-', '')}",
            timeout: const Duration(seconds: 60),
            verificationCompleted: (PhoneAuthCredential credential) {
              print("verificationCompleted call back triggered ");
              print("credential token: ${credential.token}");
              print("credential smsCode: ${credential.smsCode}");
              print("credential providerId: ${credential.providerId}");
              print("credential signInMethod: ${credential.signInMethod}");
            },
            verificationFailed: (FirebaseAuthException e) {
              print("verificationFailed call back triggered Exception Code: ${e.code} Exception Message: ${e.message}");
              showToast(e.message, Theme.of(context).primaryColor);
            },
            codeSent: (String verificationId, int resendToken) async {
              print("codeSent callback trigger verificationId: $verificationId resendToken: $resendToken");
              _verificationId = verificationId;
            },
            codeAutoRetrievalTimeout: (String verificationId) {})
        .catchError((onError) {
      print("verifyPhoneNumber catchError: $onError");
    });
  }

  Future<Users> gelen(User user) async {
    _timer.cancel();
    return _userFromFirebase(user);
  }

  Future<Users> _userFromFirebase(User user) async {
    if (user == null) {
      return null;
    } else {
      final _userModel = Provider.of<UserModel>(context, listen: false);
      await _userModel.createtel(widget.userdoc.email, widget.userdoc.password, widget.userdoc,
          "+90" + controller.value.text.replaceAll('-', ''), user.uid);
      Navigator.of(context).push(MaterialPageRoute(builder: (c) => LandingPage()));
    }
  }

  Future<Users> _onFormSubmitted(String email, String sifre) async {
    AuthCredential phoneCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: data);
    EmailAuthCredential credentialEmail;
    try {
      credentialEmail = EmailAuthProvider.credential(email: email, password: sifre);
    } catch (e) {
      print("gelen hata :" + e.toString());
    }
    _firebaseAuth.signInWithCredential(credentialEmail).catchError((e) {}).then((userCredential) async {
      if (userCredential != null) {
        _timer.cancel();
        try {
          await userCredential.user.linkWithCredential(phoneCredential).then((value) => gelen(value.user));
        } on FirebaseAuthException catch (error) {
          _changeLoadingVisible();
          print(error.code);
          if (error.code == "credentıal-already-ın-use") {
            Fluttertoast.showToast(
              msg: "Bu telefon numarası daha önce kullanılmış",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            );
          } else {
            Fluttertoast.showToast(
              msg: error.code,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            );
          }
          _controller.animateToPage(0, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
          return null;
        } catch (e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
          );
          _controller.animateToPage(0, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
          return null;
        } finally {
          debugPrint("Print finally");
        }

        // try{
        //   user.user.linkWithCredential(phoneCredential).catchError((e){
        //     print("gelen hata :"+e.toString());
        //     if(e.toString() == "[firebase_auth/credential-already-in-use] This credential is already associated with a different user account."){
        //
        //       Fluttertoast.showToast(
        //         msg: "Bu telefon numarası daha önce kullanılmış",
        //         toastLength: Toast.LENGTH_LONG,
        //         gravity: ToastGravity.BOTTOM,
        //         textColor: Colors.white,
        //         backgroundColor: Theme.of(context).primaryColor,
        //       );
        //       _controller.animateToPage(0, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
        //       startTimer();
        //       if (mounted) {
        //         _changeLoadingVisible();
        //       }
        //     }
        //   }).then((value) => (){
        //     debugPrint("linkWithCredential is done");
        //     gelen(user.user);
        //   }).onError((error, stackTrace)  {
        //     debugPrint(error.toString());
        //     print(stackTrace);
        //     return null;
        //   });
        // }
        // catch(e){
        //   print("gelen hata :"+e.toString());
        //  }

      } else {
        _changeLoadingVisible();
        Fluttertoast.showToast(
          msg: "Doğrulamada hata lütfen tekrar deneyiniz",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
        );
      }
    }).catchError((error) {
      _changeLoadingVisible();

      Fluttertoast.showToast(
        msg: "Girilen kod geçersiz.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      );
    });
  }

  _basitAlertDialog(context) {
    _changeLoadingVisible();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: EdgeInsets.only(bottom: 10.0.h),
            child: Text(
              "Malesef Süre Doldu",
              style: TextStyle(color: Colors.red, fontSize: 20.0.spByWidth),
              textAlign: TextAlign.center,
            ),
          ),

          titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
          // İçerik kısmı
          content: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Text(
              "60 saniye içerisinde işlem yapmadınız.Lütfen yeni kod isteyin.",
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(5),

          actions: <Widget>[
            TextButton(
                child: Text("Tamam"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _controller.animateToPage(0, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
                  startTimer();
                  if (mounted) {
                    _changeLoadingVisible();
                  }
                })
          ],
        );
      },
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_zaman == 1) {
            _basitAlertDialog(context);
            timer.cancel();
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

  void showToast(message, Color color) {
    print(message);

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
