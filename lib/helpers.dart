import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatTheDate(DateTime selectedDate, {DateFormat format}) {
  final DateTime now = selectedDate;
  final DateFormat formatter = format ?? DateFormat('dd.MM.y', "tr_TR");
  final String formatted = formatter.format(now);
  initializeDateFormatting("tr_TR");
  return formatted;
}

Future<PickedFile> imgFromCamera(ImagePicker picker) async {
  PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 25);
  return  image;
}

Future<PickedFile> imgFromGallery(ImagePicker picker) async {
  PickedFile image = await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
  return image;
}

String getGoogleApiKey(){
  if (Platform.isAndroid) {
    return "AIzaSyBWgYeqNMUqLjzDQjWyNzxSEp7kKg43A0s";
  } else if (Platform.isIOS) {
    return "AIzaSyDgbCdEH9Wdm6h3feJZk2qyFWS7P_rVlE8";
  }else{
    debugPrint("Google Api Key unsupportted platfrom");
  }
}