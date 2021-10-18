import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:etkinlik_kafasi/extensions/size_config.dart';
import 'package:etkinlik_kafasi/login/kayit_bilgileri.dart';
import 'package:etkinlik_kafasi/login/sifremi_unuttum.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/models/validators.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email;
  bool beniHatirla = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
 bool _passwordVisible = false;
  FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    SizeConfig(context).init();
    return loading
        ? Loading()
        : Scaffold(
          backgroundColor: theme.backgroundColor,
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 32.70.h),

              child: SafeArea(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 34.0.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 150.0.h,
                            width: 200.0.w,
                            child: Image.asset("assets/logo.jpeg")),

                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.disabled,
                          validator: EmailValidator.validate,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) => _email = value,
                          style: TextStyle(fontSize: 15.0.spByWidth),
                          decoration: InputDecoration(
                            labelText: "E-Posta",
                            labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: !_passwordVisible,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.disabled,
                          validator: PasswordValidator.validate,
                          textInputAction: TextInputAction.go,
                          onSaved: (value) => _email = value,
                          onFieldSubmitted: (value) {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              authKontrol(_emailController.text, _passwordController.text);
                            }
                          },

                          style: TextStyle(fontSize: 15.0.spByWidth),
                          decoration: InputDecoration(
                            suffixIcon:  IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),

                            labelText: "Şifre",
                            labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.0.h),
                                  child: Text(
                                    "Şifremi Unuttum!",
                                    style: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.7.spByWidth),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (c) => SifremiUnuttum()));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.7.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 60.0.h),
                          child: Column(
                            children: [
                              Container(
                                width: 292.3333333333333.w,
                                height: 43.666666666666664.h,
                                child: RaisedButton(
                                  color: theme.buttonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(65.7.w),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      authKontrol(_emailController.text, _passwordController.text);
                                    }
                                  },
                                  elevation: 8.3,
                                  child: Text(
                                    "Giriş",
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.7.spByWidth),
                                  ),
                                ),
                              ),
                              Container(
                                width: 292.3333333333333.w,
                                height: 43.666666666666664.h,
                                margin: EdgeInsets.only(top: 25.0.h),
                                child: RaisedButton(
                                  color: theme.accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(65.7.w),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (context) => KayitBilgileri()));
                                  },
                                  elevation: 8.3,
                                  child: Text(
                                    "Kaydol",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> authKontrol(String email, String password) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    var errorMessage = "";
    try {
      Users _girisYapanUser = await _userModel.signInWithEmailandPassword(email, password);
      if (_girisYapanUser != null) {
        setState(() {
          loading = false;
        });
      }
    } on FirebaseAuthException catch (error) {
      print("messaj:"+error.toString());
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Geçersiz e-posta adresi! Lütfen e-posta adresinizi kontrol ediniz!";
          break;
        case "wrong-password":
          errorMessage = "Hatalı şifre! Lütfen şifrenizi kontrol ediniz";
          break;
        case "user-not-found":
          errorMessage = "Böyle bir kullanıcı bulunamadı!";
          break;
        case "user-disabled":
          errorMessage = "Hesabınız erişimizniz iptal edildi!";
          break;
        case "operation-not-allowed":
          errorMessage = "Çok fazla hatalı deneme yaptınız. Lütfen daha sonra tekrar deneyiniz!";
          break;
        case "email-already-in-use":
          errorMessage = "E-Posta adresi kullanımda!";
          break;
        default:
          errorMessage = error.toString();
      }
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.purpleAccent,
      );
    } catch (error) {
      errorMessage = error.toString();
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.purpleAccent,
      );
    }
  }
  //TODO Kulllanımda değil silinecek ?
//
//  Future<void> emailSifreKontrol(String email, String password) async {
//
//    var errorMessage = "";
//    try {
//      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async {
//        var userId = value.user.uid;
//        DocumentSnapshot gelenuser = await _firestore.collection("users").doc(userId).get();
//       // Provider.of<Users>(context, listen: false).fromMap(gelenuser.data());
//        Provider.of<Users>(context, listen: false).userId = userId;
//
//      //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => MainNavigation()), (route) => false);
//      });
//    } catch (error) {
//      print(error.toString());
//      switch (error) {
//        case "invalid-email":
//          errorMessage = "Geçersiz e-posta  adressi.";
//          break;
//        case "wrong-password":
//          errorMessage = "Hatalı şifre";
//          break;
//        case "user-not-found":
//          errorMessage = "Böyle bir kullanıcı bulunamadı";
//          break;
//        case "user-disabled":
//          errorMessage = "Hesabınız erişimizniz iptal edildi";
//          break;
//        case "operation-not-allowed":
//          errorMessage = "Çok fazla deneme yaptınız. Lütfen daha sonra tekrar deneyiniz";
//          break;
//        case "email-already-in-use":
//          errorMessage = "E-Posta adressi kullanımda";
//          break;
//        default:
//          errorMessage = error.toString();
//          print(error.toString());
//      }
//      setState(() {
//        loading = false;
//      });
//      Fluttertoast.showToast(
//        msg: errorMessage,
//        toastLength: Toast.LENGTH_LONG,
//        gravity: ToastGravity.CENTER,
//        textColor: Colors.white,
//        backgroundColor: Colors.purpleAccent,
//      );
//    }
//  }


  Future<bool> geriengel() {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
