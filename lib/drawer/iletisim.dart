import 'dart:io';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class IletisimView extends StatefulWidget {
  @override
  _IletisimViewState createState() => _IletisimViewState();
}

class _IletisimViewState extends State<IletisimView> {
  String baslik = "Reklam/Sponsorluk";
  TextEditingController controller = TextEditingController();
  CollectionReference iletisimCollection = FirebaseFirestore.instance.collection('iletisim');
  bool isLoading = false;
  int secilen_index=0;
  PickedFile _image;
  var imageUrl;
  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("İletişim",
              style: TextStyle(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0.spByWidth),
              textAlign: TextAlign.center),
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
          elevation: 0.0,
          brightness: Brightness.light,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16.0),
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
                  children: [
                    Text(
                      "Başlık",
                    ),
                    DropdownButton(
                        value: baslik,
                        isExpanded: true,
                        hint: Text("Baslik Seçiniz"),
                        iconSize: 25.0.h,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black, // Theme.of(context).primaryColor,
                        ),
                        underline: Container(height: 1.0, color: Colors.grey),
                        items: ["Reklam/Sponsorluk", "Öneri", "Şikayet", "Mavi Tik Talebi", "Diğer"].map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (newValue) {
                          baslik = newValue;
                          setState(() {


                          });
                        }),
                   baslik != "Mavi Tik Talebi" ?  Column(children: [
                      SizedBox(
                        height: 30.0.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Mesajınız",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90.0.h,
                        child: TextField(
                          controller: controller,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                        ),
                      ),
                      SizedBox(
                        height: 30.0.h,
                      ),
                      Center(
                        child: Container(
                          width: 292.3333333333333.w,
                          height: 43.666666666666664.h,
                          margin: EdgeInsets.only(bottom: 16.0.h),
                          child: RaisedButton(
                            color: Theme.of(context).buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(65.7.w),
                            ),
                            onPressed: () {
                              setState(() {
                                isLoading = false;
                              });
                              var user = FirebaseAuth.instance.currentUser;


                              if(baslik=="Reklam/Sponsorluk"){
                                FirebaseFirestore.instance.collection("iletisim").doc("reklam").collection("reklamlar").doc().set({
                                  "mesaj": controller.text,
                                  "okundumu": false,
                                  "gonderenUserId": user.uid,
                                  "tarih": Timestamp.now(),
                                  "gonderenFoto": _userModel.user.avatarImageUrl,
                                  "gonderenEmail": user.email,
                                  "gonderenIsim":_userModel.user.adsoyad,
                                }).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }else if(baslik=="Öneri"){


                                FirebaseFirestore.instance.collection("iletisim").doc("oneri").collection("oneriler").doc().set({
                                  "oneri": controller.text,
                                  "okundumu": false,
                                  "gonderenUserId": user.uid,
                                  "tarih": Timestamp.now(),
                                  "gonderenFoto": _userModel.user.avatarImageUrl,
                                  "gonderenEmail": user.email,
                                  "gonderenIsim":_userModel.user.adsoyad,
                                }).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });

                              }
                              else if(baslik=="Şikayet"){

                                FirebaseFirestore.instance.collection("iletisim").doc("sikayet").collection("sikayetler").doc().set({
                                  "sikayet": controller.text,
                                  "okundumu": false,
                                  "gonderenUserId": user.uid,
                                  "tarih": Timestamp.now(),
                                  "gonderenFoto": _userModel.user.avatarImageUrl,
                                  "gonderenEmail": user.email,
                                  "gonderenIsim":_userModel.user.adsoyad,
                                }).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                              else if(baslik=="Mavi Tik Talebi"){

                                FirebaseFirestore.instance.collection("iletisim").doc("mavitik").collection("mavitikler").doc().set({
                                  "baslik": baslik,
                                  "mesaj": controller.text,
                                  "userId": user.uid,
                                  "tarih": Timestamp.now(),
                                  "mail": user.email,
                                  "userName":_userModel.user.adsoyad,
                                }).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                              else if(baslik=="Diğer"){
                                FirebaseFirestore.instance.collection("iletisim").doc("diger").collection("digerleri").doc().set({
                                  "mesaj": controller.text,
                                  "okundumu": false,
                                  "gonderenUserId": user.uid,
                                  "tarih": Timestamp.now(),
                                  "gonderenFoto": _userModel.user.avatarImageUrl,
                                  "gonderenEmail": user.email,
                                  "gonderenIsim":_userModel.user.adsoyad,
                                }).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }



                              Fluttertoast.showToast(
                                msg: "Mesajınız Gönderildi!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                textColor: Colors.white,
                                backgroundColor: Colors.purpleAccent,
                              );
                              Navigator.of(context).pop();
                            },

                            elevation: 8.3,
                            child: Text(
                              "Gönder",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0.spByWidth),
                            ),
                          ),
                        ),
                      ),
                    ],) : Column(children: [
                     SizedBox(
                       height: 10.0.h,
                     ),
                     SizedBox(height: 20,),
                     Opacity(
                       opacity: 0.85,
                       child: Text("Mavi Tik için lütfen bize bir selfinizi gönderin.",
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
                           _imgFromCamera();
                          // Navigator.of(context).pop();
                         },
                         child: _image == null
                             ? Container(
                           width: 56.0.w,
                           height: 56.0.w,
                           decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               boxShadow: [
                                 BoxShadow(
                                     color: const Color(0x36000000),
                                     offset: Offset(2, 3),
                                     blurRadius: 18,
                                     spreadRadius: 0)
                               ],
                               color: Theme.of(context).backgroundColor),
                           child: Icon(Icons.camera_alt, size: 24.0.h, color: Theme.of(context).primaryColor),
                         )
                             : ClipRRect(
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
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child: Align(
                         alignment: Alignment.topLeft,
                         child: Text(
                           "Mesajınız",
                           style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         height: 100.0.h,
                         child: TextField(
                           controller: controller,
                           expands: true,
                           maxLines: null,
                           minLines: null,
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 30.0.h,
                     ),
                     Center(
                       child: Container(
                         width: 292.3333333333333.w,
                         height: 43.666666666666664.h,
                         margin: EdgeInsets.only(bottom: 16.0.h),
                         child: RaisedButton(
                           color: Theme.of(context).buttonColor,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(65.7.w),
                           ),
                           onPressed: () async {
                             if(_userModel.user.mavitik){
                               Fluttertoast.showToast(
                                 msg: "Zaten Mavi Tik Sahibisiniz!",
                                 toastLength: Toast.LENGTH_LONG,
                                 gravity: ToastGravity.CENTER,
                                 textColor: Colors.white,
                                 backgroundColor: Colors.purpleAccent,
                               );
                             }else {
                               setState(() {
                                 isLoading = false;
                               });
                               var user = FirebaseAuth.instance.currentUser;

                               var tarih = DateTime.now().toString();

                               if (baslik == "Reklam/Sponsorluk") {
                                 FirebaseFirestore.instance.collection(
                                     "iletisim").doc("reklam").collection(
                                     "reklamlar").doc().set({
                                   "mesaj": controller.text,
                                   "okundumu": false,
                                   "gonderenUserId": user.uid,
                                   "tarih": Timestamp.now(),
                                   "gonderenFoto": _userModel.user
                                       .avatarImageUrl,
                                   "gonderenEmail": user.email,
                                   "gonderenIsim": _userModel.user.adsoyad,
                                 }).then((value) {
                                   setState(() {
                                     isLoading = false;
                                   });
                                 });
                               } else if (baslik == "Öneri") {
                                 FirebaseFirestore.instance.collection(
                                     "iletisim").doc("oneri").collection(
                                     "oneriler").doc().set({
                                   "oneri": controller.text,
                                   "okundumu": false,
                                   "gonderenUserId": user.uid,
                                   "tarih": Timestamp.now(),
                                   "gonderenFoto": _userModel.user
                                       .avatarImageUrl,
                                   "gonderenEmail": user.email,
                                   "gonderenIsim": _userModel.user.adsoyad,
                                 }).then((value) {
                                   setState(() {
                                     isLoading = false;
                                   });
                                 });
                               }
                               else if (baslik == "Şikayet") {
                                 FirebaseFirestore.instance.collection(
                                     "iletisim").doc("sikayet").collection(
                                     "sikayetler").doc().set({
                                   "sikayet": controller.text,
                                   "okundumu": false,
                                   "gonderenUserId": user.uid,
                                   "tarih": Timestamp.now(),
                                   "gonderenFoto": _userModel.user
                                       .avatarImageUrl,
                                   "gonderenEmail": user.email,
                                   "gonderenIsim": _userModel.user.adsoyad,
                                 }).then((value) {
                                   setState(() {
                                     isLoading = false;
                                   });
                                 });
                               }
                               else if (baslik == "Mavi Tik Talebi") {
                                 if (_image != null) {
                                   FirebaseFirestore.instance.collection(
                                       "iletisim").doc("mavitik").collection(
                                       "mavitikler").doc().set({
                                     "mesaj": controller.text,
                                     "okundumu": false,
                                     "gonderenUserId": user.uid,
                                     "tarih": Timestamp.now(),
                                     "gonderenFoto": _userModel.user
                                         .avatarImageUrl,
                                     "gonderenEmail": user.email,
                                     "gonderenIsim": _userModel.user.adsoyad,
                                     "foto": await uploadEtkinlikImage(),
                                   }).then((value) {
                                     setState(() {
                                       isLoading = false;
                                     });
                                   });
                                 } else {
                                   var dialogBilgi = AlertBilgilendirme(
                                     message: "Lütfen bir selfie gönderin.",
                                     onPostivePressed: () {
                                       Navigator.pop(context);
                                       Navigator.pop(context);
                                       Navigator.pop(context);
                                     },
                                   );

                                   showDialog(
                                       context: context,
                                       builder: (
                                           BuildContext context) => dialogBilgi);
                                 }
                               }
                               else if (baslik == "Diğer") {
                                 FirebaseFirestore.instance.collection(
                                     "iletisim").doc("diger").collection(
                                     "digerleri").doc().set({
                                   "mesaj": controller.text,
                                   "okundumu": false,
                                   "gonderenUserId": user.uid,
                                   "tarih": Timestamp.now(),
                                   "gonderenFoto": _userModel.user
                                       .avatarImageUrl,
                                   "gonderenEmail": user.email,
                                   "gonderenIsim": _userModel.user.adsoyad,
                                 }).then((value) {
                                   setState(() {
                                     isLoading = false;
                                   });
                                 });
                               }


                               Fluttertoast.showToast(
                                 msg: "Mesajınız Gönderildi!",
                                 toastLength: Toast.LENGTH_LONG,
                                 gravity: ToastGravity.CENTER,
                                 textColor: Colors.white,
                                 backgroundColor: Colors.purpleAccent,
                               );
                               Navigator.of(context).pop();
                             }
                           },

                           elevation: 8.3,
                           child: Text(
                             "Gönder",
                             style: TextStyle(
                                 color: const Color(0xff343633),
                                 fontWeight: FontWeight.w600,
                                 fontFamily: "OpenSans",
                                 fontStyle: FontStyle.normal,
                                 fontSize: 15.0.spByWidth),
                           ),
                         ),
                       ),
                     ),
                   ],),
                  ]..addAll([
                    SizedBox(height: 50.0.h),
                    Center(child: Text("https://www.etkinlikkafasi.com")),
                    Center(child: Text("0850 123 45 67 89")),
                  ]),
                ),
        ));
  }




  _imgFromCamera() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 25);

      setState(() {
        _image = image;
      });

  }



  Future<String> uploadEtkinlikImage() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if(_image == null)
      return "";
    String filePath = _image.path;
    String userId = _userModel.user.userId;
    String fileName = "${userId}-mavitik";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('$userId/$fileName').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('$userId/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
