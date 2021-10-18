import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/etkinlikler/etkinlik_detay.dart';
import 'package:etkinlik_kafasi/etkinlikler/turnuva/eslesmeSayfasi.dart';
import 'package:etkinlik_kafasi/etkinlikler/turnuva/katilimcilar.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class EtkinlikCard extends StatefulWidget {
  final EtkinlikModel etkinlikBilgileri;
  final DocumentSnapshot card;
  int kalanGun;
  int kalanSaat;
  int kalanDakika;
  int kalanSaniye;

  EtkinlikCard({
    Key key,
    @required this.etkinlikBilgileri,
    @required this.card,
    this.kalanGun,
    this.kalanSaat,
    this.kalanDakika,
    this.kalanSaniye,
  }) : super(key: key);

  @override
  _EtkinlikCardState createState() => _EtkinlikCardState();
}

FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _EtkinlikCardState extends State<EtkinlikCard> {
  String kategoriyas = "";
  List<dynamic> kategorimeslek = [];
  List<dynamic> kategoriil = [];
  List<dynamic> kategoriiliskidurumu = [];
  List<dynamic> kategoricinsiyet = [];
  QuerySnapshot katilimcilarQuerySnapshot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.card["cinsiyet"].toString() == "[]" ? kategoricinsiyet = List<String>.from(widget.card["cinsiyet"]) : [];
    widget.card["il"].toString() == "[]" ? kategoriil = List<String>.from(widget.card["il"]) : [];
    widget.card["iliskidurumu"].toString() == "[]"
        ? kategoriiliskidurumu = List<String>.from(widget.card["iliskidurumu"])
        : [];
    widget.card["meslek"].toString() == "[]" ? kategorimeslek = List<String>.from(widget.card["meslek"]) : [];
  }

  @override
  Widget build(BuildContext context) {
    var tarih = widget.etkinlikBilgileri.tarih;
    var saat = widget.etkinlikBilgileri.saat;
    var hour = int.parse(saat.split(":")[0]);
    var min = int.parse(saat.split(":")[1]);
    TimeOfDay time = TimeOfDay(hour: hour, minute: min);

    var etkinlikTime = DateTime(tarih.year, tarih.month, tarih.day, time.hour, time.minute);
    widget.kalanGun = etkinlikTime.difference(DateTime.now()).inDays;
    widget.kalanSaat = etkinlikTime.difference(DateTime.now()).inHours.remainder(24);
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => EtkinlikDetay(
              etkinlikBilgileri: widget.etkinlikBilgileri,
              card: widget.card,
            ),
          ),
        );
      },
      child: Container(
        width: 312.3.w,
        height: MediaQuery.of(context).size.height * 0.7,
        //313.0.h,
        margin: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 10.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(11.70.w),
          ),
          boxShadow: [
            BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Stack(children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.etkinlikBilgileri.etkinlikFoto),
                        alignment: Alignment.topCenter),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(11.70.w),
                      topLeft: Radius.circular(11.70.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 2),
                        blurRadius: 22.70,
                        spreadRadius: 0,
                      ),
                    ],
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.65,
                                child: Container(
                                  width: 62.666666666666664.w,
                                  height: 22.666666666666668.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(6.70)),
                                      color: Theme.of(context).backgroundColor),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                                    child: Icon(Icons.supervisor_account, size: 18.0.h),
                                  ),
                                  Text(widget.etkinlikBilgileri.katilimci.toString(),
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.7.spByWidth),
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ],
                            alignment: Alignment.centerLeft,
                          ),
                          top: 12.30.h,
                          left: 13.30.w),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: 0.4,
                          child: Container(
                              width: 256.0.w,
                              height: 71.0.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(6.70)),
                                  color: const Color(0xff000000))),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 256.0.w / 4,
                                child: Text("Gün",
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: 256.0.w / 4,
                                child: Text("Saat",
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 256.0.w / 8,
                                child: Text(NumberFormat("00").format(widget.kalanGun),
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: 256.0.w / 8,
                                child: Text(":",
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: 256.0.w / 8,
                                child: Text(NumberFormat("00").format(widget.kalanSaat),
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0.spByWidth),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 9.30.w),
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Padding(
                            padding: EdgeInsets.only(left: 6.0.w, right: 60.0.w),
                            child: Text(
                              widget.etkinlikBilgileri.baslik,
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.3.spByWidth),
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).buttonColor,
                                  size: 25.0.h,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.etkinlikBilgileri.konum.replaceAll(RegExp("\n"), " "),
                                    style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.3.spByWidth,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(
                                    Icons.person,
                                    color: Theme.of(context).primaryColor,
                                    size: 25.0.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.0.w),
                                    child: Text(
                                      widget.etkinlikBilgileri.yayinlayanAdSoyad.toString().toUpperCase(),
                                      style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.3.spByWidth,
                                      ),
//                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ]),
                                GestureDetector(
                                  onTap: ()async{
                                    if (context.read<UserModel>().user.uyelikTipi != "gold") {
                                      var dialogBilgi = AlertBilgilendirme(
                                        message: "Katılımcı listesi sadece Gold  üyeler tarafından görüntülenebilir!",
                                        onPostivePressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                      showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                      return;
                                    }
                                    await getEventDetails();
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (c) => Katilimcilar(
                                          qn: katilimcilarQuerySnapshot,
                                        )));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 3.0.w),
                                    child: Text(
                                      "Katılımcılar",
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.3.spByWidth
                                      ),
                                       textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0.h,
                                  child: Stack(
                                      children: List.generate(
                                          5,
                                              (index) => Positioned(
                                            left: 21.0 * index,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://firebasestorage.googleapis.com/v0/b/etkinlik-kafasi-40b44.appspot.com/o/etkinlik_kafasi_genel_fotograflar%2Flogo.jpeg?alt=media&token=6400947d-e882-4607-ae3e-1fb5c89aabc3"),
                                              radius: 20.0.w,
                                            ),
                                          ))),
                                ),
                                Expanded(
                                  child: Row(
                                      children: []..addAll(widget.etkinlikBilgileri.kategori
                                          .map(
                                            (e) => Padding(
                                                padding: EdgeInsets.only(left: 3.0.w),
                                                child: Image.asset(
                                                  "assets/kafalar/" + convertAssetName(e),
                                                  width: 25.0.w,
                                                  height: 25.0.h,
                                                  fit: BoxFit.contain,
                                                )),
                                          )
                                          .cast<Widget>()
                                          .toList()
                                            ..addAll([
                                              Spacer(),
                                              StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore.instance
                                                      .collection("usersEtkinlikFavori")
                                                      .doc(_userModel.user.userId)
                                                      .collection("katilimci")
                                                      .where('etid', isEqualTo: widget.etkinlikBilgileri.etid)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (!snapshot.hasData) return Container();

                                                    return snapshot.data.docs.toString() == "[]"
                                                        ? IconButton(
                                                            onPressed: () {
                                                              _firestoreDBService.etkinlikFavla(
                                                                  _userModel.user.userId, widget.card['etid']);
                                                            },
                                                            icon: Icon(
                                                              Icons.favorite_border,
                                                              color: Colors.grey,
                                                              size: 25.0.h,
                                                            ),
                                                          )
                                                        : snapshot.data.docs[0]['onay'] == true
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  _firestoreDBService.etkinlikFavdanCik(
                                                                      _userModel.user.userId, widget.card['etid']);
                                                                },
                                                                icon: Icon(
                                                                  Icons.favorite,
                                                                  color: Colors.red,
                                                                  size: 25.0.h,
                                                                ),
                                                              )
                                                            : IconButton(
                                                                onPressed: () {
                                                                  _firestoreDBService.etkinlikFavla(
                                                                      _userModel.user.userId, widget.card['etid']);
                                                                },
                                                                icon: Icon(
                                                                  Icons.favorite_border_sharp,
                                                                  color: Colors.grey,
                                                                  size: 25.0.h,
                                                                ),
                                                              );
                                                  }),
                                              IconButton(
                                                  onPressed: () {
                                                    _onShare(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.share_sharp,
                                                    size: 25.0.h,
                                                  )),
                                            ]))),
                                ),
                                SizedBox(
                                  height: 10.0.h,
                                ),
                                widget.card['etkinlikTipi'] != "Turnuva"
                                    ? _userModel.user.userId != widget.etkinlikBilgileri.userId
                                        ? StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("usersEtkinlik")
                                                .doc(_userModel.user.userId)
                                                .collection("katilimci")
                                                .where('etid', isEqualTo: widget.etkinlikBilgileri.etid)
                                                .snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData) return Container();

                                              return snapshot.data.docs.toString() == "[]"
                                                  ? Padding(
                                                      padding: EdgeInsets.only(bottom: 5.0.h),
                                                      child: MyButton(
                                                        text: "Katıl",
                                                        textColor: Colors.black,
                                                        fontSize: 18.7.spByWidth,
                                                        width: MediaQuery.of(context).size.width,
                                                        height: 35.6.h,
                                                        butonColor: Theme.of(context).buttonColor,
                                                        onPressed: () {
                                                          kategoriyas = widget.card["yasaraligi"];
                                                          kategoricinsiyet = List<String>.from(widget.card["cinsiyet"]);
                                                          kategoriil = List<String>.from(widget.card["il"]);
                                                          kategoriiliskidurumu =
                                                              List<String>.from(widget.card["iliskidurumu"]);
                                                          kategorimeslek = List<String>.from(widget.card["meslek"]);

                                                          if (kategoricinsiyet.isEmpty &&
                                                              kategoriil.isEmpty &&
                                                              kategorimeslek.isEmpty &&
                                                              kategoriiliskidurumu.isEmpty &&
                                                              kategoriyas.isEmpty) {
                                                            if (_userModel.user.userId ==
                                                                widget.etkinlikBilgileri.userId) {
                                                              var dialogBilgi = AlertBilgilendirme(
                                                                message: "Kendi etkinliğinize katılamazsınız.",
                                                                onPostivePressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              );

                                                              showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) => dialogBilgi);
                                                            } else {
                                                              if (_userModel.user.uyelikTipi == "standart") {
                                                                if (_userModel.user.katilinanetkinliksayim >= 5) {
                                                                  var dialogBilgi = AlertBilgilendirme(
                                                                    message:
                                                                        "Standart Paketde haftalık en fazla 5 etkinliğe katılabilirsiniz.",
                                                                    onPostivePressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                  );

                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) => dialogBilgi);
                                                                } else {
                                                                  _firestoreDBService.etkinlikKatilmaIstegiButonu(
                                                                      widget.card,
                                                                      _userModel.user.userId,
                                                                      _userModel.user.adsoyad);

                                                                   // FirebaseFirestore.instance
                                                                   //    .collection("users")
                                                                   //    .doc(_userModel.user.userId)
                                                                   //    .collection("katilim")
                                                                   //    .add({"etid": widget.etkinlikBilgileri.etid});
                                                                   FirebaseFirestore.instance
                                                                      .collection("users")
                                                                      .doc(_userModel.user.userId)
                                                                      .update({
                                                                    'katilinanetkinliksayisi': FieldValue.increment(1)
                                                                  });
                                                                }
                                                              } else if (_userModel.user.uyelikTipi == "plus") {
                                                                if (_userModel.user.katilinanetkinliksayim > 20) {
                                                                  var dialogBilgi = AlertBilgilendirme(
                                                                    message:
                                                                        "Plus Paketde haftalık en fazla 20 etkinliğe katılabilirsiniz.",
                                                                    onPostivePressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                  );

                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) => dialogBilgi);
                                                                } else {
                                                                  _firestoreDBService.etkinlikKatilmaIstegiButonu(
                                                                      widget.card,
                                                                      _userModel.user.userId,
                                                                      _userModel.user.adsoyad);
                                                                  FirebaseFirestore.instance
                                                                      .collection("users")
                                                                      .doc(_userModel.user.userId)
                                                                      .update({
                                                                    'katilinanetkinliksayisi': FieldValue.increment(1)
                                                                  });
                                                                }
                                                              } else {
                                                                _firestoreDBService.etkinlikKatilmaIstegiButonu(
                                                                    widget.card,
                                                                    _userModel.user.userId,
                                                                    _userModel.user.adsoyad);
                                                              }
                                                            }
                                                          } else if (kategoricinsiyet
                                                                      .indexOf(_userModel.user.cinsiyet) ==
                                                                  -1 &&
                                                              kategoricinsiyet.isNotEmpty) {
                                                            var dialogBilgi = AlertBilgilendirme(
                                                              message: _userModel.user.cinsiyet +
                                                                  "  cinsiyetindekiler bu etkinliğe katılamaz.",
                                                              onPostivePressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                            );

                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => dialogBilgi);
                                                          } else if (kategoriil.indexOf(_userModel.user.sehir) == -1 &&
                                                              kategoriil.isNotEmpty) {
                                                            print("gelen il kategorisi: " + kategoriil.toString());
                                                            var dialogBilgi = AlertBilgilendirme(
                                                              message: _userModel.user.sehir +
                                                                  "  ikamet edenler bu etkinliğe katılamaz.",
                                                              onPostivePressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                            );

                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => dialogBilgi);
                                                          } else if (kategorimeslek.indexOf(_userModel.user.meslek) ==
                                                                  -1 &&
                                                              kategorimeslek.isNotEmpty) {
                                                            var dialogBilgi = AlertBilgilendirme(
                                                              message: " Mesleği " +
                                                                  _userModel.user.meslek +
                                                                  " olanlar bu etkinliğe katılamaz.",
                                                              onPostivePressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                            );

                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => dialogBilgi);
                                                          } else if (kategoriiliskidurumu
                                                                      .indexOf(_userModel.user.iliskiDurumu) ==
                                                                  -1 &&
                                                              kategoriiliskidurumu.isNotEmpty) {
                                                            var dialogBilgi = AlertBilgilendirme(
                                                              message: " İlişki durumu " +
                                                                  _userModel.user.iliskiDurumu +
                                                                  " olanlar bu etkinliğe katılamaz.",
                                                              onPostivePressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                            );

                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => dialogBilgi);
                                                          } else if (kategoriyas.isNotEmpty &&
                                                              int.parse(kategoriyas.toString().substring(0, 2)) >=
                                                                  _userModel.user.yas) {
                                                            var dialogBilgi = AlertBilgilendirme(
                                                              message: "Bu etklinliğe katılmak için  " +
                                                                  kategoriyas +
                                                                  " yaş aralığında olunmalıdır.",
                                                              onPostivePressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                            );

                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => dialogBilgi);
                                                          } else if (kategoriyas.isNotEmpty &&
                                                              int.parse(kategoriyas.toString().substring(3, 5)) <=
                                                                  _userModel.user.yas) {
                                                            var dialogBilgi = AlertBilgilendirme(
                                                              message: " Bu etklinliğe katılmak için  " +
                                                                  kategoriyas +
                                                                  " yaş aralığında olunmalıdır.",
                                                              onPostivePressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                            );

                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => dialogBilgi);
                                                          } else {
                                                            if (_userModel.user.userId ==
                                                                widget.etkinlikBilgileri.userId) {
                                                              var dialogBilgi = AlertBilgilendirme(
                                                                message: "Kendi etkinliğinize katılamazsınız.",
                                                                onPostivePressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              );

                                                              showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) => dialogBilgi);
                                                            } else {
                                                              if (_userModel.user.uyelikTipi == "standart") {
                                                                if (_userModel.user.acilanetkinliksayim > 3) {
                                                                  var dialogBilgi = AlertBilgilendirme(
                                                                    message:
                                                                        "Standart Paketde haftalık en fazla 3 etkinliğe katılabilirsiniz.",
                                                                    onPostivePressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                  );

                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) => dialogBilgi);
                                                                } else {
                                                                  _firestoreDBService.etkinlikKatilmaIstegiButonu(
                                                                      widget.card,
                                                                      _userModel.user.userId,
                                                                      _userModel.user.adsoyad);
                                                                  FirebaseFirestore.instance
                                                                      .collection("users")
                                                                      .doc(_userModel.user.userId)
                                                                      .update({
                                                                    'katilinanetkinliksayisi': FieldValue.increment(1)
                                                                  });
                                                                }
                                                              } else if (_userModel.user.uyelikTipi == "plus") {
                                                                if (_userModel.user.acilanetkinliksayim > 7) {
                                                                  var dialogBilgi = AlertBilgilendirme(
                                                                    message:
                                                                        "Plus Paketde haftalık en fazla 7 etkinliğe katılabilirsiniz.",
                                                                    onPostivePressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                  );

                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) => dialogBilgi);
                                                                } else {
                                                                  _firestoreDBService.etkinlikKatilmaIstegiButonu(
                                                                      widget.card,
                                                                      _userModel.user.userId,
                                                                      _userModel.user.adsoyad);
                                                                  FirebaseFirestore.instance
                                                                      .collection("users")
                                                                      .doc(_userModel.user.userId)
                                                                      .update({
                                                                    'katilinanetkinliksayisi': FieldValue.increment(1)
                                                                  });
                                                                }
                                                              } else {
                                                                _firestoreDBService.etkinlikKatilmaIstegiButonu(
                                                                    widget.card,
                                                                    _userModel.user.userId,
                                                                    _userModel.user.adsoyad);
                                                              }
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  : snapshot.data.docs[0]['onay'].toString() == "katildi"
                                                      ? Padding(
                                                          padding: EdgeInsets.only(bottom: 5.0.h),
                                                          child: MyButton(
                                                            text: "Katıldınız",
                                                            textColor: Colors.black,
                                                            fontSize: 18.7.spByWidth,
                                                            width: MediaQuery.of(context).size.width,
                                                            height: 35.6.h,
                                                            butonColor: Colors.orange,
                                                            onPressed: () {},
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding: EdgeInsets.only(bottom: 5.0.h),
                                                          child: MyButton(
                                                            text: "Katılmaktan Vazgeç",
                                                            textColor: Colors.black,
                                                            fontSize: 18.7.spByWidth,
                                                            width: MediaQuery.of(context).size.width,
                                                            height: 35.6.h,
                                                            butonColor: Renkler.reddetButonColor,
                                                            onPressed: () {
                                                              final tarih = widget.card['tarih'].toDate();
                                                              final simdi = DateTime.now();
                                                              final difference = tarih.difference(simdi).inHours;
                                                              if (difference < 3) {
                                                                var dialogBilgi = AlertBilgilendirme(
                                                                  message:
                                                                      "Etkinliğe katılmaktan artık vazgeçmezsiniz.",
                                                                  onPostivePressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                );

                                                                showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) => dialogBilgi);
                                                              } else {
                                                                _firestoreDBService.etkinlikKatilmaIstegiVazgecButonu(
                                                                    widget.card, _userModel.user.userId);
                                                              }
                                                            },
                                                          ),
                                                        );
                                            })
                                        : Container()
                                    : Padding(
                                        padding: EdgeInsets.only(bottom: 5.0.h),
                                        child: MyButton(
                                          text: "Turnuvaya Katıl",
                                          textColor: Colors.black,
                                          fontSize: 18.7.spByWidth,
                                          width: MediaQuery.of(context).size.width,
                                          height: 35.6.h,
                                          butonColor: Renkler.onayButonColor,
                                          onPressed: () {
                                            kategoriyas = widget.card["yasaraligi"];
                                            kategoricinsiyet = List<String>.from(widget.card["cinsiyet"]);
                                            kategoriil = List<String>.from(widget.card["il"]);
                                            kategoriiliskidurumu = List<String>.from(widget.card["iliskidurumu"]);
                                            kategorimeslek = List<String>.from(widget.card["meslek"]);

                                            print("yas aralıgı: " + kategoriyas.toString());

                                            if (kategoricinsiyet.isEmpty &&
                                                kategoriil.isEmpty &&
                                                kategorimeslek.isEmpty &&
                                                kategoriiliskidurumu.isEmpty &&
                                                kategoriyas.isEmpty) {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => EslesmeSayfasi(
                                                        card: widget.card,
                                                      )));
                                            } else if (kategoricinsiyet.indexOf(_userModel.user.cinsiyet) == -1 &&
                                                kategoricinsiyet.isNotEmpty) {
                                              var dialogBilgi = AlertBilgilendirme(
                                                message: _userModel.user.cinsiyet +
                                                    "  cinsiyetindekiler bu turnuvaya katılamaz.",
                                                onPostivePressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );

                                              showDialog(
                                                  context: context, builder: (BuildContext context) => dialogBilgi);
                                            } else if (kategoriil.indexOf(_userModel.user.sehir) == -1 &&
                                                kategoriil.isNotEmpty) {
                                              print("gelen il kategorisi: " + kategoriil.toString());
                                              var dialogBilgi = AlertBilgilendirme(
                                                message:
                                                    _userModel.user.sehir + "  ikamet edenler bu turnuvaya katılamaz.",
                                                onPostivePressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );

                                              showDialog(
                                                  context: context, builder: (BuildContext context) => dialogBilgi);
                                            } else if (kategorimeslek.indexOf(_userModel.user.meslek) == -1 &&
                                                kategorimeslek.isNotEmpty) {
                                              var dialogBilgi = AlertBilgilendirme(
                                                message: " Mesleği " +
                                                    _userModel.user.meslek +
                                                    " olanlar bu turnuva katılamaz.",
                                                onPostivePressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );

                                              showDialog(
                                                  context: context, builder: (BuildContext context) => dialogBilgi);
                                            } else if (kategoriiliskidurumu.indexOf(_userModel.user.iliskiDurumu) ==
                                                    -1 &&
                                                kategoriiliskidurumu.isNotEmpty) {
                                              var dialogBilgi = AlertBilgilendirme(
                                                message: " İlişki durumu " +
                                                    _userModel.user.iliskiDurumu +
                                                    " olanlar bu turnuva katılamaz.",
                                                onPostivePressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );

                                              showDialog(
                                                  context: context, builder: (BuildContext context) => dialogBilgi);
                                            } else if (kategoriyas.isNotEmpty &&
                                                int.parse(kategoriyas.toString().substring(0, 2)) >=
                                                    _userModel.user.yas) {
                                              var dialogBilgi = AlertBilgilendirme(
                                                message: "Bu etklinliğe katılmak için  " +
                                                    kategoriyas +
                                                    " yaş aralığında olunmalıdır.",
                                                onPostivePressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );

                                              showDialog(
                                                  context: context, builder: (BuildContext context) => dialogBilgi);
                                            } else if (kategoriyas.isNotEmpty &&
                                                int.parse(kategoriyas.toString().substring(3, 5)) <=
                                                    _userModel.user.yas) {
                                              var dialogBilgi = AlertBilgilendirme(
                                                message: " Bu etklinliğe katılmak için  " +
                                                    kategoriyas +
                                                    " yaş aralığında olunmalıdır.",
                                                onPostivePressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );

                                              showDialog(
                                                  context: context, builder: (BuildContext context) => dialogBilgi);
                                            } else {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => EslesmeSayfasi(
                                                        card: widget.card,
                                                      )));
                                            }
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          )
                        ])),
                  )),
            ],
          ),
          Align(
            alignment: Alignment(1, 0.2),
            child: Container(
              width: 70.66666666666667.w,
              height: 64.33333333333333.h,
              margin: EdgeInsets.only(right: 9.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11.70)),
                boxShadow: [
                  BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 12.70, spreadRadius: 0)
                ],
                color: Theme.of(context).buttonColor,
              ),
              child: Center(
                child: Text(
                    "${widget.etkinlikBilgileri.tarih.day.toString()}\n${formatTheDate(widget.etkinlikBilgileri.tarih, format: DateFormat("MMM", "tr_TR"))}",
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.3.spByWidth),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  String convertAssetName(String kategoriName) {
    var turkish = ['ı', 'ğ', 'İ', 'Ğ', 'ç', 'Ç', 'ş', 'Ş', 'ö', 'Ö', 'ü', 'Ü'];
    var english = ['i', 'g', 'I', 'G', 'c', 'C', 's', 'S', 'o', 'O', 'u', 'U'];

    for (var i = 0; i < turkish.length; i++) {
      kategoriName = kategoriName.toLowerCase().replaceAll(RegExp(turkish[i]), english[i]);
    }
    kategoriName = kategoriName.replaceAll(RegExp(" "), "_");
    kategoriName += ".png";
    return kategoriName;
  }

  _onShare(BuildContext context) async {
    List<String> imagePaths = [];
    String urlfoto = widget.etkinlikBilgileri.etkinlikFoto;

    final response = await http.get(Uri.parse(urlfoto));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);
    print(file.toString());
    final RenderBox box = context.findRenderObject() as RenderBox;
    imagePaths.add(file.path);

    await Share.shareFiles(imagePaths, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }


  Future<bool> getEventDetails() async {
    print("cardId: ${widget.card.id}");
    var futuresResult = await Future.wait([
      FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimcilar").get(),
    ]);
    katilimcilarQuerySnapshot = futuresResult[0];
    return true;
  }
}
