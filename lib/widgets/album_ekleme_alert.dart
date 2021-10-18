import 'dart:io';
import 'package:etkinlik_kafasi/profilim/profilim.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumEkleTextField extends StatefulWidget {
  String title;
  DocumentSnapshot card;

  AlbumEkleTextField({
    this.title,
    this.card,
  });

  @override
  _AlbumEkleTextFieldState createState() => _AlbumEkleTextFieldState();
}

class _AlbumEkleTextFieldState extends State<AlbumEkleTextField> with AutomaticKeepAliveClientMixin {
  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();
  List<String> albumlist = [];
  bool _isloading = false;

  @override
  bool get wantKeepAlive => true;
  List<Asset> images = <Asset>[];
  TextEditingController albumNameController = TextEditingController();
  String albumAdi = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(15.0.w),
      insetPadding: EdgeInsets.all(12.0.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: _isloading
          ? Text("Albüm Yükleniyor...")
          : Text(
              widget.title,
              textAlign: TextAlign.center,
            ),
      content: _isloading
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: 140.0.h,
              child: Center(child: CircularProgressIndicator()))
          : Container(
              width: MediaQuery.of(context).size.width,
              height: 140.0.h,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: TextFormField(
                      controller: albumNameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15.0.spByWidth),
                      decoration: InputDecoration(
                        hintText: "Albüm Adı Giriniz",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.0.w, vertical: 20.0.h),
                    child: MyButton(
                        text: "Albüm Oluştur",
                        butonColor: Renkler.onayButonColor,
                        fontSize: 15,
                        width: 157.0.w,
                        height: 33.0.h,
                        onPressed: () {
                          if (albumNameController.text.isEmpty) return;
                          albumAdi = albumNameController.text;
                          loadAssets();
                        }),
                  ),
                ],
              ),
            ),
    );
  }
  Future<void> loadAssets() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    setState(() {
      _isloading = true;
    });
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 50,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "albüm"),
        materialOptions: MaterialOptions(
          allViewTitle: "Tüm Fotoğraflar",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print("MultiImagePickerError:$error");
    }

    if(!mounted) return;

    int index=0;
    for (var snap in resultList) {
      print("geldi");
      File resim =  await getImageFileFromAssets(snap);
      String resimyolu = await uploadAlbumImageFile(resim,index.toString());
      albumlist.add(resimyolu);
      index++;
    }
    print("album list toplam:"+albumlist.length.toString());

    Map<String, dynamic> album = Map();
    album['imgarray'] = albumlist;
    album['galeribaslik'] = albumNameController.text;
    album['tarih'] = Timestamp.now();

    FirebaseFirestore.instance.collection("users").doc(_userModel.user.userId).collection("albumlerim").doc().set(album);
    setState(() {
      _isloading=false;
    });
    Navigator.pop(context);
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile = File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  Future<String> uploadAlbumImageFile(File pickedImage, String index) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    String filePath = pickedImage.path;
    String userId = _userModel.user.userId;
    String fileName = "${userId}-${DateTime.now()}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$albumAdi/$index').putFile(file);
      String downloadURL =
          await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$albumAdi/$index').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }
}
