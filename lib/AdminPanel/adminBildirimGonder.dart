import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class AdminBildirimGonder extends StatefulWidget {
  @override
  _AdminBildirimGonderState createState() => _AdminBildirimGonderState();
}



class _AdminBildirimGonderState extends State<AdminBildirimGonder> {

  List secilenCinsiyet = List();
  List secilenYas = List();
  List secilenMeslekler = List();
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
    // TODO: implement initState
    super.initState();
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
    return Scaffold(
      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.backGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Renkler.appbarIconColor),
        title: Text(
            "Bildirim Gönder",
            style: TextStyle(
                color:  Renkler.appbarTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle:  FontStyle.normal,
                fontSize: 20.0.spByWidth
            ),
            textAlign: TextAlign.center
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
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
          child: ListView(
            children: [
              SizedBox(
                height: 10.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 150.0.w,
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
              SizedBox(
                height: 20.0.h,
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
                padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 8),
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
              SizedBox(
                height: 20.0.w,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0.w),
                child: TextFormField(
                  controller: aciklamaController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 15.0.spByWidth),
                  decoration: InputDecoration(
                    labelText: "Açıklama",
                    labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 20.0.spByWidth),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 50.0.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30.0.w,vertical: 20.0.h),
              child: MyButton(text: "Gönder",
                onPressed: ()async {
                  await filtrelistream();
                  Fluttertoast.showToast(
                      msg: "Bildirim Gönderildi!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      fontSize: 15.0.h);
                },
                textColor: Colors.black,
                fontSize: 17,
                width: MediaQuery.of(context).size.width,
                height: 45.0.h,butonColor: Renkler.onayButonColor,
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> filtrelistream() async {
    print("meslek seçme: " + _filtreMeslek);
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


    }
    // 4(1) li kombinasyonu=4
    else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir == "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 2 e geldi");
      QuerySnapshot qn = await _firestore.collection("users").where('meslek', isEqualTo: _filtreMeslek).get();

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

    } else if (_filtreMeslek == "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 3 e geldi");
      QuerySnapshot qn = await _firestore.collection("users").where('sehir', isEqualTo: _filtreSehir).get();


    } else if (_filtreMeslek == "yok" && _filtreYas == "yok" && _filtreSehir == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 4 e geldi");
      QuerySnapshot qn =
      await _firestore.collection("users").where('cinsiyet', isEqualTo: _filtreCinsiyet).get();


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

    } else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet == "yok") {
      print("Filtre: 5 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('meslek', isEqualTo: _filtreMeslek)
          .where('sehir', isEqualTo: _filtreSehir)
          .get();

    } else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 6 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('meslek', isEqualTo: _filtreMeslek)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();

    } else if (_filtreMeslek == "yok" && _filtreYas != "yok" && _filtreSehir == "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 6 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where("dogumTarihi",
          isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(0, 2)))))
          .where("dogumTarihi",
          isGreaterThanOrEqualTo:
          DateTime.now().subtract(Duration(days: 365 * int.parse(_filtreYas.substring(3, 5)))))
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();

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

    } else if (_filtreMeslek == "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 8 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('sehir', isEqualTo: _filtreSehir)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .get();

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


    } else if (_filtreMeslek != "yok" && _filtreYas == "yok" && _filtreSehir != "yok" && _filtreCinsiyet != "yok") {
      print("Filtre: 10 e geldi");
      QuerySnapshot qn = await _firestore
          .collection("users")
          .where('sehir', isEqualTo: _filtreSehir)
          .where('cinsiyet', isEqualTo: _filtreCinsiyet)
          .where('meslek', isEqualTo: _filtreMeslek)
          .get();


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


    } else {
      print("Filtre: 13 e geldi");
     // await _bildirimGondermeServis.adminherkesebildirimGonder(aciklamaController.text);

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
                      return GestureDetector(
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
            height: 600,
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
                      return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  _itemsSehir[index].toString(),
                                  style: TextStyle(fontSize: 17),
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
                      return GestureDetector(
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
                      return GestureDetector(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 30.0.w),
                            child: Row(
                              children: [
                                Text(
                                  _itemsYas[index].toString(),
                                  style: TextStyle(fontSize: 17.0.spByWidth),
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
                  padding:  EdgeInsets.symmetric(vertical: 10.0.h),
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
