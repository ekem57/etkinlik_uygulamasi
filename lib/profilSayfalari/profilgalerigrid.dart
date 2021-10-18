import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/photoviewgallery.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;


class GaleriGrid extends StatefulWidget {
  List<dynamic> imageList;
  String imageListId;
  String galeriBaslik;
  String userid;
  DocumentSnapshot card;
  bool benimmi;

  GaleriGrid({this.imageList, this.galeriBaslik, this.userid, this.imageListId, this.card, @required this.benimmi});

  @override
  _GaleriGridState createState() => _GaleriGridState();
}

class GaleriSecim {
  static const String ekle = 'Fotoğraf Ekle';
  static const String albumsil = 'Albümü Sil';

  static const List<String> choices = <String>[ekle, albumsil];
}

class _GaleriGridState extends State<GaleriGrid> {
  static bool albumyukleniyor = false;
  static bool albumsiliniyor = false;

  static int fotoindex = 0;

  List<String> albumlist = [];
  bool _isloading = false;

  @override
  bool get wantKeepAlive => true;
  List<Asset> images = <Asset>[];

  Future<void> choiceAction(String choice) async {
    if (choice == GaleriSecim.ekle) {
      setState(() {
        albumyukleniyor = true;
      });
      loadAssets();
    } else if (choice == GaleriSecim.albumsil) {
      setState(() {
        albumsiliniyor = true;
      });

      String etadi = widget.galeriBaslik;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userid)
          .collection("albumlerim")
          .doc(widget.imageListId.toString())
          .delete();
      for (var item in widget.imageList) {
        var fileUrl = Uri.decodeFull(Path.basename(item.toString())).replaceAll(new RegExp(r'(\?alt).*'), '');

        final Reference firebaseStorageRef =
            FirebaseStorage.instance.ref(widget.userid).child("usersAlbum").child(fileUrl);
        String firebaseBucket = FirebaseStorage.instance.ref(item.toString()).bucket;
        // print("firebase storage url: " +
        //     "gs://" +
        //     firebaseBucket +
        //     "/" +
        //     widget.userid +
        //     "/usersAlbum/" +
        //     firebaseStorageRef.name);

        Reference photoRef6 = FirebaseStorage.instance.ref().storage.refFromURL(
            "gs://" + firebaseBucket + "/" + widget.userid + "/usersAlbum/$etadi/" + firebaseStorageRef.name);
        // print("Fotograf yolu:  " +
        //     "gs://" +
        //     firebaseBucket +
        //     "/" +
        //     widget.userid +
        //     "/usersAlbum/$etadi/" +
        //     firebaseStorageRef.name);
        await photoRef6.delete();
      }

      setState(() {
        albumsiliniyor = false;
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar: AppBar(
        backgroundColor: Renkler.backGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Container(
          child: Text(widget.galeriBaslik,
              maxLines: 2,
              style: TextStyle(
                  color: Renkler.appbarTextColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
              textAlign: TextAlign.center),
        ),
        actions: <Widget>[
          widget.benimmi
              ? PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return GaleriSecim.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              : Container()
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 8,
                blurRadius: 7,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: albumyukleniyor
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Fotoğraflarınız Yükleniyor ....",
                        style: TextStyle(fontSize: 20.0.spByWidth, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0.h,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : albumsiliniyor
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Fotoğraflarınız Siliniyor ....",
                            style: TextStyle(fontSize: 20.0.spByWidth, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30.0.h,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.only(top: 20.0.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: widget.imageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              // String tiklananimage = widget.imageList[index];
                              //
                              // List<dynamic> imagelist = widget.imageList;
                              //
                              // String ilkeleman = imagelist[0];
                              // int bulunan = imagelist.indexOf(tiklananimage);
                              //
                              // imagelist[bulunan] = ilkeleman;
                              // imagelist[0] = tiklananimage;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ImageViewGallery(
                                        imageList: widget.imageList,
                                        galeriBaslik: widget.galeriBaslik,
                                        userid: _userModel.user.userId,
                                        imageListId: widget.imageListId,
                                        card: widget.card,
                                        selectedImageIndex: index,
                                        benimmi: true,
                                      )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              child: Container(
                                color: Colors.blue,
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageList[index].toString(),
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
        ),
      ),
    );
  }

  Future<void> loadAssets() async {

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
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    int index = 0;
    for (var snap in resultList) {
      File resim = await getImageFileFromAssets(snap);
      String resimyolu = await uploadAlbumImageFile(resim, index.toString());
      albumlist.add(resimyolu);
      index++;
    }
    Map<String, dynamic> album = Map();
    album['imgarray'] = albumlist;
    album['tarih'] = Timestamp.now();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userid)
        .collection("albumlerim")
        .doc(widget.imageListId.toString())
        .get();

    List<dynamic> imagelist = snapshot['imgarray'];

    imagelist.addAll(albumlist);

    widget.card.reference.update({'imgarray': imagelist});
    setState(() {
      _isloading = false;
      albumyukleniyor = false;
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
    String etadi = widget.card['galeribaslik'].toString();
    String filePath = pickedImage.path;
    String userId = _userModel.user.userId;
    String fileName = "${userId}-${DateTime.now()}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$etadi/$index').putFile(file);
      String downloadURL =
          await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$etadi/$index').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }
}
