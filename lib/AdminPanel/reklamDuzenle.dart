import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/loading.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../login/ilSec.dart';



class AdminReklamDuzenle extends StatefulWidget {

  final DocumentSnapshot card;
  AdminReklamDuzenle({this.card});

  @override
  _AdminReklamDuzenleState createState() => _AdminReklamDuzenleState();
}

class _AdminReklamDuzenleState extends State<AdminReklamDuzenle> {
  final ReklambaslikController = TextEditingController();
  final ReklamaciklamaController = TextEditingController();
  final ReklamLinkController = TextEditingController();

  final scrollController = ScrollController();

  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();




  List secilenIliskiDurumlariReklam = [];
  List secilenMesleklerReklam = [];
  List<String> secilenKafalarReklam = [];
  List<String> secilenIlIlcelerReklam = [];
  List secilenCinsiyetReklam = [];
  List secilenYasReklam = [];

  String il="İl";
  String secilmisKonumName = "";
  String secilmisKonumAdres = "";
  PickedFile _image;
  var imageUrl;
  DateTime selectedDate;
  bool isLoading = false;
  TimeOfDay selectedTime;

  firebase_storage.FirebaseStorage storage;




  final picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    storage = firebase_storage.FirebaseStorage.instance;
    ReklambaslikController.text=widget.card['baslik'].toString();
    ReklamaciklamaController.text=widget.card['aciklama'].toString();
    ReklamLinkController.text=widget.card['link'].toString();


