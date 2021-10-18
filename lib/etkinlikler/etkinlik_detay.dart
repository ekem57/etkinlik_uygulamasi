import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/ChattApp/grup_sohbet_page.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/etkinlikler/turnuva/eslesmeSayfasi.dart';
import 'package:etkinlik_kafasi/etkinlikler/turnuva/katilimcilar.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import '../widgets/fullresim.dart';

class EtkinlikDetay extends StatefulWidget {
  final EtkinlikModel etkinlikBilgileri;
  final DocumentSnapshot card;

  const EtkinlikDetay({Key key, this.etkinlikBilgileri, this.card}) : super(key: key);

  @override
  _EtkinlikDetayState createState() => _EtkinlikDetayState();
}

class _EtkinlikDetayState extends State<EtkinlikDetay> {
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  List<DocumentSnapshot> userListe = [];
  DocumentSnapshot etsahibi;
  QuerySnapshot katilimcilarQuerySnapshot;

  //Offset state <-------------------------------------
  double offset = 0.0;
  static final GlobalKey<FormState> _abcKey = GlobalKey<FormState>();
  static String kategoriyas = "";
  static List<dynamic> kategorimeslek = [];
  static List<dynamic> kategoriil = [];
  static List<dynamic> kategoriiliskidurumu = [];
  static List<dynamic> kategoricinsiyet = [];

  @override
  void initState() {
    super.initState();
    etSahibiGetir();
    // getEventDetails();
  }

