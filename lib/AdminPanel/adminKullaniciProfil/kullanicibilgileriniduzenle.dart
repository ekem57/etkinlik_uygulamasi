import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/login/meslekSec.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/models/validators.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../login/ilSec.dart';

class KullaniciProfilAyarlariDuzenle extends StatefulWidget {
  final Map<String, dynamic> card;
  KullaniciProfilAyarlariDuzenle({this.card});
  @override
  _KullaniciProfilAyarlariDuzenleState createState() => _KullaniciProfilAyarlariDuzenleState();
}

String secilen_meslek;
String secilen_il;

class _KullaniciProfilAyarlariDuzenleState extends State<KullaniciProfilAyarlariDuzenle> {
  File _image;
  final adController = TextEditingController();
  final temsilciController = TextEditingController();
  final hakkimizdaController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final tiktokController = TextEditingController();
  String meslek;
  String iliskiDurumu="";
  String dogumTarihi = "";
  String ogrenimDurumu="";
  String hesapTipi="";
  String avatar="";
  bool  mavitik=false;
  String il;
  DateTime selectedDate;
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  FirebaseStorage storage;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    print("user bilgiler:"+widget.card.toString());
    storage = FirebaseStorage.instance;
    adController.text = widget.card['ad'];
    temsilciController.text = widget.card['temsilciAdres'];
    avatar = widget.card['avatarImageUrl'];
    hakkimizdaController.text = widget.card['hakkimda'];
    facebookController.text = widget.card['facebook'];
    twitterController.text = widget.card['twitter'];
    instagramController.text = widget.card['instagram'];
    tiktokController.text = widget.card['tiktok'];
    meslek = widget.card['meslek'];
    secilen_meslek = widget.card['meslek'];
    iliskiDurumu = widget.card['iliskiDurumu'];
    selectedDate = widget.card['dogumTarihi'].toDate();
    ogrenimDurumu = widget.card['ogrenimdurumu'];
    hesapTipi = widget.card['hesaptipi'];
    mavitik = widget.card['mavitik'];
    il =  widget.card['sehir'];
    secilen_il = widget.card['sehir'];
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Profil Ayarlar",
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).backgroundColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
        child: isLoading
            ? Loading()
            : ListView(
          padding: EdgeInsets.only(top: 10.0.h),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: _image != null
                          ? CircleAvatar(
                        radius: 40.0.h,
                        backgroundColor: Color(0xfff7cb15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(_image.path),
                            width: 312.0.w,
                            height: 166.0.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )

                          :
                      CircleAvatar(
                        radius: 40.0.h,
                        backgroundColor: Color(0xfff7cb15),
                        child: CircleAvatar(
                          radius: 39.0.h,
                          backgroundImage:
                          NetworkImage(avatar.toString()),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Text(hesapTipi),
                  ],
                ),

                Container(
                  width: 150.0.w,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(selectedDate == null ? "Doğum Tarihi" : formatTheDate(selectedDate),
                            style: TextStyle(
                                color: const Color(0xd9343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.0.spByWidth),
                            textAlign: TextAlign.left),
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1940),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                    primaryColor: Theme.of(context).primaryColor,
                                    accentColor: Theme.of(context).accentColor,
                                    buttonTheme: ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary
                                    ),
                                    colorScheme: ColorScheme.light(primary:Theme.of(context).primaryColor)),
                                child: child,
                              );
                            },

                          ).then((date) {
                            setState(() {
                              selectedDate = date;
                            });
                          });
                        },
                        trailing: Icon(
                          Icons.date_range,
                          size: 20.0.h,
                          color: Color(0xff91c4f2),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom: 10.0.h),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: (){

                    },
                    child: Text("Mavi tik",style: TextStyle(color: Colors.black,fontSize: 17.3),)),
                SizedBox(width: 5,),
                Checkbox(
                  value: mavitik,
                  checkColor: Colors.black,
                  activeColor: Colors.grey,
                  onChanged: (newValue) {
                    setState(() {
                      mavitik = newValue;
                    });
                  },),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: adController,
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    textInputAction: TextInputAction.next,
                    validator: NameValidator.validate,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      labelText: "Ad Soyad",
                      labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 0,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 20.0.h,),
                  widget.card['temsilcimi'] ?   TextFormField(
                    controller: temsilciController,
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    textInputAction: TextInputAction.next,
                    validator: NameValidator.validate,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      labelText: "Temsilci Yeri",
                      labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 0,
                        ),
                      ),
                    ),
                  ) : Container(),


                  SizedBox(height: 20.0.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hesap Türü",
                        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                      ),
                      DropdownButton(

                          isExpanded: true,
                          hint: Text(hesapTipi),
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
                  SizedBox(height: 20.0.h,),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 16.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meslek",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        InkWell(
                          onTap: () {
                            final secilenmeslekdrop =  Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => MeslekSec(),
                                fullscreenDialog: true,),
                            );
                            setState(() {
                              secilenmeslekdrop.then((value) {
                                meslek=value;
                                secilen_meslek=meslek;
                                print("gelen meslek:"+meslek+"  secilen meslek:"+value);
                                setState(() {

                                });
                              });
                            });


                          },
                          child: DropdownButton(
                            items:[],
                            hint: Text(secilen_meslek,style: TextStyle(color: Colors.black),),
                            isExpanded: true,
                            iconSize: 25.0.h,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black, // Theme.of(context).primaryColor,
                            ),
                            underline: Container(height: 1.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: 10.0.h,),

                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 16.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "İl",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        InkWell(
                          onTap: () {
                            final secilenmeslekdrop =  Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => IlSec(),
                                fullscreenDialog: true,),
                            );
                            setState(() {
                              secilenmeslekdrop.then((value) {
                                il=value;
                                secilen_il=il;
                                print("gelen meslek:"+il+"  secilen meslek:"+value);
                                setState(() {

                                });
                              });
                            });


                          },
                          child: DropdownButton(
                            items:[],
                            hint: Text(secilen_il,style: TextStyle(color: Colors.black),),
                            isExpanded: true,
                            iconSize: 25.0.h,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black, // Theme.of(context).primaryColor,
                            ),
                            underline: Container(height: 1.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0.h,),
                  GestureDetector(
                    onTap: () {


                    },
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "İlişki Durumu",
                            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                          ),
                        ),
                        DropdownButtonFormField(
                          hint: Text(iliskiDurumu),
                          items: ["İlişkisi yok", "Nişanlı", "Medini birlikteliği var", "Birlikte yaşadığı biri var", "Serbest ilişkisi var", "Karmaşık bir ilişkisi var", "Eşinden ayrı", "Boşanmış", "Dul","Evli","Belirtmek İstemiyorum"].map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              iliskiDurumu = newValue;
                              setState(() {

                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),




                  SizedBox(height: 20.0.h,),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Öğrenim Durumu",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                      ),
                      SizedBox(height: 8,),
                      DropdownButtonFormField(


                        hint: Text(ogrenimDurumu),
                        items: ["İlk Öğretim", "Orta Öğretim", "Lise", "Ön Lisans", "Lisans", "Yüksek Lisans", "Doktora"].map((e) {
                          return DropdownMenuItem(value: e , child: Text(e));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            ogrenimDurumu = newValue;
                            setState(() {

                            });
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0.h,),
                  TextField(
                    controller: hakkimizdaController,
                    minLines: 2,
                    maxLines: 4,

                  ),

                  SizedBox(height: 20.0.h,),
                  TextFormField(
                    controller: facebookController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          padding: EdgeInsets.only(bottom: 6.0.h, left: 0.0),
                          child: Image.asset("assets/facebook_icon.png", width: 25.0.w, height: 25.0.w)),
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
                    height: 8.0.h,
                  ),
                  TextFormField(
                    controller: twitterController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
//              onSaved: (value) => _email = value,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          padding: EdgeInsets.only(bottom: 6.0.h, left: 0.0),
                          child: Image.asset("assets/twitter_icon.png", width: 25.0.w, height: 25.0.w)),
//                    prefix:Image.asset("assets/facebook_icon.png", width: 25.0.w, height: 25.0.w),
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
                    height: 8.0.h,
                  ),
                  TextFormField(
                    controller: instagramController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
//              onSaved: (value) => _email = value,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
//                    labelText: "Facebook Hesabı Ekle",
                      prefixIcon: Container(
                          padding: EdgeInsets.only(bottom: 6.0.h, left: 0.0),
                          child: Image.asset("assets/instagram_icon.png", width: 25.0.w, height: 25.0.w)),
//                    prefix:Image.asset("assets/facebook_icon.png", width: 25.0.w, height: 25.0.w),
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
                    height: 8.0.h,
                  ),
                  TextFormField(
                    controller: tiktokController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 15.0.spByWidth),
                    decoration: InputDecoration(
                      prefixIcon: Container(
                          padding: EdgeInsets.only(bottom: 6.0.h, left: 0.0),
                          child: Image.asset("assets/tiktok_icon.png", width: 25.0.w, height: 25.0.w)),
                      labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ],
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
                onPressed: () async {
                  updateProfil();
                },
                elevation: 8.3,
                child: Text(
                  "Kaydet",
                  style: TextStyle(
                      color: const Color(0xff343633),
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.7.spByWidth),
                ),
              ),
            ),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }

  _imgFromCamera() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(image.path);

    });
  }

  _imgFromGallery() async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image.path);

    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> uploadProfilImage() async {
    String filePath = _image.path;
    String userId = widget.card['userId'];
    String fileName = "$userId.jpg";
    File file = File(filePath);
    try {
      await storage.ref('usersAvatar/$fileName').putFile(file);
      String downloadURL = await storage.ref('usersAvatar/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  void updateProfil() async {

    var userID = widget.card['userId'];
    var downloadUrl = "";
    setState(() {
      isLoading = true;
    });
    if (_image != null ) {

        downloadUrl = await uploadProfilImage();
    }



    Map<String, dynamic> profil = Map();
    profil['avatarImageUrl'] = downloadUrl == "" ? widget.card['avatarImageUrl'] : downloadUrl;
    profil['facebook'] = facebookController.text;
    profil['twitter'] = twitterController.text;
    profil['instagram'] = instagramController.text;
    profil['dogumTarihi'] = selectedDate;
    profil['meslek'] = meslek;
    profil['ad'] = adController.text;
    profil['iliskiDurumu'] = iliskiDurumu;
    profil['ogrenimdurumu'] = ogrenimDurumu;
    profil['hakkimda'] = hakkimizdaController.text;
    profil['tiktok'] = tiktokController.text;
    profil['mavitik'] = mavitik;
    profil['sehir'] = il;
    profil['temsilciAdres'] = temsilciController.text;


    await this.usersCollection.doc(userID).update(profil).then((value) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Profil Güncellendi!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.purpleAccent,
      );
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Hata!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.purpleAccent,
      );
    });
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: DateTime.now().year - 50,
              maximumYear: DateTime.now().year + 50,
            ),
          );
        });
  }

  @override
  void dispose() {
    adController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    super.dispose();
  }
}