    il=widget.card['il'] ?? '';
    secilenIliskiDurumlariReklam.addAll(widget.card['iliskidurumu'] ?? []);
    secilenCinsiyetReklam.addAll(widget.card['cinsiyet'] ??[]);
    secilenYasReklam.addAll(widget.card['yas'] ?? []);
    secilenMesleklerReklam.addAll(widget.card['meslek'] ?? []);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Reklam Düzenle",
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
        automaticallyImplyLeading: false,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Loading()
          : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.70), topRight: Radius.circular(20.70)),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(color: const Color(0x5c000000), offset: Offset(0, 0), blurRadius: 33.06, spreadRadius: 4.94)
          ],
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 15.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
          
            
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  controller: ReklambaslikController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 15.0.spByWidth),
                  decoration: InputDecoration(
                    labelText: "Başlık",
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
                  height: 39.0.h,
                ),
                Opacity(
                  opacity: 0.85,
                  child: Text("Fotoğraf",
                      style: TextStyle(
                          color: const Color(0xd9343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                      textAlign: TextAlign.left),
                ),
                Container(
                  width: 312.0.w,
                  height: 166.0.h,
                  margin: EdgeInsets.symmetric(vertical: 20.0.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14, spreadRadius: 0)
                      ],
                      color: Theme.of(context).backgroundColor),
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: _image == null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.network(
                        widget.card['foto'].toString(),
                        width: 312.0.w,
                        height: 166.0.h,
                        fit: BoxFit.fill,
                      ),
                    )
                        :  ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.file(
                        File(_image.path),
                        width: 312.0.w,
                        height: 166.0.h,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),

                TextFormField(
                  controller: ReklamaciklamaController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 15.0.spByWidth),
                  decoration: InputDecoration(
                    labelText: "Açıklama",
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
                  height: 29.0.h,
                ),
                TextFormField(
                  controller: ReklamLinkController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 15.0.spByWidth),
                  decoration: InputDecoration(
                    labelText: "Link",
                    labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 0,
                      ),
                    ),
                  ),
                ),



                SizedBox(height: 30.0.h,),
                Opacity(
                  opacity: 0.85,
                  child: Text("Aranan Şartlar",
                      style: TextStyle(
                          color: const Color(0xd9343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                      textAlign: TextAlign.left),
                ),
                SizedBox(height: 20,),

                Container(
                  alignment: Alignment.bottomCenter,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      InkWell(
                        onTap: () {
                          final secilenil =  Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => IlSec(),
                              fullscreenDialog: true,),
                          );
                          setState(() {
                            secilenil.then((value) {
                              il=value;
                              //print("gelen il:"+il+"  secilen il:"+value);
                              setState(() {

                              });
                            });
                          });


                        },
                        child: DropdownButton(
                          items:[],
                          hint: Text(il,style: TextStyle(color: Colors.black,fontSize: 15.0.spByWidth),),
                          isExpanded: true,
                          value: il,
                          iconSize: 25.0.h,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color:   Theme.of(context).primaryColor,
                            size: 16.0.h,
                          ),
                          underline: Container(height: 1.0, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),




                ListTile(
                  title: Text(secilenCinsiyetReklam.isEmpty ? "Cinsiyet" : secilenCinsiyetReklam.toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                      textAlign: TextAlign.left),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    _showCinsiyet(context);
                  },
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                    size: 16.0.h,
                  ),
                ),
                Divider(
                  height: 3.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text(secilenYasReklam.isEmpty ? "Yaş" : secilenYasReklam.toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                      textAlign: TextAlign.left),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    _showYasAraliklariReklam(context);
                  },
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                    size: 16.0.h,
                  ),
                ),
                Divider(
                  height: 3.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text(secilenMesleklerReklam.isEmpty ? "Meslek" : secilenMesleklerReklam.toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                      textAlign: TextAlign.left),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    _showMesleklerReklam(context);
                  },
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                    size: 16.0.h,
                  ),
                ),
                Divider(
                  height: 3.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: Text(secilenIliskiDurumlariReklam.isEmpty ? "İlişki Durumu" : secilenIliskiDurumlariReklam.toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0.spByWidth),
                      textAlign: TextAlign.left),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    _showIliskiDurumuReklam(context);
                  },
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).primaryColor,
                    size: 16.0.h,
                  ),
                ),
                Divider(
                  height: 3.0,
                  color: Colors.black,
                ),





                SizedBox(
                  height: 38.0.h,
                ),
                MyButton(text: "Kaydet", textColor: Colors.black, fontSize: 15.0.spByWidth, width: MediaQuery.of(context).size.width,
                    height: 44,butonColor: Renkler.onayButonColor,
                    onPressed: (){
                      ReklamOlustur();
                    }),
              ],
            ),

           




            SizedBox(
              height: 100.0.h + MediaQuery.of(context).viewPadding.bottom,
            ),
          ],
        ),
      ),
    );
  }


  Future<void> ReklamOlustur() async {
    if (!validateFormReklamlar()) return;
    final _userModel = Provider.of<UserModel>(context, listen: false);


    Map<String, dynamic> ReklamBilgileri = Map();
    setState(() {
      isLoading = true;
    });

    var downloadUrl = _image != null ?  await uploadEtkinlikImage() : "" ;

    ReklamBilgileri['userId'] = _userModel.user.userId;
    ReklamBilgileri['baslik'] = ReklambaslikController.text;
    ReklamBilgileri['aciklama'] = ReklamaciklamaController.text;
    ReklamBilgileri['link'] = ReklamLinkController.text;
    ReklamBilgileri['gorulmesayisi'] = 0;
    ReklamBilgileri['foto'] = _image != null ? downloadUrl : widget.card['foto'].toString();
    ReklamBilgileri['il'] = il;
    ReklamBilgileri['cinsiyet'] = secilenCinsiyetReklam;
    ReklamBilgileri['yas'] = secilenYasReklam;
    ReklamBilgileri['meslek'] = secilenMesleklerReklam;
    ReklamBilgileri['iliskidurumu'] = secilenIliskiDurumlariReklam;

    bool veri =  await _adminIslemleri.adminReklamDuzenle(ReklamBilgileri,widget.card.id.toString());
    if(veri)
    {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Reklam Düzenlendi.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.purpleAccent,
      );
    }



  }


  bool validateFormReklamlar() {
    if (ReklambaslikController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Lütfen Başlık Yazınız!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }


    if (ReklamaciklamaController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Lütfen Açıklama Yazınız!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }


    return true;
  }




  _imgFromCamera() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 15);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery, imageQuality: 15);

    setState(() {
      _image = image;
      print(_image.path);
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




  Future<String> uploadEtkinlikImage() async {
    String filePath = _image.path;
    final _userModel = Provider.of<UserModel>(context, listen: false);
    String userId = _userModel.user.userId;
    String fileName = "${userId}-${ReklambaslikController.text}-${DateTime.now()}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('reklamfotolari/$fileName').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('reklamfotolari/$fileName').getDownloadURL();

      return downloadURL;
    } on FirebaseException catch (e) {

      return "error";
    }
  }

  void _showYasAraliklariReklam(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: [
            "18-25",
            "25-30",
            "30-40",
            "40-60",
          ].map((e) => MultiSelectItem(e, e)).toList(),
          title: Text("Yas Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          initialValue: secilenYasReklam,
          initialChildSize: 0.5,
          onConfirm: (values) {
            setState(() {
              secilenYasReklam = values;
              print("Secçilen Yaş aralığı = " + secilenYasReklam.toString());
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }


  void _showIliskiDurumuReklam(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: [
            "Evli",
            "Bekar",
            "İlişkisi var",
          ].map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: secilenIliskiDurumlariReklam,
          initialChildSize: 0.4,
          title: Text("İlişki Durumu Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onConfirm: (values) {
            setState(() {
              secilenIliskiDurumlariReklam = values;
              print("Seçilen İlişki durumu = " + secilenIliskiDurumlariReklam.toString());
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  void _showMesleklerReklam(BuildContext context) async {
    var veriJson = await DefaultAssetBundle.of(context).loadString("datalar/meslekler.json");
    var meslekJson = jsonDecode(veriJson)['Meslekler'];
    List<String> tags = meslekJson != null ? List.from(meslekJson) : null;

    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: tags
              .map((e) => MultiSelectItem(e, e))
              .toList(),
          initialValue: secilenMesleklerReklam,
          initialChildSize: 0.6,
          searchable: true,
          searchHint: "Ara",
          title: Text("Meslek Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onSelectionChanged:(List<dynamic> values) {

            secilenMesleklerReklam = values;
            setState(() {

            });
          } ,

          maxChildSize: 0.8,

        );
      },
    );
  }



  void _showCinsiyet(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: [
            "Kadın",
            "Erkek",
          ].map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: secilenCinsiyetReklam,
          initialChildSize: 0.3,
          title: Text("Cinsiyet Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onConfirm: (values) {
            setState(() {
              secilenCinsiyetReklam = values;
              print("Seçilen Cinsiyet = " + secilenCinsiyetReklam.toString());
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }




}