  Future<void> etSahibiGetir() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(widget.etkinlikBilgileri.userId).get();
    etsahibi = documentSnapshot;
  }

  Future<bool> getEventDetails() async {
    print("cardId: ${widget.card.id}");
    var futuresResult = await Future.wait([
      FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimcilar").get(),
    ]);
    katilimcilarQuerySnapshot = futuresResult[0];
    return true;
  }

  Future<List<String>> userImages() async {
    var users = await FirebaseFirestore.instance
        .collection('etkinlik')
        .doc(widget.card.id)
        .collection("katilimcilar")
        .limit(5)
        .get();
    var userIds = users.docs.map((e) => e.data()["userid"] as String).toList();
    var avatarImageUrls = await FirebaseFirestore.instance.collection('users').where("userId", whereIn: userIds).get();
    return avatarImageUrls.docs.map((e) => e["avatarImageUrl"] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      key: _abcKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              background: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => ImageViewerPage(
                                assetName: widget.etkinlikBilgileri.etkinlikFoto,
                              )),
                    );
                  },
                  child: Image.network(widget.etkinlikBilgileri.etkinlikFoto, fit: BoxFit.fill)),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: const Color(0xffffffff),
                size: 20.0.h,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.7.w),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.65,
                      child: Container(
                        width: 62.666666666666664.w,
                        height: 22.666666666666668.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.70)),
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.supervisor_account,
                            size: 18.0.h,
                            color: Theme.of(context).primaryColor,
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
                    ),
                  ],
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            brightness: Brightness.light,
          ),
          SliverFixedExtentList(
            itemExtent: 500.0.h,
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(left: 15.0.w, top: 20.0.h),
                  child: Column(
                    children: [
                      buildEventTitle(),
                      SizedBox(height: 21.0.h),
                      buildEventOwnerTile(context),
                      SizedBox(height: 15.0.h),
                      buildEventLocationTile(context),
                      SizedBox(height: 15.0.h),
                      buildAvatars(context),
                      SizedBox(height: 15.0.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Etkinlik Açıklaması",
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.7.spByWidth),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 15.0.h),
                      Text(widget.etkinlikBilgileri.hakkinda.toString(),
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w400,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0.spByWidth),
                          textAlign: TextAlign.left),
                      widget.card['etkinlikTipi'] != "Turnuva"
                          ? _userModel.user.userId != widget.etkinlikBilgileri.userId
                              ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                                  child: StreamBuilder<QuerySnapshot>(
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
                                                padding: const EdgeInsets.symmetric(vertical: 40),
                                                child: MyButton(
                                                  text: "Katıl",
                                                  textColor: Colors.black,
                                                  fontSize: 18.7.spByWidth,
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 43.6,
                                                  butonColor: Theme.of(context).buttonColor,
                                                  onPressed: () async {
                                                    var timestamp =widget.card["tarih"] as Timestamp;
                                                    if(DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch).isBefore(DateTime.now()))
                                                      return;
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
                                                      if (_userModel.user.userId == widget.etkinlikBilgileri.userId) {
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
                                                            _firestoreDBService.etkinlikKatilmaIstegiButonu(widget.card,
                                                                _userModel.user.userId, _userModel.user.adsoyad);
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
                                                            _firestoreDBService.etkinlikKatilmaIstegiButonu(widget.card,
                                                                _userModel.user.userId, _userModel.user.adsoyad);
                                                            FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(_userModel.user.userId)
                                                                .update({
                                                              'katilinanetkinliksayisi': FieldValue.increment(1)
                                                            });
                                                          }
                                                        } else {
                                                          _firestoreDBService.etkinlikKatilmaIstegiButonu(widget.card,
                                                              _userModel.user.userId, _userModel.user.adsoyad);
                                                        }
                                                      }
                                                    } else if (kategoricinsiyet.indexOf(_userModel.user.cinsiyet) ==
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
                                                    } else if (kategorimeslek.indexOf(_userModel.user.meslek) == -1 &&
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
                                                      if (_userModel.user.userId == widget.etkinlikBilgileri.userId) {
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
                                                            _firestoreDBService.etkinlikKatilmaIstegiButonu(widget.card,
                                                                _userModel.user.userId, _userModel.user.adsoyad);
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
                                                            _firestoreDBService.etkinlikKatilmaIstegiButonu(widget.card,
                                                                _userModel.user.userId, _userModel.user.adsoyad);
                                                            FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(_userModel.user.userId)
                                                                .update({
                                                              'katilinanetkinliksayisi': FieldValue.increment(1)
                                                            });
                                                          }
                                                        } else {
                                                          _firestoreDBService.etkinlikKatilmaIstegiButonu(widget.card,
                                                              _userModel.user.userId, _userModel.user.adsoyad);
                                                        }
                                                      }
                                                    }
                                                  },
                                                ),
                                              )
                                            : snapshot.data.docs[0]['onay'].toString() == "katildi"
                                                ? Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 40),
                                                    child: MyButton(
                                                      text: "Katıldınız",
                                                      textColor: Colors.black,
                                                      fontSize: 18.7.spByWidth,
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 43.6.h,
                                                      butonColor: Colors.orange,
                                                      onPressed: () {},
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 40.0.h),
                                                    child: MyButton(
                                                      text: "Katılmaktan Vazgeç",
                                                      textColor: Colors.black,
                                                      fontSize: 18.7.spByWidth,
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 43.6.h,
                                                      butonColor: Renkler.reddetButonColor,
                                                      onPressed: () {
                                                        _firestoreDBService.etkinlikKatilmaIstegiVazgecButonu(
                                                            widget.card, _userModel.user.userId);
                                                      },
                                                    ),
                                                  );
                                      }),
                                )
                              : Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.0.h, horizontal: 20.0.w),
                              child: MyButton(
                                text: "Turnuvaya Katıl",
                                textColor: Colors.black,
                                fontSize: 18.7.spByWidth,
                                width: MediaQuery.of(context).size.width,
                                height: 43.6.h,
                                butonColor: Renkler.onayButonColor,
                                onPressed: () {
                                  var timestamp =widget.card["tarih"] as Timestamp;
                                  if(DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch).isBefore(DateTime.now()))
                                    return;
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
                                      message: _userModel.user.cinsiyet + "  cinsiyetindekiler bu turnuvaya katılamaz.",
                                      onPostivePressed: () {
                                        Navigator.pop(context);
                                      },
                                    );

                                    showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                  } else if (kategoriil.indexOf(_userModel.user.sehir) == -1 && kategoriil.isNotEmpty) {
                                    print("gelen il kategorisi: " + kategoriil.toString());
                                    var dialogBilgi = AlertBilgilendirme(
                                      message: _userModel.user.sehir + "  ikamet edenler bu turnuvaya katılamaz.",
                                      onPostivePressed: () {
                                        Navigator.pop(context);
                                      },
                                    );

                                    showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                  } else if (kategorimeslek.indexOf(_userModel.user.meslek) == -1 &&
                                      kategorimeslek.isNotEmpty) {
                                    var dialogBilgi = AlertBilgilendirme(
                                      message: " Mesleği " + _userModel.user.meslek + " olanlar bu turnuva katılamaz.",
                                      onPostivePressed: () {
                                        Navigator.pop(context);
                                      },
                                    );

                                    showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                  } else if (kategoriiliskidurumu.indexOf(_userModel.user.iliskiDurumu) == -1 &&
                                      kategoriiliskidurumu.isNotEmpty) {
                                    var dialogBilgi = AlertBilgilendirme(
                                      message: " İlişki durumu " +
                                          _userModel.user.iliskiDurumu +
                                          " olanlar bu turnuva katılamaz.",
                                      onPostivePressed: () {
                                        Navigator.pop(context);
                                      },
                                    );

                                    showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                  } else if (kategoriyas.isNotEmpty &&
                                      int.parse(kategoriyas.toString().substring(0, 2)) >= _userModel.user.yas) {
                                    var dialogBilgi = AlertBilgilendirme(
                                      message: "Bu etklinliğe katılmak için  " +
                                          kategoriyas.toString() +
                                          " yaş aralığında olunmalıdır.",
                                      onPostivePressed: () {
                                        Navigator.pop(context);
                                      },
                                    );

                                    showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                  } else if (kategoriyas.isNotEmpty &&
                                      int.parse(kategoriyas.toString().substring(3, 5)) <= _userModel.user.yas) {
                                    var dialogBilgi = AlertBilgilendirme(
                                      message: " Bu etklinliğe katılmak için  " +
                                          kategoriyas.toString() +
                                          " yaş aralığında olunmalıdır.",
                                      onPostivePressed: () {
                                        Navigator.pop(context);
                                      },
                                    );

                                    showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                  } else {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EslesmeSayfasi(
                                              card: widget.card,
                                            )));
                                  }
                                },
                              ),
                            ),
                      buildEventChatButton(context, _userModel),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<String>> buildAvatars(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: userImages(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return InkWell(
              onTap: () async {
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
              child: Container(
                height: 50.0.h,
                child: Stack(
                    children: List.generate(
                        snapshot.data.length,
                        (index) => Positioned(
                              left: 21.0 * index,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data[index]),
                                radius: 20.0.w,
                              ),
                            ))),
              ),
            );
          }
          return Container();
        });
  }

  Text buildEventTitle() {
    return Text(
      widget.etkinlikBilgileri.baslik.toString(),
      style: TextStyle(
          color: const Color(0xff343633),
          fontWeight: FontWeight.w800,
          fontFamily: 'OpenSans',
          fontStyle: FontStyle.normal,
          fontSize: 18.3.spByWidth),
      textAlign: TextAlign.left,
    );
  }

  Padding buildEventChatButton(BuildContext context, UserModel _userModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: MyButton(
        text: "Etkinlik Sohbeti",
        textColor: Colors.black,
        fontSize: 18.7.spByWidth,
        width: MediaQuery.of(context).size.width,
        height: 43.6,
        butonColor: Theme.of(context).buttonColor,
        onPressed: () async {
          if (widget.etkinlikBilgileri.userId != _userModel.user.userId) {
            var participant =
                await _firestoreDBService.checkParticipant(widget.etkinlikBilgileri.etid, _userModel.user.userId);
            if (participant == false) {
              Fluttertoast.showToast(
                msg: "Sadece Katılımcılar Sohbeti Görüntüleyebilir!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
              );
              return;
            }
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => GroupChatPage(
                    documentId: widget.etkinlikBilgileri.etid,
                    eventOwnerId: widget.etkinlikBilgileri.userId,
                    deactivatedTime: widget.etkinlikBilgileri.tarih.add(Duration(hours: 12)).millisecondsSinceEpoch,
                  )));
        },
      ),
    );
  }

  Row buildEventLocationTile(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: Theme.of(context).buttonColor,
          size: 20.0.h,
        ),
        SizedBox(
          width: 13.0.w,
        ),
        Expanded(
          child: Text(widget.etkinlikBilgileri.konum.toString(),
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.3.spByWidth),
              textAlign: TextAlign.left),
        ),
      ],
    );
  }

  GestureDetector buildEventOwnerTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => KarsiKullaniciProfili(
                    card: etsahibi.data(),
                  )),
        );
      },
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 20.0.h,
          ),
          SizedBox(
            width: 13.0.w,
          ),
          Text(widget.etkinlikBilgileri.yayinlayanAdSoyad.toString().toUpperCase(),
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.3.spByWidth),
              textAlign: TextAlign.center),
          SizedBox(
            width: 8.0.w,
          ),
          if (etsahibi == null ? false : etsahibi["mavitik"])
            Icon(
              Icons.check,
              color: Colors.blue,
              size: 20.0.h,
            ),
        ],
      ),
    );
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

  Future<bool> checkParticipant(String userId) async {
    // var doc = firebase
  }
}
