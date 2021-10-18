import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../extensions/color_data.dart';
import '../login/ilSec.dart';
import '../login/ilSec.dart';

class ProfilAyarlari extends StatefulWidget {
  @override
  _ProfilAyarlariState createState() => _ProfilAyarlariState();
}

 String secilen_meslek;
 String secilen_il;

class _ProfilAyarlariState extends State<ProfilAyarlari> {
  PickedFile _image;
  final adController = TextEditingController();
  final hakkimizdaController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final tiktokController = TextEditingController();
  String meslek;
  String il;
  String iliskiDurumu;
  String dogumTarihi = "";
  String ogrenimDurumu="";
  DateTime selectedDate;
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  FirebaseStorage storage;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  final String facebookUrl = "https://www.facebook.com/";
  final String twitterUrl = "https://www.twitter.com/";
  final String instagramUrl = "https://www.instagram.com/";
  final String tiktokUrl = "https://www.tiktok.com/";

  @override
  void initState() {
    super.initState();
    storage = FirebaseStorage.instance;
    final _userModel = Provider.of<UserModel>(context,listen: false);
    adController.text = _userModel.user.adsoyad;
    hakkimizdaController.text = _userModel.user.hakkimda;
    facebookController.text = facebookUrl + _userModel.user.facebook;
    twitterController.text = twitterUrl+ _userModel.user.twitter;
    instagramController.text = instagramUrl+_userModel.user.instagram;
    tiktokController.text = tiktokUrl+_userModel.user.tiktok;
    meslek = _userModel.user.meslek;
    il = _userModel.user.sehir;
    secilen_meslek = _userModel.user.meslek;
    secilen_il = _userModel.user.sehir;
    iliskiDurumu = _userModel.user.iliskiDurumu;
    selectedDate =_userModel.user.dogumTarihi;
    ogrenimDurumu =_userModel.user.ogrenimDurumu;

  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

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
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.70.w), topRight: Radius.circular(20.70.w)),
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
                                radius: 40.0.w,
                                backgroundColor: Color(0xfff7cb15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0.w),
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
                                  NetworkImage(_userModel.user.avatarImageUrl.toString()),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0.h,),
                            Text(_userModel.user.hesapTipi),
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

                                        setState(() {

                                        });
                                      });
                                    });


                                  },
                                  child: DropdownButton(
                                    items:[],
                                    hint: Text(secilen_meslek,style: TextStyle(color: Colors.black,fontSize: 14.0.h),),
                                    isExpanded: true,
                                    iconSize: 25.0.w,
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
                                    hint: Text(secilen_il,style: TextStyle(color: Colors.black,fontSize: 14.0.h),),
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
                                  hint: Text(iliskiDurumu,style: TextStyle(fontSize: 14.0.h),),
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


                                hint: Text(ogrenimDurumu,style: TextStyle(fontSize: 14.0.h),),
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

                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Hakkımda",
                                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                                ),
                              ),
                              SizedBox(height: 8,),
                              TextField(
                                controller: hakkimizdaController,
                                minLines: 2,
                                maxLines: 4,

                              ),
                            ],
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
                            style: TextStyle(fontSize: 15.0.spByWidth),
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                  padding: EdgeInsets.only(bottom: 6.0.h, left: 0.0),
                                  child: Image.asset("assets/twitter_icon.png", width: 25.0.w, height: 25.0.w)),
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
                            style: TextStyle(fontSize: 15.0.spByWidth),
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                  padding: EdgeInsets.only(bottom: 6.0.h, left: 0.0),
                                  child: Image.asset("assets/instagram_icon.png", width: 25.0.w, height: 25.0.w)),
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
                    SizedBox(height: 60.0.h,),
                  ],
                ),
        ),
      );
  }

  _imgFromCamera() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
      Provider.of<Users>(context, listen: false).photoFilePath = image.path;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      _image = image;
      print(_image.path);
    });
    Provider.of<Users>(context, listen: false).photoFilePath = image.path;
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
    String userId = FirebaseAuth.instance.currentUser.uid;
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
    final _userModel = Provider.of<UserModel>(context,listen: false);
    var userID = FirebaseAuth.instance.currentUser.uid;
    var downloadUrl = "";
    setState(() {
      isLoading = true;
    });
    if (_image != null ) {

      downloadUrl = await uploadProfilImage();
    }
    _userModel.user.avatarImageUrl = downloadUrl == "" ? _userModel.user.avatarImageUrl : downloadUrl;
    _userModel.user.facebook = facebookController.text;
    _userModel.user.twitter = twitterController.text;
    _userModel.user.instagram = instagramController.text;
    _userModel.user.dogumTarihi = selectedDate;
    _userModel.user.meslek = meslek;
    _userModel.user.sehir = il;
    _userModel.user.adsoyad = adController.text;
    _userModel.user.iliskiDurumu = iliskiDurumu;
    _userModel.user.ogrenimDurumu=ogrenimDurumu;
    _userModel.user.hakkimda=hakkimizdaController.text;
    _userModel.user.tiktok=tiktokController.text;


    print("dowloadnd url:"+downloadUrl);
    Map<String, dynamic> profil = Map();
    profil['avatarImageUrl'] = downloadUrl == "" ? _userModel.user.avatarImageUrl : downloadUrl;
    profil['facebook'] = facebookController.text == "" ? "https://"+facebookController.text : facebookController.text ;
    profil['twitter'] = twitterController.text == "" ? "https://"+twitterController.text : twitterController.text ;
    profil['instagram'] = instagramController.text == "" ? "https://"+instagramController.text : instagramController.text ;
    profil['meslek'] = meslek;
    profil['ad'] = adController.text;
    profil['iliskiDurumu'] = iliskiDurumu;
    profil['ogrenimdurumu'] = ogrenimDurumu;
    profil['hakkimda'] = hakkimizdaController.text;
    profil['tiktok'] = tiktokController.text == "" ? "https://"+tiktokController.text : tiktokController.text ;
    profil['sehir'] = il;



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
