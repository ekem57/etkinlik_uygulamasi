import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class ImageViewGallery extends StatefulWidget {
  List<dynamic> imageList;
  final int selectedImageIndex;
  String imageListId;
  String galeriBaslik;
  String userid;
  DocumentSnapshot card;
  bool benimmi;

  ImageViewGallery(
      {this.imageList,
      this.selectedImageIndex,
      this.galeriBaslik,
      this.userid,
      this.imageListId,
      this.card,
      @required this.benimmi});

  @override
  _ImageViewGalleryState createState() => _ImageViewGalleryState();
}

class Constants {
  static const String ekle = 'Fotoğraf Ekle';
  static const String sil = 'Fotoğraf Sil';
  static const String albumsil = 'Albümü Sil';

  static const List<String> choices = <String>[ekle, sil, albumsil];
}

class _ImageViewGalleryState extends State<ImageViewGallery> {
  List<String> albumlist = [];
  bool isLoading = false;
  List<Asset> images = <Asset>[];
  final pageController = PageController();

  Future<void> choiceAction(String choice) async {
    if (choice == Constants.ekle) {
      loadAssets();
    } else if (choice == Constants.sil) {
      widget.imageList.removeAt(pageController.page.toInt());
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userid)
          .collection("albumlerim")
          .doc(widget.imageListId.toString())
          .update({'imgarray': widget.imageList});
      Navigator.pop(context);
      Navigator.pop(context);
    } else if (choice == Constants.albumsil) {
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
        Reference photoRef6 = FirebaseStorage.instance.ref().storage.refFromURL(
            "gs://" + firebaseBucket + "/" + widget.userid + "/usersAlbum/$etadi/" + firebaseStorageRef.name);
        await photoRef6.delete();
      }

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.selectedImageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.galeriBaslik),
        actions: <Widget>[
          widget.benimmi
              ? PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
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
      body: PhotoViewGallery.builder(
        itemCount: widget.imageList.length,
        pageController: pageController,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(widget.imageList[index].toString()),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = "";
    setState(() {
      isLoading = true;
    });
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "albüm"),
        materialOptions: MaterialOptions(
          allViewTitle: "Bütün Fotoğraflar",
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
      isLoading = false;
    });
    Navigator.pop(context);
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
    // String fileName = "$userId-${DateTime.now()}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$etadi/$index').putFile(file);
      String downloadURL =
          await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$etadi/$index').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("Error on uploading image file ${e.code}");
      return "error";
    }
  }
}
