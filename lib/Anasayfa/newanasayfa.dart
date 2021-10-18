import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Anasayfa/etkinlik_card.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/profilim/bildirimler.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:provider/provider.dart";

enum StreamType { Search, Kategori, Default }

class NewAnasayfa extends StatefulWidget {
  final Users user;

  NewAnasayfa({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _NewAnasayfaState createState() => _NewAnasayfaState();
}

class _NewAnasayfaState extends State<NewAnasayfa> {
  List<dynamic> kategoriyas = [];
  List<dynamic> kategorimeslek = [];
  List<dynamic> kategoriil = [];
  List<dynamic> kategoriiliskidurumu = [];
  List<dynamic> kategoricinsiyet = [];
  String selectedKafa = "";
  ScrollController _scrollController = ScrollController();
  final TextEditingController etkinlikAraController = TextEditingController();
  List<DocumentSnapshot> reklamlarList = [];
  int toplamreklamsayisi = 0;
  List<int> kelimeler = [];
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int getirilecek = 2;
  StreamType streamType = StreamType.Default;
  int gelen;
  bool _elemanyukle = false;
  int reklamRandomSayisi = 0;
  var rng = new Random();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    reklamgetir().then((value) {
      randomSayiUret(toplamreklamsayisi);
    }).then((value) {
      toplamreklamsayisi != 0 ? reklamgorulmearttir(reklamlarList[kelimeler[reklamRandomSayisi]].id) : null;
    });
  }

  Future<void> randomSayiUret(int kelimesayisi) async {
    kelimeler = new List<int>.generate(kelimesayisi, (int index) => index); // [0, 1, 4]
    kelimeler.shuffle();
    if (mounted) {
      setState(() {});
    }

    print(kelimeler);
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        getirilecek += 2;
        _elemanyukle = true;
        reklamlarList.isNotEmpty ? reklamRandomSayisi = rng.nextInt((reklamlarList.length) - 1) : null;
      });

