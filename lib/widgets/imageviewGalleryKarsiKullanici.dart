import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:path/path.dart' as Path;

class ImageViewGalleryKarsi extends StatefulWidget {
  List<dynamic> imageList;
  String imageListId;
  String galeriBaslik;
  String userid;
  ImageViewGalleryKarsi({this.imageList,this.galeriBaslik,this.userid,this.imageListId});

  @override
  _ImageViewGalleryKarsiState createState() => _ImageViewGalleryKarsiState();
}

class _ImageViewGalleryKarsiState extends State<ImageViewGalleryKarsi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.galeriBaslik),

      ),
      body:PhotoViewGallery.builder(
        itemCount: widget.imageList.length,
        builder: (context, index) {

          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              widget.imageList[index].toString(),
            ),
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
}
