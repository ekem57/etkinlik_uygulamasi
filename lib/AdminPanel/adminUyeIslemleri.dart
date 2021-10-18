import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/UyeIslemleri/uye_islemleri_floating_action_button.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/adminuyeprofilsayfasi.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/adminyoneticiprofilsayfasi.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminYoneticiAta.dart';
import 'package:etkinlik_kafasi/AdminPanel/temsilciAta.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AdminUyeIslemleri extends StatefulWidget {
  @override
  _AdminUyeIslemleriState createState() => _AdminUyeIslemleriState();
}

class _AdminUyeIslemleriState extends State<AdminUyeIslemleri> with SingleTickerProviderStateMixin {
  TabController _tabController;
  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();

  List secilenCinsiyet = [];
  List secilenYas = [];
  List secilenMeslekler = [];
  final aciklamaController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

  String _filtreCinsiyet = "yok";
  String _filtreYas = "yok";
  String _filtreSehir = "yok";
  String _filtreMeslek = "yok";

  List<String> _items = ['Erkek', 'Kadın'];
  List<String> _itemsSehir = ['İstanbul', 'Ankara', 'Muğla', 'Konya', 'Sinop', 'Trabzon', 'Yozgat'];
  List<String> _itemsMeslek = ['İstanbul', 'Ankara', 'Muğla', 'Konya', 'Sinop', 'Trabzon', 'Yozgat'];
  List<String> _itemsYas = ['18-25', '25-30', '30-40', '40-60','60-99'];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        print("Tab Index ${_tabController.index}");
      });
    });
    meslekList().then((value) {
      _itemsMeslek = value;
    });
    sehirList().then((value) {
      _itemsSehir = value;
    });
  }

  Future<List<String>> meslekList() async {
    var veriJson = await DefaultAssetBundle.of(context).loadString("datalar/meslekler.json");
    var meslekJson = jsonDecode(veriJson)['Meslekler'];
    List<String> tags = meslekJson != null ? List.from(meslekJson) : null;
    return tags;
  }

  Future<List<String>> sehirList() async {
    var veriJson = await DefaultAssetBundle.of(context).loadString("datalar/il.json");
    var sehirJson = jsonDecode(veriJson)[0]['Iller'];
    List<String> tags = sehirJson != null ? List.from(sehirJson) : null;
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    return Scaffold(
      floatingActionButton:
          MyFloatingButton(tabController: _tabController, pushableScreens: [AdminYoneticiAta(), TemsilciAta()]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Renkler.backGroundColor,
      appBar: buildAppBar(context, "Üye İşlemleri"),
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: const Color(0xff343633),
                  labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0.spByWidth),
                  labelColor: Theme.of(context).primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Theme.of(context).buttonColor,
                  onTap: (int index) {
                    setState(() {});
                  },
                  tabs: [
                    Tab(child: Text("Yöneticiler")),
                    Tab(child: Text("Temsilciler")),
                    Tab(child: Text("Üyeler")),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    //1. Tab View
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('yonetici').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final int cardLength2 = snapshot.data.docs.length;

                        return ListView.builder(
                          itemCount: cardLength2,
                          itemBuilder: (_, int index) {
                            final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("userId", isEqualTo: _cardYonetici['userId'])
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final int cardLength = snapshot.data.docs.length;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cardLength,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card = snapshot.data.docs[index];
                                    print("Üye işlemleri _card: " + _card.data().toString());
                                    return   Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.45,
                                      child:ResimliCard(
                                          textSubtitle: null,
                                          textTitle: _card['ad'].toString(),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AdminKarsiKullaniciProfiliYonetici(
                                                    card: _card.data(),
                                                  )),
                                            );
                                          },
                                          fontSize: 12,
                                          img: _card['avatarImageUrl'].toString(),
                                          tarih: null),
                                      secondaryActions: <Widget>[

                                        Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20.70)),

                                          ),
                                          child: IconSlideAction(
                                              caption: 'Sil',
                                              color: Colors.red,
                                              icon: Icons.delete,
                                              onTap: () async {
                                                await _adminIslemleri.adminYoneticiGorevdenAl(_cardYonetici);
                                                setState(() {

                                                });
                                              }
                                          ),
                                        ),
                                      ],
                                    );

                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    //2. Tab View
                    _userModel.user.yoneticiyetkileri.temsilci_atama
                        ? StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('temsilciler').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final int cardLength2 = snapshot.data.docs.length;

                              return ListView.builder(
                                itemCount: cardLength2,
                                itemBuilder: (_, int index) {
                                  final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
                                  return StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .where("userId", isEqualTo: _cardYonetici['userId'])
                                        .snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      final int cardLength = snapshot.data.docs.length;

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: cardLength,
                                        itemBuilder: (_, int index) {
                                          final DocumentSnapshot _card = snapshot.data.docs[index];
                                          print(cardLength);
                                          return   Slidable(
                                            actionPane: SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.45,
                                            child:ResimliCard(
                                                textSubtitle: null,
                                                textTitle: _card['ad'].toString(),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => AdminUyeKullaniciProfili(
                                                          card: _card.data(),
                                                        )),
                                                  );
                                                },
                                                fontSize: 12,
                                                img: _card['avatarImageUrl'].toString(),
                                                tarih: null),
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
                                                      await _adminIslemleri.adminTemsilciGorevdenAl(_cardYonetici);
                                                      setState(() {

                                                      });
                                                    }
                                                ),
                                              ),
                                            ],
                                          );

                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text(
                            "Buraya Erişiminiz Yoktur.",
                            style: TextStyle(fontSize: 20.0.spByWidth, fontWeight: FontWeight.bold),
                          )),
                    //3. Tab View
                    _userModel.user.yoneticiyetkileri.uye_islemleri
                        ? ListView(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: ListTile(
                                          title: Text(_filtreCinsiyet == "yok" ? "Cinsiyet" : _filtreCinsiyet,
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.0.spByWidth),
                                              textAlign: TextAlign.left),
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {
                                            _showCinsiyetFilter(context);
                                          },
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Theme.of(context).primaryColor,
                                            size: 16.0.h,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150.0.w,
                                        child: Divider(
                                          height: 3.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 150.0.w,
                                        child: ListTile(
                                          title: Text(_filtreYas == "yok" ? "Yaş" : _filtreYas.toString(),
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.0.spByWidth),
                                              textAlign: TextAlign.left),
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {
                                            _showYasFilter(context);
                                          },
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Theme.of(context).primaryColor,
                                            size: 16.0.h,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150.0.w,
                                        child: Divider(
                                          height: 3.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 150.0.w,
                                        child: ListTile(
                                          title: Text(_filtreSehir == "yok" ? "Şehir" : _filtreSehir.toString(),
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.0.spByWidth),
                                              textAlign: TextAlign.left),
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {
                                            _showSehirFilter(context);
                                          },
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Theme.of(context).primaryColor,
                                            size: 16.0.h,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150.0.w,
                                        child: Divider(
                                          height: 3.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 150.0.w,
                                        child: ListTile(
                                          title: Text(_filtreMeslek == "yok" ? "Meslek" : _filtreMeslek.toString(),
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.0.spByWidth),
                                              textAlign: TextAlign.left),
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {
                                            _showMeslekFilter(context);
                                          },
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Theme.of(context).primaryColor,
                                            size: 16.0.h,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150.0.w,
                                        child: Divider(
                                          height: 3.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 8.0.h),
                                child: Container(
                                  child: RaisedButton.icon(
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      setState(() {
                                        _filtreCinsiyet = "yok";
                                        _filtreYas = "yok";
                                        _filtreSehir = "yok";
                                        _filtreMeslek = "yok";
                                      });
                                    },
                                    label: Text(
                                      "Filtreleri Temizle",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder<QuerySnapshot>(
                                future: filtrelistream(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  final int cardLength = snapshot.data.docs.length;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cardLength,
                                    itemBuilder: (_, int index) {
                                      final DocumentSnapshot _card = snapshot.data.docs[index];

                                      return ResimliCard(
                                          textSubtitle: null,
                                          textTitle: _card['ad'].toString(),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminUyeKullaniciProfili(
                                                          card: _card.data(),
                                                        )));
                                          },
                                          fontSize: 12,
                                          img: _card['avatarImageUrl'].toString(),
                                          tarih: null);
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 40.0.h,
                              ),
                            ],
                          )
                        : Center(
                            child: Text(
                            "Buraya Erişiminiz Yoktur.",
                            style: TextStyle(fontSize: 20.0.spByWidth, fontWeight: FontWeight.bold),
                          )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, String title, {List<Widget> actions = const []}) {
    return AppBar(
      backgroundColor: Renkler.appbarGroundColor,
      elevation: 0,
      iconTheme: new IconThemeData(color: Colors.black),
      title: Text(title,
          style: TextStyle(
              color: Renkler.appbarTextColor,
              fontWeight: FontWeight.w700,
              fontFamily: "OpenSans",
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
          textAlign: TextAlign.center),
      actions: actions,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Renkler.appbarIconColor, size: 20.0.w),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  Future<QuerySnapshot> filtrelistream() async {
    print("meslek : " + _filtreMeslek);
    print("yas : " + _filtreYas);
    print("sehir : " + _filtreSehir);
    print("cinsiyet : " + _filtreCinsiyet);

    if (_filtreMeslek != "yok" && _filtreYas != "yok" && _filtreSehir != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 1 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('sehir', isEqualTo: _filtreSehir)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .where('meslek', isEqualTo: _filtreMeslek)
          .get();
      return qn;
    }
    // 4(1) li kombinasyonu=4
    else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir == "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 2 e geldi");
      QuerySnapshot qn = await _firestore.collection("users").where('meslek', isEqualTo: _filtreMeslek).get();
      return qn;
    } else if (_filtreMeslek == "yok" && _filtreYas != "yok" && _filtreSehir == "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 2 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .get();
      return qn;
    } else if (_filtreMeslek == "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 3 e geldi");
      QuerySnapshot qn = await _firestore.collection("users").where('sehir', isEqualTo: _filtreSehir).get();
      return qn;
    } else if (_filtreMeslek == "yok" && _filtreYas == "yok" && _filtreSehir == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 4 e geldi");
      QuerySnapshot qn =
          await _firestore.collection("users").where('cinsiyet', isEqualTo: _filtreCinsiyet).get();
      return qn;
    }
    // 4(2) li kombinasyonu=6
    else if (_filtreMeslek != "yok" && _filtreYas != "yok" && _filtreSehir == "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 4 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('meslek', isEqualTo: _filtreMeslek)
          .get();
      return qn;
    } else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 5 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('meslek', isEqualTo: _filtreMeslek)
          .where('sehir', isEqualTo: _filtreSehir)
          .get();
      return qn;
    } else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 6 e geldi");
      print("Filtre: meslek:"+_filtreMeslek);
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('meslek', isEqualTo: _filtreMeslek)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreMeslek == "yok" && _filtreYas != "yok" && _filtreSehir == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 6 e geldi 2");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreMeslek == "yok" && _filtreYas != "yok" && _filtreSehir != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 7 e geldi" + _filtreSehir);
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('sehir', isEqualTo: _filtreSehir)
          .get();
      return qn;
    } else if (_filtreMeslek == "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 8 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('sehir', isEqualTo: _filtreSehir)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    }

    //4(3) lü kombinasyonu=4
    else if (_filtreMeslek == "yok" && _filtreYas != "yok" && _filtreSehir != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 9 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('sehir', isEqualTo: _filtreSehir)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 10 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('sehir', isEqualTo: _filtreSehir)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .where('meslek', isEqualTo: _filtreMeslek)
          .get();
      return qn;
    } else if (_filtreMeslek != "yok" && _filtreYas != "yok" && _filtreSehir == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 11 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('meslek', isEqualTo: _filtreMeslek)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();
      return qn;
    } else if (_filtreMeslek != "yok" && _filtreYas != "yok" && _filtreSehir != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 12 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
              isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
              isGreaterThanOrEqualTo:
                  DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('sehir', isEqualTo: _filtreSehir)
          .where('meslek', isEqualTo: _filtreMeslek)
          .get();
      return qn;
    } else {
      print("Filtre: 13 e geldi");
      QuerySnapshot qn = await _firestore.collection("users").orderBy('ad').get();
      return qn;
    }
  }

  void _showCinsiyetFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 180,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  _items[index].toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _filtreCinsiyet = _items[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreCinsiyet = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showSehirFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 600.0.h,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _itemsSehir.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 30.0.w),
                            child: Row(
                              children: [
                                Text(
                                  _itemsSehir[index].toString(),
                                  style: TextStyle(fontSize: 17.0.spByWidth),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _filtreSehir = _itemsSehir[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreSehir = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showMeslekFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 600,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _itemsMeslek.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  _itemsMeslek[index].toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _filtreMeslek = _itemsMeslek[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreMeslek = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showYasFilter(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 280,
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _itemsYas.length,
                    separatorBuilder: (context, int) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  _itemsYas[index].toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print("on tap");
                            setState(() {
                              _filtreYas = _itemsYas[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text("Kapat"),
                    onTap: () {
                      setState(() {
                        _filtreYas = "yok";
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
