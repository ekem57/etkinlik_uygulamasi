import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:etkinlik_kafasi/etkinlikler/etkinlikkisidavetet.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

enum Katilimci { ozel, Herkes }

class EtkinlikOlustur extends StatefulWidget {
  @override
  _EtkinlikOlusturState createState() => _EtkinlikOlusturState();
}

class _EtkinlikOlusturState extends State<EtkinlikOlustur> {
  PickResult selectedPlace;
  final baslikController = TextEditingController();
  final aciklamaController = TextEditingController();
  final sartKonumController = TextEditingController();
  final konumController = TextEditingController();
  final kacKisiController = TextEditingController();
  final tarihController = TextEditingController();
  final saatController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final scrollController = ScrollController();
  List secilenIliskiDurumlari = [];
  List<String> secilenMeslekler = [];
  List<String> secilenKafalar = [];
  List<String> secilenIlIlceler = [];
  List<String> bosliste = [];
  List secilenCinsiyet = [];
  List secilenOgrenimDurumu = [];
  List secilenYas = [];
  String _etkinlikTipi = "Standard";
  String secilmisKonumName = "";
  String secilmisKonumAdres = "";
  PickedFile _image;
  var imageUrl;
  DateTime selectedDate;
  bool isLoading = false;
  TimeOfDay selectedTime;
  Katilimci _katilimci = Katilimci.Herkes;
  firebase_storage.FirebaseStorage storage;
  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final picker = ImagePicker();
  String _placeName = 'Unknown';