      if (reklamlarList.isNotEmpty) {
        gelen % 2 == 0 ? reklamgorulmearttir(reklamlarList[kelimeler[0]].id) : null;
      }
    }
  }

  Future<List<DocumentSnapshot>> reklamgetir() async {
    QuerySnapshot qn;
    qn = await FirebaseFirestore.instance.collection("reklamlar").where('il', isEqualTo: widget.user.sehir).get();

    if (qn.docs.isNotEmpty) {
      for (DocumentSnapshot snap in qn.docs) {
        reklamlarList.add(snap);
        toplamreklamsayisi++;
      }
      if (qn.docs.isNotEmpty) {
        reklamlarList.add(qn.docs[0]);
      }
      return qn.docs;
    } else if (qn.docs.isEmpty) {
      qn =
          await FirebaseFirestore.instance.collection("reklamlar").where('meslek', isEqualTo: widget.user.meslek).get();
      if (qn.docs.isNotEmpty) {
        for (DocumentSnapshot snap in qn.docs) {
          reklamlarList.add(snap);
          toplamreklamsayisi++;
        }
        if (qn.docs.isNotEmpty) {
          reklamlarList.add(qn.docs[0]);
        }
        return qn.docs;
      } else if (qn.docs.isEmpty) {
        qn = await FirebaseFirestore.instance
            .collection("reklamlar")
            .where('iliskidurumu', isEqualTo: widget.user.iliskiDurumu)
            .get();
        if (qn.docs.isNotEmpty) {
          for (DocumentSnapshot snap in qn.docs) {
            reklamlarList.add(snap);
            toplamreklamsayisi++;
          }
          if (qn.docs.isNotEmpty) {
            reklamlarList.add(qn.docs[0]);
          }
          return qn.docs;
        } else if (qn.docs.isEmpty) {
          qn = await FirebaseFirestore.instance
              .collection("reklamlar")
              .where('cinsiyet', isEqualTo: widget.user.cinsiyet)
              .get();
          if (qn.docs.isNotEmpty) {
            for (DocumentSnapshot snap in qn.docs) {
              reklamlarList.add(snap);
              toplamreklamsayisi++;
            }
            if (qn.docs.isNotEmpty) {
              reklamlarList.add(qn.docs[0]);
            }
            return qn.docs;
          } else if (qn.docs.isEmpty) {
            qn = await FirebaseFirestore.instance.collection("reklamlar").get();
            for (DocumentSnapshot snap in qn.docs) {
              reklamlarList.add(snap);
              toplamreklamsayisi++;
            }
            if (qn.docs.isNotEmpty) {
              reklamlarList.add(qn.docs[0]);
            }
            return qn.docs;
          }
        }
      }
    }
  }

  Future<void> reklamgorulmearttir(String docid) async {
    await FirebaseFirestore.instance
        .collection("reklamlar")
        .doc(docid)
        .update({'gorulmesayisi': FieldValue.increment(1)});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15.0.w, 8.0.h, 15.0.w, 8.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 20.0.h,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      }),
                  Container(
                    width: 167.0.w,
                    height: 41.666666666666664.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.8.h)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x2b000000), offset: Offset(0, 2), blurRadius: 14.30, spreadRadius: 0)
                        ],
                        color: Theme.of(context).backgroundColor),
                    child: TextFormField(
//                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: etkinlikAraController,
                      onFieldSubmitted: (value) {
                        setState(() {
                          if (value.isEmpty)
                            streamType = StreamType.Default;
                          else
                            streamType = StreamType.Search;
                        });
                      },
                      textInputAction: TextInputAction.search,
                      style: TextStyle(fontSize: 15.0.spByWidth),
                      decoration: InputDecoration(
                        hintText: "Etkinlik Ara",
                        hintStyle: TextStyle(
                            color: const Color(0xbf343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.italic,
                            fontSize: 15.3.spByWidth),
                        border: InputBorder.none,
                        isDense: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        icon: Padding(
                          padding: EdgeInsets.only(left: 3.0.w),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 18.0.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        size: 20.0.h,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => Bildirimler(),
                          ),
                        );
                      }),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  SizedBox(
                    height: 20.0.h,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.17,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: kafalar.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedKafa == kafalar[index]["title"].replaceAll(RegExp("\n"), " ")) {
                                  selectedKafa = "";
                                  streamType = StreamType.Default;
                                } else {
                                  selectedKafa = kafalar[index]["title"].replaceAll(RegExp("\n"), " ");
                                  streamType = StreamType.Kategori;
                                }
                              });
                            },
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height * 0.13,
                                margin: EdgeInsets.only(right: 8.0.w, left: 15.0.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0x29000000),
                                        offset: Offset(0, 2),
                                        blurRadius: 22.70,
                                        spreadRadius: 0)
                                  ],
                                  color: selectedKafa == kafalar[index]["title"].replaceAll(RegExp("\n"), " ")
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).backgroundColor,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      kafalar[index]["image"],
                                      width: 50.0.w,
                                      height: 45.0.h,
                                      fit: BoxFit.contain,
                                    ),
                                    Flexible(
                                      child: Text(
                                        kafalar[index]["title"],
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10.0.h),
                                        // overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  //TODO Etkinlik içinde yönetici field ne işe yarıyor? İptal edilecek...
                  StreamBuilder<QuerySnapshot>(
                    stream: selectStreamYonetici(streamType),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center();
                      } else {
                        _elemanyukle = false;
                      }
                      final int cardLength = snapshot.data.docs.length;
                      gelen = cardLength;

                      return cardLength == 0
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cardLength,
                              itemBuilder: (_, int index) {
                                final DocumentSnapshot _card = snapshot.data.docs[index];
                                return Column(
                                  children: [
                                    EtkinlikCard(
                                      etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),
                                      card: _card,
                                    ),

                                    reklamlarList.isNotEmpty
                                        ? index != 0 && index % 2 == 0
                                            ? GestureDetector(
                                                onTap: () async {
                                                  await _launchURL(reklamlarList[kelimeler[0]]['link']);
                                                },
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30.0.w, right: 30.0.w, top: 20, bottom: 20),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(11.70.w),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: const Color(0x29000000),
                                                            offset: Offset(0, 2),
                                                            blurRadius: 22.70,
                                                            spreadRadius: 0)
                                                      ],
                                                      color: Theme.of(context).backgroundColor,
                                                    ),
                                                    child: Column(
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              topRight: Radius.circular(10)),
                                                          child: Container(
                                                            color: Colors.redAccent,
                                                            height: (MediaQuery.of(context).size.height * 25) / 100,
                                                            width: MediaQuery.of(context).size.width,
                                                            child: CachedNetworkImage(
                                                              imageUrl: reklamlarList[kelimeler[0]]['foto'].toString(),
                                                              fit: BoxFit.fill,
                                                              placeholder: (context, url) =>
                                                                  Center(child: CircularProgressIndicator()),
                                                              errorWidget: (context, url, error) => Icon(
                                                                Icons.error,
                                                                color: Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(10)),
                                                          child: Container(
                                                            color: Colors.white,
                                                            height: MediaQuery.of(context).size.height * 0.2,
                                                            width: MediaQuery.of(context).size.width,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 4.0.h,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: 15.0.w, top: 10.0.h),
                                                                  child: Row(
                                                                    children: [
                                                                      Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(
                                                                          reklamlarList[kelimeler[0]]['baslik']
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                            color: const Color(0xff343633),
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: "OpenSans",
                                                                            fontSize: 18.3.spByWidth,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: 15.0.w, right: 7.0.w, top: 10.0.h),
                                                                  child: Text(
                                                                      reklamlarList[kelimeler[0]]['aciklama']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: const Color(0xff343633),
                                                                          fontWeight: FontWeight.w400,
                                                                          fontFamily: "OpenSans",
                                                                          fontStyle: FontStyle.normal,
                                                                          fontSize: 14.0.spByWidth),
                                                                      textAlign: TextAlign.left),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.0.h,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                        : Container(),
                                    // index % 2 == 0 ? Divider() : Container(),
                                  ],
                                );
                              },
                            );
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: selectStream(streamType),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        _elemanyukle = false;
                      }
                      final int cardLength = snapshot.data.docs.length;
                      gelen = cardLength;
                      return cardLength == 0
                          ? Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width,
                              child: Center(child: Text("Etkinlik Yok")),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cardLength,
                              itemBuilder: (_, int index) {
                                final DocumentSnapshot _card = snapshot.data.docs[index];
                                final userId = context.read<UserModel>().user.userId;
                                print("user ıd: $userId");
                                List<String> blockedUsers = List<String>.from(_card["blockedUsers"]);
                                return Column(
                                  children: [
                                    _card['kimKatilabilir'] == 0 || blockedUsers.contains(userId)
                                        ? Container()
                                        : EtkinlikCard(
                                            etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),
                                            card: _card,
                                          ),

                                    reklamlarList.isNotEmpty
                                        ? index != 0 && index % 2 == 0
                                            ? GestureDetector(
                                                onTap: () async {
                                                  await _launchURL(reklamlarList[kelimeler[0]]['link']);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 30.0.w, right: 30.0.w, top: 20.0.h, bottom: 20.0.h),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(11.70.w),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: const Color(0x29000000),
                                                            offset: Offset(0, 2),
                                                            blurRadius: 22.70,
                                                            spreadRadius: 0)
                                                      ],
                                                      color: Theme.of(context).backgroundColor,
                                                    ),
                                                    child: Column(
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              topRight: Radius.circular(10)),
                                                          child: Container(
                                                            color: Colors.redAccent,
                                                            height: (MediaQuery.of(context).size.height * 25) / 100,
                                                            width: MediaQuery.of(context).size.width,
                                                            child: CachedNetworkImage(
                                                              imageUrl: reklamlarList[kelimeler[0]]['foto'].toString(),
                                                              fit: BoxFit.fill,
                                                              placeholder: (context, url) =>
                                                                  Center(child: CircularProgressIndicator()),
                                                              errorWidget: (context, url, error) => Icon(
                                                                Icons.error,
                                                                color: Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(10)),
                                                          child: Container(
                                                            color: Colors.white,
                                                            height: MediaQuery.of(context).size.height * 0.2,
                                                            width: MediaQuery.of(context).size.width,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 4.0.h,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: 15.0.w, top: 10.0.h),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width: 250.0.w,
                                                                        child: Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Text(
                                                                            reklamlarList[kelimeler[0]]['baslik']
                                                                                .toString(),
                                                                            maxLines: 2,
                                                                            overflow: TextOverflow.clip,
                                                                            style: const TextStyle(
                                                                              color: const Color(0xff343633),
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: "OpenSans",
                                                                              fontSize: 18.3,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: 15.0.w, right: 7.0.w, top: 10.0.h),
                                                                  child: Text(
                                                                      reklamlarList[kelimeler[0]]['aciklama']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: const Color(0xff343633),
                                                                          fontWeight: FontWeight.w400,
                                                                          fontFamily: "OpenSans",
                                                                          fontStyle: FontStyle.normal,
                                                                          fontSize: 14.0.spByWidth),
                                                                      textAlign: TextAlign.left),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.0.h,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                        : Container(),
                                    // index % 2 == 0 ? Divider() : Container(),
                                  ],
                                );
                              },
                            );
                    },
                  ),

                  _elemanyukle == false
                      ? SizedBox(
                          height: 5.0.h,
                        )
                      : (gelen + 2) == getirilecek
                          ? Platform.isIOS
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                          : getirilecek > gelen
                              ? Padding(
                                  padding: EdgeInsets.only(top: 20.0.h),
                                  child: Center(
                                      child: Text(
                                    "Daha Fazla Etkinlik Yok",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                                  )),
                                )
                              : Platform.isIOS
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot> selectStreamYonetici(StreamType type) {
    var userId = context.read<UserModel>().user.userId;
    switch (type.index) {
      case 0:
        return filterBySearchYonetici();
      case 1:
        return filterByKafaYonetici();
      default:
        return FirebaseFirestore.instance
            .collection('etkinlik')
            .where("tarih", isGreaterThanOrEqualTo: DateTime.now())
            .where("yonetici", isEqualTo: true)
            .orderBy('tarih', descending: false)
            .limit(getirilecek)
            .snapshots();
    }
  }

  Stream<QuerySnapshot> filterByKafaYonetici() {
    var userId = context.read<UserModel>().user.userId;
    return FirebaseFirestore.instance
        .collection('etkinlik')
        .where("tarih", isGreaterThanOrEqualTo: DateTime.now())
        .where("kategori", arrayContains: selectedKafa)
        .where("yonetici", isEqualTo: true)
        .orderBy('tarih', descending: false)
        .limit(getirilecek)
        .snapshots();
  }

  Stream<QuerySnapshot> filterBySearchYonetici() {
    var userId = context.read<UserModel>().user.userId;
    return FirebaseFirestore.instance
        .collection('etkinlik')
        .where("tarih", isGreaterThanOrEqualTo: DateTime.now())
        .where("yonetici", isEqualTo: true)
        .where("keywords", arrayContains: etkinlikAraController.text.toLowerCase())
        .orderBy('tarih', descending: false)
        .limit(getirilecek)
        .snapshots();
  }

  Stream<QuerySnapshot> selectStream(StreamType type) {
    var userId = context.read<UserModel>().user.userId;
    switch (type.index) {
      case 0:
        return filterBySearch();
      case 1:
        return filterByKafa();
      default:
        return FirebaseFirestore.instance
            .collection('etkinlik')
            .where("tarih", isGreaterThanOrEqualTo: DateTime.now())
            .orderBy('tarih', descending: false)
            .limit(getirilecek)
            .snapshots();
    }
  }

  Stream<QuerySnapshot> filterByKafa() {
    var userId = context.read<UserModel>().user.userId;
    return FirebaseFirestore.instance
        .collection('etkinlik')
        .where("tarih", isGreaterThanOrEqualTo: DateTime.now())
        .where("kategori", arrayContains: selectedKafa)
        .orderBy('tarih', descending: false)
        .limit(getirilecek)
        .snapshots();
  }

  Stream<QuerySnapshot> filterBySearch() {
    var userId = context.read<UserModel>().user.userId;
    return FirebaseFirestore.instance
        .collection('etkinlik')
        .where("tarih", isGreaterThanOrEqualTo: DateTime.now())
        .where("keywords", arrayContains: etkinlikAraController.text.toLowerCase())
        .orderBy('tarih', descending: false)
        .limit(getirilecek)
        .snapshots();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
}
