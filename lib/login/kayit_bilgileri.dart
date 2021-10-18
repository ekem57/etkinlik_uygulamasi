import 'package:etkinlik_kafasi/data/cities.dart';
import 'package:etkinlik_kafasi/data/professions.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/login/cinsiyet_sec.dart';
import 'package:etkinlik_kafasi/login/meslekSec.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/models/validators.dart';
import 'package:etkinlik_kafasi/widgets/form_textfield.dart';
import 'package:etkinlik_kafasi/widgets/kullanicisozlesmesi.dart';
import 'package:etkinlik_kafasi/widgets/right_arrow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'ilSec.dart';

class KayitBilgileri extends StatefulWidget {
  @override
  _KayitBilgileriState createState() => _KayitBilgileriState();
}

class _KayitBilgileriState extends State<KayitBilgileri> {
  final TextEditingController adController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String meslek = "Meslek Seçiniz";
  String il = "İl Seçiniz";
  String iliskiDurumu = "İlişkisi yok";
  String ogrenimDurumu = "İlk Öğretim";
  String hesapTipi = "Bireysel";
  bool checkedValue = false;
  DateTime _dateTime;
  final f = new DateFormat('yyyy-MM-dd');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 17.0.w,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: theme.backgroundColor,
          elevation: 0.0,
          brightness: Brightness.light, // status bar brightness
        ),
        body: ListView(
          children:[ Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 33.0.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 16.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hesap Türü",
                            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                          ),
                          DropdownButton(
                              value: hesapTipi,
                              isExpanded: true,
                              hint: Text("Seçiniz"),
                              iconSize: 25.0.h,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black, // Theme.of(context).primaryColor,
                              ),
                              underline: Container(height: 1.0, color: Colors.grey),
                              items: ["Bireysel", "Kurumsal"].map((e) {
                                return DropdownMenuItem(value: e, child: Text(e));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  hesapTipi = newValue;
                                });
                              }),
                        ],
                      ),
                    ),
                    FormTextFieldWidget(
                      controller: adController,
                      validator: NameValidator.validate,
                      label: "Ad Soyad",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                    ),
                    FormTextFieldWidget(
                      controller: emailController,
                      validator: EmailValidator.validate,
                      label: "E-Posta",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                    ),
                    FormTextFieldWidget(
                      controller: passwordController,
                      validator: PasswordValidator.validate,
                      label: "Şifre",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    InkWell(
                      onTap: () {
                        showCupertinoDatePicker(context);
                      },
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child:  Text(
                         "Doğum Tarihi" ,
                        //_dateTime,
                        style: TextStyle(
                            color: const Color(0xd9343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                          ),
                          SizedBox(height: 8.0.h,),
                          DropdownButtonFormField(
                            items: [],
                            hint: Text( _dateTime == null ? "Doğum Tarihi Seçiniz" : formatTheDate(_dateTime, format: DateFormat("dd.MM.y")),),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.solid,color: Renkler.reddetButonColor,width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(width: 2,color: Colors.black),
                              ),
                              enabledBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: _dateTime != null ? BorderSide(width: 2,color: Colors.black) :  BorderSide(width: 2,color: Colors.purple),
                              ),

                              focusColor: Renkler.reddetButonColor,
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 12.0.spByWidth, color: Colors.red),

                            ),
                            icon: Icon(
                              Icons.date_range,
                              size: 20.0.h,
                              color: Color(0xff91c4f2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    InkWell(
                      onTap: () {
                        var result = showSearch<String>(
                            context: context, delegate: CitySearch(cities));
                        result.then((value) => setState(()=>il=value ?? "İl Seçiniz"));
                      },
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "İl",
                              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Container(
                            height: 50.0.h,
                            padding:  EdgeInsets.only(left:8.0.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border:  il != "İl Seçiniz" ? Border.all(width: 2,color: Colors.black) : Border.all(width: 2,color: Colors.purple) ,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(il,style: TextStyle(color: Colors.black,fontSize: 15.0.spByWidth),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        var result = showSearch<String>(
                            context: context, delegate: ProfessionsSearch(professions));
                        result.then((value) => setState(()=>meslek = value?? "Meslek Seçiniz"));
                      },
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Meslek",
                              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 500.0.w,
                            height: 65,
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: meslek != "Meslek Seçiniz"
                                  ? Border.all(width: 2, color: Colors.black)
                                  : Border.all(width: 2, color: Colors.purple),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.0.h, left: 8),
                              child: Text(
                                meslek,
                                style: TextStyle(color: Colors.black, fontSize: 15.0.spByWidth),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 12.0.h,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Öğrenim Durumu",
                            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DropdownButtonFormField(
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(style: BorderStyle.solid, color: Renkler.reddetButonColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(width: 2, color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: ogrenimDurumu != "İlk Öğretim"
                                  ? BorderSide(width: 2, color: Colors.black)
                                  : BorderSide(width: 2, color: Colors.purple),
                            ),
                            focusColor: Renkler.reddetButonColor,
                            errorStyle: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 12.0.spByWidth, color: Colors.red),
                          ),
                          value: ogrenimDurumu,
                          items: [
                            "İlk Öğretim",
                            "Orta Öğretim",
                            "Lise",
                            "Ön Lisans",
                            "Lisans",
                            "Yüksek Lisans",
                            "Doktora"
                          ].map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              ogrenimDurumu = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0.h,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "İlişki Durumu",
                            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DropdownButtonFormField(
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide:
                              BorderSide(style: BorderStyle.solid, color: Renkler.reddetButonColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(width: 2, color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: iliskiDurumu != "İlişkisi yok"
                                  ? BorderSide(width: 2, color: Colors.black)
                                  : BorderSide(width: 2, color: Colors.purple),
                            ),
                            focusColor: Renkler.reddetButonColor,
                            errorStyle: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 12.0.spByWidth, color: Colors.red),
                          ),
                          value: iliskiDurumu,
                          items: [
                            "İlişkisi yok",
                            "Nişanlı",
                            "Medini birlikteliği var",
                            "Birlikte yaşadığı biri var",
                            "Serbest ilişkisi var",
                            "Karmaşık bir ilişkisi var",
                            "Eşinden ayrı",
                            "Boşanmış",
                            "Dul",
                            "Evli",
                            "Belirtmek İstemiyorum"
                          ].map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              iliskiDurumu = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0.h,
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => KullaniciSozlesmesi()));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  "Kullanıcı sözleşmesi ve gizlilik sözleşmesini okudum onayladım",
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 13.7.spByWidth),
                                ))),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        Checkbox(
                          value: checkedValue,
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0.h),
                      child: ArrowRight(
                        onPressed: () async {
                          bool emailkontrol = await emailchecked();

                          if (_formKey.currentState.validate()) {
                            if (!checkedValue) {
                              Fluttertoast.showToast(
                                msg: "Lütfen kullanıcı sözleşmesini imzalayınız!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.black,
                                backgroundColor: Colors.white,
                              );
                            } else {
                              if (!emailkontrol) {
                                Fluttertoast.showToast(
                                  msg: "Bu email daha önce kullanılmış!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                );
                              } else {
                                Users(
                                    userId: "",
                                    adsoyad: adController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    meslek: meslek,
                                    sehir: il,
                                    iliskiDurumu: iliskiDurumu,
                                    dogumTarihi: _dateTime);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (c) => CinsiyetSec(
                                        userdoc: Users(
                                      userId: "",
                                      adsoyad: adController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      meslek: meslek,
                                      sehir: il,
                                      iliskiDurumu: iliskiDurumu,
                                      dogumTarihi: _dateTime,
                                      ogrenimDurumu: ogrenimDurumu,
                                      hesapTipi: hesapTipi,
                                    )),
                                  ),
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
  ]),
      ),
    );
  }

  Future<dynamic> showCupertinoDatePicker(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                onDateTimeChanged: (DateTime newdate) {
                  setState(() {
                    _dateTime = newdate;
                  });
                },
                maximumYear: DateTime.now().year,
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
              ));
        });
  }

  @override
  void dispose() {
    adController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> emailchecked() async {
    bool veri = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

    } on FirebaseAuthException catch (e) {
      veri = false;
      print("gelen error:  " + e.message);
      if (e.message == "The email address is already in use by another account.") {}
    }


    return veri;
  }
}