  @override
  void initState() {
    super.initState();
    etkinlikozelKatilimci.clear();
    etkinlikozelKatilimciidler.clear();
    storage = firebase_storage.FirebaseStorage.instance;
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    final accentColor = Theme.of(context).accentColor;
    final backgroundColor = Theme.of(context).backgroundColor;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Etkinlik Oluştur",
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
      ),
      body: isLoading
          ? Loading()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.70), topRight: Radius.circular(20.70)),
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(color: const Color(0x5c000000), offset: Offset(0, 0), blurRadius: 33.06, spreadRadius: 4.94)
                ],
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 15.0.h),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Opacity(
                    opacity: 0.85,
                    child: Text("Etkinlik Tipi",
                        style: TextStyle(
                            color: const Color(0xd9343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                  ),
                  SizedBox(
                    height: 13.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: _etkinlikTipi == "Standard" ? accentColor : backgroundColor,
                          onPressed: () {
                            setState(() {
                              _etkinlikTipi = "Standard";
                            });
                          },
                          child: Text("Standard",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.3.spByWidth),
                              textAlign: TextAlign.center),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.30)),
                        ),
                      ),
                      SizedBox(
                        width: 8.0.w,
                      ),
                      Expanded(
                        child: RaisedButton(
                            color: _etkinlikTipi == "Turnuva" ? accentColor : backgroundColor,
                            onPressed: () {
                              if (_userModel.user.uyelikTipi == "standart") {
                                var dialogBilgi = AlertBilgilendirme(
                                  message: "Bu özellik sadece Gold ve Plus üyeler tarafından kullanılabilir.",
                                  onPostivePressed: () {
                                    Navigator.pop(context);
                                  },
                                );

                                showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                              } else {
                                setState(() {
                                  _etkinlikTipi = "Turnuva";
                                });
                              }
                            },
                            child: Text("Turnuva",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.3.spByWidth),
                                textAlign: TextAlign.center),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.30))),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "*",
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                        Container(
                          child: Expanded(
                            child: TextFormField(
                              maxLength: 50,
                              controller: baslikController,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 39.0.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red, fontSize: 25),
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
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red, fontSize: 25),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(selectedDate == null ? "Tarih" : formatTheDate(selectedDate),
                                        style: TextStyle(
                                            color: const Color(0xd9343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0.spByWidth),
                                        textAlign: TextAlign.left),
                                    contentPadding: EdgeInsets.zero,
                                    trailing: Icon(
                                      Icons.date_range,
                                      size: 20.0.h,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50.0.w,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red, fontSize: 25),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(selectedTime == null ? "Saat" : selectedTime.format(context),
                                        style: TextStyle(
                                            color: const Color(0xd9343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0.spByWidth),
                                        textAlign: TextAlign.left),
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      _selectTime(context);
                                    },
                                    trailing: Icon(
                                      Icons.access_time,
                                      size: 20.0.h,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 29.0.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: aciklamaController,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 29.0.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: konumController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          expands: false,
                          maxLines: 5,
                          minLines: 1,
                          style: TextStyle(fontSize: 15.0.spByWidth),
                          decoration: InputDecoration(
                            labelText: "Konum",
                            labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.location_pin,
                                size: 20.0.h,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: "AIzaSyBWgYeqNMUqLjzDQjWyNzxSEp7kKg43A0s",
                                      initialPosition: LatLng(0, 0),
                                      useCurrentLocation: true,
                                      selectInitialPosition: true,
                                      usePlaceDetailSearch: true,
                                      autocompleteLanguage: "tr",
                                      region: "tr",
                                      selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                                        return isSearchBarFocused
                                            ? Container()
                                            : FloatingCard(
                                                bottomPosition: 0.0,
                                                leftPosition: 0.0,
                                                rightPosition: 0.0,
//                                      width: 500,

                                                borderRadius: BorderRadius.circular(12.0),
                                                child: selectedPlace == null
                                                    ? Center(child: CircularProgressIndicator())
                                                    : Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              selectedPlace.formattedAddress,
                                                              style: TextStyle(
                                                                  color: const Color(0xd9343633),
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "OpenSans",
                                                                  fontStyle: FontStyle.normal,
                                                                  fontSize: 15.0.spByWidth),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            RaisedButton(
                                                              child: Text(
                                                                "Seç",
                                                                style: TextStyle(
                                                                    color: const Color(0xd9343633),
                                                                    fontWeight: FontWeight.w400,
                                                                    fontFamily: "OpenSans",
                                                                    fontStyle: FontStyle.normal,
                                                                    fontSize: 15.0.spByWidth),
                                                              ),
                                                              onPressed: () {
                                                                print(selectedPlace.formattedAddress);
                                                                print(selectedPlace.name);
                                                                setState(() {
                                                                  secilmisKonumName = selectedPlace.name;
                                                                  secilmisKonumAdres = selectedPlace.formattedAddress;
                                                                  konumController.text =
                                                                      secilmisKonumName + "\n" + secilmisKonumAdres;
                                                                });
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _etkinlikTipi == "Standard"
                      ? Container()
                      : SizedBox(
                          height: 29.0.h,
                        ),
                  _etkinlikTipi == "Standard"
                      ? Container()
                      : Row(
                          children: [
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red, fontSize: 25),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: kacKisiController,
                                keyboardType: TextInputType.number,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(fontSize: 15.0.spByWidth),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  labelText: "Kaç Kişi Katılabilir",
                                  labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 29.0.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red, fontSize: 25),
                          ),
                          Text(
                            "Etkinlik Kategorisi",
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.0.spByWidth),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(secilenKafalar.isEmpty ? "" : secilenKafalar.toString(),
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.0.spByWidth),
                            textAlign: TextAlign.left),
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          _showEtkinlikKategorisi(context);
                        },
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).primaryColor,
                          size: 16.0.h,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 3.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 39.0.h,
                  ),
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
                  ListTile(
                    title: Text(secilenIlIlceler.isEmpty ? "Konum" : secilenIlIlceler.toString(),
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      if (_userModel.user.uyelikTipi == "standart") {
                        var dialogBilgi = AlertBilgilendirme(
                          message: "Bu özellik sadece Gold ve Plus üyeler tarafından kullanılabilir.",
                          onPostivePressed: () {
                            Navigator.pop(context);
                          },
                        );

                        showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                      } else {
                        _showIlveIlceListesi(context);
                      }
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
                    title: Text(secilenOgrenimDurumu.isEmpty ? "Öğrenim Durumu" : secilenOgrenimDurumu.toString(),
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      if (_userModel.user.uyelikTipi == "standart") {
                        var dialogBilgi = AlertBilgilendirme(
                          message: "Bu özellik sadece Gold ve Plus üyeler tarafından kullanılabilir.",
                          onPostivePressed: () {
                            Navigator.pop(context);
                          },
                        );

                        showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                      } else {
                        _showOgrenimDurumu(context);
                      }
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
                    title: Text(secilenMeslekler.isEmpty ? "Meslek" : secilenMeslekler.toString(),
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      if (_userModel.user.uyelikTipi == "standart") {
                        var dialogBilgi = AlertBilgilendirme(
                          message: "Bu özellik sadece Gold ve Plus üyeler tarafından kullanılabilir.",
                          onPostivePressed: () {
                            Navigator.pop(context);
                          },
                        );

                        showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                      } else {
                        _showMeslekler(context);
                      }
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
                    title: Text(secilenYas.isEmpty ? "Yaş" : secilenYas.toString(),
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      if (_userModel.user.uyelikTipi != "gold") {
                        var dialogBilgi = AlertBilgilendirme(
                          message: "Bu özellik sadece Gold üyeler tarafından kullanılabilir.",
                          onPostivePressed: () {
                            Navigator.pop(context);
                          },
                        );
                        showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                      } else {
                        _showYasAraliklari(context);
                      }
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
                    title: Text(secilenIliskiDurumlari.isEmpty ? "İlişki Durumu" : secilenIliskiDurumlari.toString(),
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      if (_userModel.user.uyelikTipi != "gold") {
                        var dialogBilgi = AlertBilgilendirme(
                          message: "Bu özellik sadece Gold üyeler tarafından kullanılabilir.",
                          onPostivePressed: () {
                            Navigator.pop(context);
                          },
                        );

                        showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                      } else {
                        _showIliskiDurumu(context);
                      }
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
                    title: Text(secilenCinsiyet.isEmpty ? "Cinsiyet" : secilenCinsiyet.toString(),
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      if (_userModel.user.uyelikTipi != "gold") {
                        var dialogBilgi = AlertBilgilendirme(
                          message: "Bu özellik sadece Gold  üyeler tarafından kullanılabilir.",
                          onPostivePressed: () {
                            Navigator.pop(context);
                          },
                        );
                        showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                      } else {
                        _showCinsiyet(context);
                      }
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
                    height: 39.0.h,
                  ),
                  Opacity(
                    opacity: 0.85,
                    child: Text("Kimler Katılabilir",
                        style: TextStyle(
                            color: const Color(0xd9343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                  ),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  ListTile(
                    title: Text("Herkes",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio(
                      value: Katilimci.Herkes,
                      groupValue: _katilimci,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (Katilimci value) {
                        setState(() {
                          _katilimci = value;
                        });
                      },
                    ),
                  ),
                  Divider(
                    height: 3.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text("Özel",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0.spByWidth),
                        textAlign: TextAlign.left),
                    contentPadding: EdgeInsets.zero,
                    trailing: Radio(
                      value: Katilimci.ozel,
                      groupValue: _katilimci,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (Katilimci value) {
                        if (_userModel.user.uyelikTipi != "gold") {
                          var dialogBilgi = AlertBilgilendirme(
                            message: "Bu özellik sadece Gold  üyeler tarafından kullanılabilir. ",
                            onPostivePressed: () {
                              Navigator.pop(context);
                            },
                          );

                          showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                        } else {
                          setState(() {
                            _katilimci = value;
                          });
                        }
                      },
                    ),
                  ),


                  SizedBox(
                    height: 19.0.h,
                  ),
                  _katilimci == Katilimci.ozel
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.85,
                              child: Text("Davetliler",
                                  style: TextStyle(
                                      color: const Color(0xd9343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0.spByWidth),
                                  textAlign: TextAlign.left),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateSecondPage();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0.h),
                                child: Text(
                                  "Kişi Ekle",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0.spByWidth),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Divider(
                              height: 3.0,
                              color: Colors.black,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: etkinlikozelKatilimci.length,
                              itemBuilder: (_, int index) {
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.45,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 7.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 60.0.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(11.70)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color(0x26000000),
                                                  offset: Offset(0, 0),
                                                  blurRadius: 5.50,
                                                  spreadRadius: 0.5)
                                            ],
                                            color: Theme.of(context).backgroundColor),
                                        child: ListTile(
                                          title: Text(
                                            etkinlikozelKatilimci[index]['ad'].toString(),
                                            style: TextStyle(
                                                color: const Color(0xff343633),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.7.h),
                                          ),
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              etkinlikozelKatilimci[index]['avatarImageUrl'].toString(),
                                            ),
                                            radius: 26.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  secondaryActions: <Widget>[
                                    Container(
                                      height: 70.0.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20.70)),
                                      ),
                                      child: IconSlideAction(
                                          caption: 'Sil',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () async {
                                            etkinlikozelKatilimci.removeAt(index);
                                            etkinlikozelKatilimciidler.removeAt(index);
                                            setState(() {});
                                          }),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                      : Container(),
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
                        if (_userModel.user.uyelikTipi == "standart") {
                          if (_userModel.user.acilanetkinliksayim >= 5) {
                            var dialogBilgi = AlertBilgilendirme(
                              message: "Standart Paketde haftalık en fazla 5 etkinlik açabilirsiniz.",
                              onPostivePressed: () {
                                Navigator.pop(context);
                              },
                            );

                            showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                          } else {
                            etkinlikOlustur();
                            _userModel.user.acilanetkinliksayim++;
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(_userModel.user.userId)
                                .update({'acilanetkinliksayisi': FieldValue.increment(1)});
                          }
                        } else if (_userModel.user.uyelikTipi == "plus") {
                          if (_userModel.user.acilanetkinliksayim >= 10) {
                            var dialogBilgi = AlertBilgilendirme(
                              message: "Plus Paketde haftalık en fazla 10 etkinlik açabilirsiniz.",
                              onPostivePressed: () {
                                Navigator.pop(context);
                              },
                            );

                            showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                          } else {
                            etkinlikOlustur();
                            _userModel.user.acilanetkinliksayim++;
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(_userModel.user.userId)
                                .update({'acilanetkinliksayisi': FieldValue.increment(1)});
                          }
                        } else if (_userModel.user.uyelikTipi == "gold") {
                          if (_userModel.user.acilanetkinliksayim >= 20) {
                            var dialogBilgi = AlertBilgilendirme(
                              message: "Plus Paketde haftalık en fazla 20 etkinlik açabilirsiniz.",
                              onPostivePressed: () {
                                Navigator.pop(context);
                              },
                            );
                            showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                          } else {
                            etkinlikOlustur();
                            _userModel.user.acilanetkinliksayim++;
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(_userModel.user.userId)
                                .update({'acilanetkinliksayisi': FieldValue.increment(1)});
                          }

                        }
                      },
                      elevation: 8.3,
                      child: Text(
                        "Oluştur",
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.7.spByWidth),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.0.h + MediaQuery.of(context).viewPadding.bottom,
                  ),
                ],
              ),
            ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => KisiDavetEt());
    Navigator.push(context, route).then(onGoBack);
  }

  DateTime etkinlikTimeConvert() {
    var tarih = selectedDate;
    var saat = selectedTime.format(context);
    var hour = int.parse(saat.split(":")[0]);
    var min = int.parse(saat.split(":")[1]);
    TimeOfDay time = TimeOfDay(hour: hour, minute: min);

    var etkinlikTime = DateTime(tarih.year, tarih.month, tarih.day, time.hour, time.minute);
    return etkinlikTime;
  }

  Future<void> etkinlikOlustur() async {
    DocumentReference etkinlikCollection = FirebaseFirestore.instance.collection('etkinlikOnayBekleyenler').doc();

    if (!validateForm()) return;
    final _userModel = Provider.of<UserModel>(context, listen: false);
    String userId = _userModel.user.userId;
    String adSoyad = _userModel.user.adsoyad;
    DocumentReference  documentReference=  FirebaseFirestore.instance.collection("etkinlikOnayBekleyenler").doc();
    Map<String, dynamic> etkinlikBilgileri = Map();
    Map<String, dynamic> etkinlikSartlari = Map();

    setState(() {
      isLoading = true;
    });

    if( _katilimci == Katilimci.ozel){
      for (DocumentSnapshot snap in etkinlikozelKatilimci) {
        etkinlikCollection.collection("davetliler").doc(snap.id).set({'userid':snap['userId']});
      }
    }
    var downloadUrl = await uploadEtkinlikImage(etkinlikCollection.id);

    etkinlikBilgileri['userId'] = userId;
    etkinlikBilgileri['yayinlayanAdSoyad'] = adSoyad;
    etkinlikBilgileri['baslik'] = baslikController.text;
    etkinlikBilgileri['etkinlikTipi'] = _etkinlikTipi;
    etkinlikBilgileri['kategori'] = secilenKafalar;
    etkinlikBilgileri['etkinlikFoto'] = downloadUrl;
    etkinlikBilgileri['tarih'] = etkinlikTimeConvert();
    etkinlikBilgileri['saat'] = selectedTime.format(context);
    etkinlikBilgileri['hakkinda'] = aciklamaController.text;
    etkinlikBilgileri['konum'] = konumController.text;
    etkinlikBilgileri['kimKatilabilir'] = _katilimci.index;
    etkinlikBilgileri['gelensayisi'] = 0;
    etkinlikBilgileri['il'] = secilenIlIlceler.isEmpty ? bosliste : secilenIlIlceler[0] == "Hepsi" ? bosliste : secilenIlIlceler;
    etkinlikBilgileri['cinsiyet'] = secilenCinsiyet.isEmpty ? bosliste : secilenCinsiyet[0] == "Hepsi" ? bosliste : secilenCinsiyet;
    etkinlikBilgileri['ogrenimdurumu'] = secilenOgrenimDurumu.isEmpty ? bosliste : secilenOgrenimDurumu[0] == "Hepsi" ? bosliste : secilenCinsiyet;
    etkinlikBilgileri['yasaraligi'] = secilenYas.isEmpty ? "" : secilenYas[0] == "Hepsi" ? "" : secilenYas[0].toString().substring(0,2)+"-"+secilenYas.last.toString().substring(3,5);
    etkinlikBilgileri['meslek'] = secilenMeslekler.isEmpty ? bosliste : secilenMeslekler[0] == "Hepsi" ? bosliste : secilenMeslekler;
    etkinlikBilgileri['iliskidurumu'] = secilenIliskiDurumlari.isEmpty ? bosliste : secilenIliskiDurumlari[0] == "Hepsi" ? bosliste : secilenIliskiDurumlari;
    etkinlikBilgileri['yonetici'] = false;
    etkinlikBilgileri['etkinlikKatildi'] = 0;
    etkinlikBilgileri['katilimciSayisi'] = 0;
    etkinlikBilgileri['blockedUsers'] = [];//TODO Buraya engelli kullanıcılar gelicek
    etkinlikBilgileri['maxkatilimcisayisi'] = kacKisiController.text != "" ?  int.parse(kacKisiController.text): kacKisiController.text;


    List<String> keywords = [
      aciklamaController.text.toLowerCase(),
      konumController.text.toLowerCase(),
      adSoyad.toLowerCase(),
      formatTheDate(selectedDate),
      formatTheDate(selectedDate, format: DateFormat("dd MMMM y","tr_TR")).toLowerCase()
    ];
    var regex = RegExp(r"[a-zA-Z0-9ööÖçÇüÜıIİ]+").allMatches(baslikController.text.toLowerCase());
    regex.forEach((element)=> {keywords.add(element.group(0))});
    regex = RegExp(r"[a-zA-Z0-9öÖçÇüÜığĞşŞİ]+").allMatches(konumController.text.toLowerCase());
    regex.forEach((element)=> {keywords.add(element.group(0))});

    etkinlikBilgileri['keywords'] = keywords;
    etkinlikBilgileri['katilimci'] = 0;
    etkinlikBilgileri['etid'] = etkinlikCollection.id;
    etkinlikSartlari['konum'] = sartKonumController.text.toLowerCase();
    etkinlikSartlari['cinsiyet'] = secilenCinsiyet;
    etkinlikSartlari['meslek'] = secilenMeslekler;
    etkinlikSartlari['iliskiDurumu'] = secilenIliskiDurumlari;
    etkinlikSartlari['kimlerKatilabilir'] = _katilimci.index;


    etkinlikBilgileri['katilimaIstegi'] = 0;
    etkinlikCollection.set(etkinlikBilgileri).then((document) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Etkinlik Onaya Gönderildi!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.purpleAccent,
      );
      resetFields();
    }).catchError((onError) => print("Failed to add document to etkinlik collection ${onError.toString()}"));
  }

  bool validateForm() {
    if (baslikController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Lütfen Başlık Yazınız!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "Lütfen Etkinlik Resmi Ekleyiniz!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }
    if (selectedDate == null) {
      Fluttertoast.showToast(
          msg: "Lütfen Tarih Seçimi Yapınız!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }

    if (selectedTime == null) {
      Fluttertoast.showToast(
          msg: "Lütfen Saat Seçimi Yapınız!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }
    var selectedDateAndTime =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
    if (selectedDateAndTime.difference(DateTime.now()).isNegative) {
      Fluttertoast.showToast(
          msg: "Geçmiş Tarih seçilemez!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }
    if (aciklamaController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Lütfen Açıklama Yazınız!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }
    if (konumController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Lütfen Konum Giriniz!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }
    if (secilenKafalar.length == 0) {
      Fluttertoast.showToast(
          msg: "Lütfen Kategori Seçimi Yapınız!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          fontSize: 20.0.h);
      return false;
    }

    return true;
  }

  void _showYasAraliklari(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: [
            "Hepsi",
            "18-25",
            "25-30",
            "30-40",
            "40-60",
            "60-99",
          ].map((e) => MultiSelectItem(e, e)).toList(),
          title: Text("Yas Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          initialValue: secilenYas,
          initialChildSize: 0.5,
          onConfirm: (values) {
            setState(() {
              secilenYas = values;
              print("Secçilen Yaş aralığı = " + secilenYas.toString());
            });
          },
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
            "Hepsi",
            "Kadın",
            "Erkek",
          ].map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: secilenCinsiyet,
          initialChildSize: 0.4,
          title: Text("Cinsiyet Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onConfirm: (values) {
            setState(() {
              secilenCinsiyet = values;
              print("Seçilen Cinsiyet = " + secilenCinsiyet.toString());
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  void _showOgrenimDurumu(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: ["Hepsi", "İlk Öğretim", "Orta Öğretim", "Lise", "Ön Lisans", "Lisans", "Yüksek Lisans", "Doktora"]
              .map((e) => MultiSelectItem(e, e))
              .toList(),
          initialValue: secilenCinsiyet,
          initialChildSize: 0.4,
          title: Text("Cinsiyet Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onConfirm: (values) {
            setState(() {
              secilenOgrenimDurumu = values;
              print("Seçilen Cinsiyet = " + secilenOgrenimDurumu.toString());
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  void _showIliskiDurumu(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: [
            "Hepsi",
            "İlişkisi yok",
            "Nişanlı",
            "Medini birlikteliği var",
            "Birlikte yaşadığı biri var",
            "Serbest ilişkisi var",
            "Karmaşık bir ilişkisi var",
            "Eşinden ayrı",
            "Boşanmış",
            "Dul",
            "Evli"
          ].map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: secilenIliskiDurumlari,
          initialChildSize: 0.4,
          title: Text("İlişki Durumu Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onConfirm: (values) {
            setState(() {
              secilenIliskiDurumlari = values;
              print("Seçilen İlişki durumu = " + secilenIliskiDurumlari.toString());
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  void _showMeslekler(BuildContext context) async {
    var veriJson = await DefaultAssetBundle.of(context).loadString("datalar/etkinlikmeslekler.json");
    var meslekJson = jsonDecode(veriJson)['Meslekler'];
    List<String> tags = meslekJson != null ? List.from(meslekJson) : null;

    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: tags.map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: secilenMeslekler,
          initialChildSize: 0.6,
          searchable: true,
          searchHint: "Ara",
          title: Text("Meslek Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onSelectionChanged: (List<String> values) {
            secilenMeslekler = values;
            setState(() {});
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  void _showIlveIlceListesi(BuildContext context) async {
    var veriJson = await DefaultAssetBundle.of(context).loadString("datalar/etkinlikiller.json");
    var meslekJson = jsonDecode(veriJson)['Iller'];
    List<String> tags = meslekJson != null ? List.from(meslekJson) : null;

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: tags.map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: secilenIlIlceler,
          searchable: true,
          searchHint: "Ara",
          initialChildSize: 0.6,
          title: Text("Konum Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onConfirm: (List<String> values) {
            setState(() {
              if (values.length > 3) {
                values.removeRange(3, values.length);
                Fluttertoast.showToast(
                    msg: "En fazla 3 kategori seçimi yapılabilir!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    textColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    fontSize: 15.0.h);
              }
              secilenIlIlceler = values;
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  void _showEtkinlikKategorisi(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: kafalarList.map((e) => MultiSelectItem(e, e)).toList(),
          initialValue: secilenKafalar,
          searchable: true,
          searchHint: "Ara",
          initialChildSize: 0.6,
          title: Text("Kategori Seç"),
          cancelText: Text("İptal"),
          confirmText: Text("Tamam"),
          onSelectionChanged: (List<String> values) {
            setState(() {
              if (values.length > 5) {
                values.removeRange(5, values.length);
                Fluttertoast.showToast(
                    msg: "En fazla 5 kategori seçimi yapılabilir!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    textColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    fontSize: 15.0.h);
              }
              secilenKafalar = values;
            });
          },
          onConfirm: (List<String> values) {
            setState(() {
              if (values.length > 5) {
                values.removeRange(5, values.length);
                Fluttertoast.showToast(
                    msg: "En fazla 5 kategori seçimi yapılabilir!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    textColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    fontSize: 15.0.h);
              }
              secilenKafalar = values;
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
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

  Future<String> uploadEtkinlikImage(String id) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_image == null) return "";
    String filePath = _image.path;
    String userId = _userModel.user.userId;
    String fileName = "${userId}-${id}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('etkinlikfotolari/$fileName').putFile(file);
      String downloadURL =
          await firebase_storage.FirebaseStorage.instance.ref('etkinlikfotolari/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  _selectTime(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialTimePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        //daha sonra eklenecek
        return buildCupertinoTimePicker(context);
    }
  }

  buildMaterialTimePicker(BuildContext context) async {
    TimeOfDay secilenSaat = TimeOfDay.now();
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: secilenSaat,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Theme.of(context).primaryColor,
                accentColor: Theme.of(context).accentColor,
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor)),
            child: child,
          );
        });
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
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

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 50),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).primaryColor,
              accentColor: Theme.of(context).accentColor,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor)),
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
              initialDateTime: DateTime.now(),
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 50,
            ),
          );
        });
  }

  buildCupertinoTimePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedTime = TimeOfDay(hour: picked.hour, minute: picked.minute);
//                    print(selectedTime.format(context));
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 50,
            ),
          );
        });
  }

  void resetFields() {
    setState(() {
      _etkinlikTipi = "Standard";

      baslikController.text = "";
      aciklamaController.text = "";
      konumController.text = "";
      kacKisiController.text = "";

      secilmisKonumAdres = "";
      secilmisKonumName = "";

      _image = null;

      selectedTime = null;
      selectedDate = null;

      secilenKafalar.clear();
      secilenCinsiyet.clear();
      secilenIliskiDurumlari.clear();
      secilenMeslekler.clear();
      secilenYas.clear();
      etkinlikozelKatilimci.clear();
      etkinlikozelKatilimciidler.clear();
      _katilimci = Katilimci.Herkes;
    });
  }

  @override
  void dispose() {
    baslikController.dispose();
    aciklamaController.dispose();
    konumController.dispose();
    kacKisiController.dispose();
    super.dispose();
  }
}
