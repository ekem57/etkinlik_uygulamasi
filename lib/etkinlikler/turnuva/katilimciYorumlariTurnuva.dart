import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:etkinlik_kafasi/widgets/oylamaEmojileriEtkin.dart';
import 'package:etkinlik_kafasi/widgets/oylamaEmojileriTurnuva.dart';
import 'package:etkinlik_kafasi/widgets/oylama_Emojileri_Etkinlik.dart';
import 'package:etkinlik_kafasi/widgets/oylama_emojleri.dart';
import 'package:etkinlik_kafasi/widgets/yorumyapAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class KatilimciYorumlariTurnuva extends StatefulWidget {
  final DocumentSnapshot card;

  const KatilimciYorumlariTurnuva({Key key, this.card}) : super(key: key);
  @override
  _KatilimciYorumlariTurnuvaState createState() => _KatilimciYorumlariTurnuvaState();
}


class UserBloc extends Bloc {
  final userController = StreamController<List>.broadcast();


  @override
  void dispose() {
    // TODO: implement dispose
    userController.close();
  }
}

abstract class Bloc {
  void dispose();
}



UserBloc userBloc = UserBloc();
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _KatilimciYorumlariTurnuvaState extends State<KatilimciYorumlariTurnuva>  {

  List<int>yeniliste=[];
  bool isSearching = false;
  bool isEmpty = false;
  List<DocumentSnapshot> totalUsers = [];
  List totalBilgi = [];
  List data;

 static  DocumentSnapshot _card1;
 static DocumentSnapshot _card2;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(" etkinlik id: "+widget.card.id);
  }



  final yorumController = TextEditingController();
  void _searchUser(String searchQuery) {

    List<Map<dynamic,dynamic>> searchResult = [];

    userBloc.userController.sink.add(null);
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsers);
      setState(() {
        isEmpty = true;
      });
      return;
    }

    setState(() {
      isEmpty = false;
    });
    totalUsers.forEach((DocumentSnapshot user) {

      Map<String, dynamic> userbilgileri = Map();
      userbilgileri.clear();
      userbilgileri['user1ad'] = user['user1ad'].toString();
      userbilgileri['user1foto'] = user['user1foto'].toString();
      userbilgileri['userid1'] = user['userid1'].toString();
      userbilgileri['yorumdurumu1'] = user['yorumdurumu1'].toString();
      userbilgileri['user1degerleme'] = user['user1degerleme'].toString();
      userbilgileri['carid'] = user['carid'].toString();
      userbilgileri['sira'] = "1";

      String tamad=user['user1ad'];

      if (tamad.toLowerCase().contains(searchQuery.toLowerCase()) ||
          tamad.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(userbilgileri);
      }
      Map<String, dynamic> userbilgileri2 = Map();
      userbilgileri2.clear();
      userbilgileri2['user1ad'] = user['user2ad'].toString();
      userbilgileri2['user1foto'] = user['user2foto'].toString();
      userbilgileri2['userid1'] = user['userid2'].toString();
      userbilgileri2['yorumdurumu2'] = user['yorumdurumu2'].toString();
      userbilgileri2['user2degerleme'] = user['user2degerleme'].toString();
      userbilgileri2['carid'] = user['carid'].toString();
      userbilgileri2['sira'] = "2";

      String tamad2=user['user2ad'];

      if (tamad2.toLowerCase().contains(searchQuery.toLowerCase()) ||
          tamad2.toLowerCase().contains(searchQuery.toLowerCase())) {

        searchResult.add(userbilgileri2);
      }

    });


    userBloc.userController.sink.add(searchResult);
  }
  Widget usersWidget(String userid) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return StreamBuilder(

        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List> snapshot) {

          if (snapshot.data == null) {

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final int cardLength = snapshot.data.docs.length;

                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];


                      _cardYonetici['userid2'] != null ?  totalUsers.add(_cardYonetici) : null;



                      return _cardYonetici['userid2'] != null ?
                      Column(
                        children: [
                          _userModel.user.userId != _cardYonetici['userid1'] ?
                           Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0.w, vertical: 6.0.h),
                            child: GestureDetector(
                              onTap: () async {
                                  FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid1']).get().then((value) {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: value.data(),)),);

                                });


                              },
                              child: Column(
                                children: [
                                  ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _cardYonetici['user1foto'].toString()),
                                        radius: 25.70.w,
                                      ),
                                      title: Text(
                                        _cardYonetici['user1ad'].toString(),
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.0.spByWidth),
                                      ),
                                      subtitle: _cardYonetici['yorumdurumu1'] ? Text("Yorum Yapıldı") :

                                      GestureDetector(
                                        onTap: () {
                                          var dialog = YorumYapAlertDialog(
                                            ad:  _cardYonetici['user1ad'].toString(),
                                            profilFoto:  _cardYonetici['user1foto'].toString(),
                                            Pressed: () async {
                                              var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(_cardYonetici.id).get();
                                              if(deger['user1degerleme'] == null || yorumController.text==""){
                                                var dialogBilgi = AlertBilgilendirme(
                                                  message: "Lütfen Emoji Ve Yorum Değerlendirmesi yapınız.",
                                                  onPostivePressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                );

                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) => dialogBilgi);
                                              }else {
                                                _firestoreDBService.yorumkaydetTurnuva(
                                                    _userModel.user.userId,
                                                    widget.card['etid'].toString(),
                                                    yorumController.text,
                                                    _cardYonetici['userid1'].toString(),
                                                    _cardYonetici['user1degerleme'].toString(),
                                                    _cardYonetici.id,
                                                     "1"
                                                );
                                                Navigator.pop(context);
                                                yorumController.clear();
                                              }

                                            },
                                            emoji: _cardYonetici['user1degerleme'].toString(),
                                            yorumController: yorumController,
                                            karsiuserid:  _cardYonetici['userid1'].toString(),
                                            etid: widget.card['etid'].toString(),
                                            carid: _cardYonetici.id,
                                          );

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) => dialog);
                                        },
                                        child: Text(
                                            "Yorum yap",
                                            style: TextStyle(
                                                color: const Color(0xffcc59d2),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0.spByWidth
                                            ),
                                            textAlign: TextAlign.left
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 125.0.w,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("etkinlikKatilimYorum").doc(userid).collection("katilimci").where('karsiuser',isEqualTo: _cardYonetici['userid1'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot> snapshot) {

                                              selectedEmoji= snapshot.data != null ? snapshot.data.docs.length != 0 ? snapshot.data.docs[0]['yorumdeger'].toString() : "" : "";
                                              if (!snapshot.hasData) return Container();

                                              return  snapshot.data.docs.toString() == "[]" ?
                                              OylamaEmojileri(userid:userid ,etid: widget.card['etid'].toString(),karsiuser: _cardYonetici['userid1'].toString(),carid: _cardYonetici.id,)
                                                  : snapshot.data.docs[0]['onay'] == true ?
                                              OylamaEmojileriEtkinTurnuva(etid:widget.card['etid'].toString() ,deger: snapshot.data.docs[0]['yorumdeger'].toString(),userid: _userModel.user.userId,karsiuser: _cardYonetici['userid1'].toString(),carid: _cardYonetici.id):
                                              OylamaEmojileri(userid:_cardYonetici['userid1'].toString() ,etid: widget.card['etid'].toString(),karsiuser: _cardYonetici['userid1'].toString(),carid: _cardYonetici.id,);
                                            }),
                                      )
                                  ),
                                  
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid1'].toString()).snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<DocumentSnapshot> snapshotdocs) {

                                        if (!snapshotdocs.hasData) return Container();

                                        return  snapshotdocs.data['katilmaYorumu'] == false ?    Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            MyButton(text: "Katıldı", onPressed: (){

                                              FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid1'].toString()).update({'katilmaYorumu':true});
                                              FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid1']).update({'etkinlikKatildi':FieldValue.increment(1)});

                                            }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                                            MyButton(text: "Katılmadı", onPressed: (){

                                              FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid1'].toString()).update({'katilmaYorumu':true});
                                              FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid1']).update({'etkinlikKatilmadi':FieldValue.increment(1)});


                                            }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                                          ],
                                        ) : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          ],
                                        );

                                       }
                                      ),






                                ],
                              ),
                            ),
                          ) : Container(),
                          if (_userModel.user.userId != _cardYonetici['userid2'])
                            Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0.w, vertical: 6.0.h),
                            child: GestureDetector(
                              onTap: () async {
                                FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid2']).get().then((value) {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: value.data(),)),);

                                });
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _cardYonetici['user2foto'].toString()),
                                        radius: 25.70.w,
                                      ),
                                      title: Text(
                                        _cardYonetici['user2ad'].toString(),
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.0.spByWidth),
                                      ),
                                      subtitle: _cardYonetici['yorumdurumu2'] ? Text("Yorum Yapıldı") :  GestureDetector(
                                        onTap: () {
                                          var dialog = YorumYapAlertDialog(
                                            ad:  _cardYonetici['user2ad'].toString(),
                                            profilFoto:  _cardYonetici['user2foto'].toString(),
                                            Pressed: () async {
                                              var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(_cardYonetici.id).get();

                                              if(deger['user2degerleme'] == null || yorumController.text==""){
                                                var dialogBilgi = AlertBilgilendirme(
                                                  message: "Lütfen Emoji  Ve Yorum Değerlendirmesi yapınız.",
                                                  onPostivePressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                );

                                                showDialog(context: context, builder: (BuildContext context) => dialogBilgi);
                                              }else {
                                                _firestoreDBService.yorumkaydetTurnuva(
                                                    _userModel.user.userId,
                                                    widget.card['etid'].toString(),
                                                    yorumController.text,
                                                    _cardYonetici['userid2'].toString(),
                                                    _cardYonetici['user2degerleme'].toString(),
                                                    _cardYonetici.id,
                                                     "2"
                                                );
                                                Navigator.pop(context);
                                                yorumController.clear();
                                              }

                                            },
                                            emoji: _cardYonetici['user2degerleme'].toString(),
                                            yorumController: yorumController,
                                            karsiuserid:  _cardYonetici['userid2'],
                                            etid: widget.card['etid'].toString(),
                                            carid: _cardYonetici.id,
                                          );

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) => dialog);
                                        },
                                        child: Text(
                                            "Yorum yap",
                                            style: TextStyle(
                                                color: const Color(0xffcc59d2),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0.spByWidth
                                            ),
                                            textAlign: TextAlign.left
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 125.0.w,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("etkinlikKatilimYorum").doc(userid).collection("katilimci").where('karsiuser',isEqualTo: _cardYonetici['userid2'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot> snapshot) {
                                              selectedEmoji= snapshot.data != null ? snapshot.data.docs.length != 0 ? snapshot.data.docs[0]['yorumdeger'].toString() : "" : "";
                                              if (!snapshot.hasData) return Container();

                                              return  snapshot.data.docs.toString() == "[]" ?
                                              OylamaEmojileri(userid:userid ,etid: widget.card['etid'].toString(),karsiuser: _cardYonetici['userid2'].toString(),carid: _cardYonetici.id,)
                                                  : snapshot.data.docs[0]['onay'] == true ?
                                              OylamaEmojileriEtkinTurnuva(deger: snapshot.data.docs[0]['yorumdeger'].toString(),etid: widget.card['etid'].toString(),karsiuser: _cardYonetici['userid2'].toString(),carid: _cardYonetici.id,userid: _userModel.user.userId,):
                                              OylamaEmojileri(userid:_cardYonetici['userid1'].toString() ,etid: widget.card['etid'].toString(),karsiuser: _cardYonetici['userid2'].toString(),carid: _cardYonetici.id);
                                            }),
                                      )
                                  ),
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid2'].toString()).snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<DocumentSnapshot> snapshotdocs) {

                                        if (!snapshotdocs.hasData) return Container();

                                        return  snapshotdocs.data['katilmaYorumu'] == false ?    Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            MyButton(text: "Katıldı", onPressed: (){

                                              FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid2'].toString()).update({'katilmaYorumu':true});
                                              FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid2']).update({'etkinlikKatildi':FieldValue.increment(1)});

                                            }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                                            MyButton(text: "Katılmadı", onPressed: (){

                                              FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid2'].toString()).update({'katilmaYorumu':true});
                                              FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid2']).update({'etkinlikKatilmadi':FieldValue.increment(1)});


                                            }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                                          ],
                                        ) : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          ],
                                        );

                                      }
                                  ),
                                ],
                              ),
                            ),
                          ) else Container(),
                        ],
                      ) : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 6.0.h),
                        child: GestureDetector(
                          onTap: () async {
                            FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid1']).get().then((value) {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: value.data(),)),);

                            });


                          },
                          child: Column(
                            children: [
                              ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        _cardYonetici['user1foto'].toString()),
                                    radius: 25.70.w,
                                  ),
                                  title: Text(
                                    _cardYonetici['user1ad'].toString(),
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0.spByWidth),
                                  ),
                                  subtitle: _cardYonetici['yorumdurumu1'] ? Text("Yorum Yapıldı") : GestureDetector(
                                    onTap: () {
                                      var dialog = YorumYapAlertDialog(
                                        ad:  _cardYonetici['user1ad'].toString(),
                                        profilFoto:  _cardYonetici['user1foto'].toString(),
                                        Pressed: () async {
                                          var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(_cardYonetici.id).get();
                                          if(deger['user1degerleme'] == null || yorumController.text==""){
                                            var dialogBilgi = AlertBilgilendirme(
                                              message: "Lütfen Emoji Ve Yorum Değerlendirmesi yapınız.",
                                              onPostivePressed: (){
                                                Navigator.pop(context);
                                              },
                                            );

                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => dialogBilgi);
                                          }else {
                                            _firestoreDBService.yorumkaydetTurnuva(
                                                _userModel.user.userId,
                                                widget.card['etid'].toString(),
                                                yorumController.text,
                                                _cardYonetici['userid1'].toString(),
                                                _cardYonetici['user1degerleme'].toString(),
                                                _cardYonetici.id,
                                                "1"
                                            );
                                            Navigator.pop(context);
                                            yorumController.clear();
                                          }

                                        },
                                        emoji: _cardYonetici['user1degerleme'].toString(),
                                        yorumController: yorumController,
                                        karsiuserid:  _cardYonetici['userid1'].toString(),
                                        etid: widget.card['etid'].toString(),
                                        carid: _cardYonetici.id,
                                      );

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) => dialog);
                                    },
                                    child: Text(
                                        "Yorum yap",
                                        style: TextStyle(
                                            color: const Color(0xffcc59d2),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0.spByWidth
                                        ),
                                        textAlign: TextAlign.left
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 125.0.w,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("etkinlikKatilimYorum").doc(userid).collection("katilimci").where('karsiuser',isEqualTo: _cardYonetici['userid1'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot> snapshot) {

                                          selectedEmoji= snapshot.data != null ? snapshot.data.docs.length != 0 ? snapshot.data.docs[0]['yorumdeger'].toString() : "" : "";
                                          if (!snapshot.hasData) return Container();

                                          return  snapshot.data.docs.toString() == "[]" ?
                                          OylamaEmojileri(userid:userid ,etid: widget.card['etid'].toString(),karsiuser: _cardYonetici['userid1'].toString(),carid: _cardYonetici.id,)
                                              : snapshot.data.docs[0]['onay'] == true ?
                                          OylamaEmojileriEtkinTurnuva(etid:widget.card['etid'].toString() ,deger: snapshot.data.docs[0]['yorumdeger'].toString(),userid: _userModel.user.userId,karsiuser: _cardYonetici['userid1'].toString(),carid: _cardYonetici.id):
                                          OylamaEmojileri(userid:_cardYonetici['userid1'].toString() ,etid: widget.card['etid'].toString(),karsiuser: _cardYonetici['userid1'].toString(),carid: _cardYonetici.id,);
                                        }),
                                  )
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid1'].toString()).snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot> snapshotdocs) {

                                    if (!snapshotdocs.hasData) return Container();

                                    return  snapshotdocs.data['katilmaYorumu'] == false ?    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        MyButton(text: "Katıldı", onPressed: (){

                                          FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid1'].toString()).update({'katilmaYorumu':true});
                                          FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid1']).update({'etkinlikKatildi':FieldValue.increment(1)});

                                        }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                                        MyButton(text: "Katılmadı", onPressed: (){

                                          FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(_cardYonetici['userid1'].toString()).update({'katilmaYorumu':true});
                                          FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid1']).update({'etkinlikKatilmadi':FieldValue.increment(1)});


                                        }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                                      ],
                                    ) : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                      ],
                                    );

                                  }
                              ),
                            ],
                          ),
                        ),
                      );
                    }


                );

              },
            );
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : _randomUsers(snapshot: snapshot);
        });
  }


  Widget _randomUsers({AsyncSnapshot<List> snapshot}) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        return  isEmpty ==true ? Column(
          children: [
            _userModel.user.userId != snapshot.data[index]['userid1'] ?
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
              child: GestureDetector(
                onTap: () async {
                  FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid1']).get().then((value) {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: value.data(),)),);

                  });
                },
                child: Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data[index]['user1foto'].toString()),
                          radius: 25.70.w,
                        ),
                        title: Text(
                          snapshot.data[index]['user1ad'].toString(),
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0.spByWidth),
                        ),
                        subtitle: snapshot.data != null ?  snapshot.data.isEmpty == false ? snapshot.data.length != 0 ? snapshot.data[index]['yorumdurumu1'].toString() == "true" ? Text("Yorum Yapıldı") :
                        GestureDetector(
                          onTap: () async {
                            var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(snapshot.data[index]['carid']).get();

                            var dialog = YorumYapAlertDialog(
                              ad: snapshot.data[index]['user1ad'].toString(),
                              profilFoto: snapshot.data[index]['user1foto'].toString(),
                              Pressed: (){
                                if(deger['user1degerleme']== null || yorumController.text==""){
                                  var dialogBilgi = AlertBilgilendirme(
                                    message: "Lütfen Emoji Ve Yorum Değerlendirmesi yapınız.",
                                    onPostivePressed: (){
                                      Navigator.pop(context);
                                    },
                                  );

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => dialogBilgi);
                                }else {
                                  _firestoreDBService.yorumkaydetTurnuva(
                                      _userModel.user.userId,
                                      widget.card['etid'].toString(),
                                      yorumController.text,
                                      snapshot.data[index]['userid1'],
                                      snapshot.data[index]['user1degerleme'].toString(),
                                      snapshot.data[index]['carid'],
                                      "1"

                                  );
                                  Navigator.pop(context);
                                  yorumController.clear();
                                  setState(() {

                                  });
                                }

                              },
                              emoji: selectedEmoji,
                              yorumController: yorumController,
                              karsiuserid:snapshot.data[index]['userid1'] ,
                              etid: widget.card['etid'].toString(),
                              carid:snapshot.data[index]['carid'] ,
                            );

                            showDialog(
                                context: context,
                                builder: (BuildContext context) => dialog);

                          },
                          child: Text(
                              "Yorum yap",
                              style:  TextStyle(
                                  color:  const Color(0xffcc59d2),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 14.0.spByWidth
                              ),
                              textAlign: TextAlign.left
                          ),
                        ) : Container() : Container() : Container(),
                        trailing:   Container(
                          width: 125.0.w,
                          child:StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("etkinlikKatilimYorum").doc(_userModel.user.userId).collection("katilimci").where('karsiuser',isEqualTo: snapshot.data[index]['userid1'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot2) {

                                if (!snapshot.hasData) return Container();
                                selectedEmoji= snapshot.data!= null ? snapshot2.data !=null ? snapshot2.data.docs.toString() == "[]" ? snapshot2.data.docs.isEmpty == false ? snapshot2.data.docs[0]['yorumdeger'].toString() : "" : "": "":"";
                                return snapshot2.data !=null ? snapshot2.data.docs.toString() == "[]" ?
                                OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid1'].toString(),carid:snapshot.data[index]['carid'] ,)
                                    : snapshot2.data.docs[0]['onay'] == true ?
                                OylamaEmojileriEtkinTurnuva(deger: snapshot2.data.docs[0]['yorumdeger'].toString(),userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid1'].toString(),carid:snapshot.data[index]['carid'] ):
                                OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid1'].toString(),carid: snapshot.data[index]['carid'],) :Container();
                              }),

                        )
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid1'].toString()).snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshotdocs) {

                          if (!snapshotdocs.hasData) return Container();

                          return  snapshotdocs.data['katilmaYorumu'] == false ?    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyButton(text: "Katıldı", onPressed: (){

                                FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid1'].toString()).update({'katilmaYorumu':true});
                                FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid1']).update({'etkinlikKatildi':FieldValue.increment(1)});

                              }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                              MyButton(text: "Katılmadı", onPressed: (){

                                FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid1'].toString()).update({'katilmaYorumu':true});
                                FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid1']).update({'etkinlikKatilmadi':FieldValue.increment(1)});


                              }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                            ],
                          ) : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            ],
                          );

                        }
                    ),
                  ],
                ),
              ),
            ) : Container(),
            _userModel.user.userId != snapshot.data[index]['userid2'] ?
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
              child: GestureDetector(
                onTap: () async {
                  FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid2']).get().then((value) {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: value.data(),)),);

                  });
                },
                child: Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data[index]['user2foto'].toString()),
                          radius: 25.70.w,
                        ),
                        title: Text(
                          snapshot.data[index]['user2ad'].toString(),
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0.spByWidth),
                        ),
                        subtitle:snapshot.data != null ?  snapshot.data.isEmpty == false ? snapshot.data.length != 0 ? snapshot.data[index]['yorumdurumu2'].toString() == "true" ? Text("Yorum Yapıldı") :
                        GestureDetector(
                          onTap: () async {
                            var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(snapshot.data[index]['carid']).get();

                            var dialog = YorumYapAlertDialog(
                              ad: snapshot.data[index]['user2ad'].toString(),
                              profilFoto: snapshot.data[index]['user2foto'].toString(),
                              Pressed: (){
                                if(deger['user2degerleme']== null || yorumController.text==""){

                                  var dialogBilgi = AlertBilgilendirme(
                                    message: "Lütfen Emoji Ve Yorum Değerlendirmesi yapınız.",
                                    onPostivePressed: (){
                                      Navigator.pop(context);
                                    },
                                  );

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => dialogBilgi);
                                }else {
                                  _firestoreDBService.yorumkaydetTurnuva(
                                      snapshot.data[index]['userid2'].toString(),
                                      widget.card['etid'].toString(),
                                      yorumController.text,
                                      snapshot.data[index]['userid2'].toString(),
                                      snapshot.data[index]['user1degerleme'].toString(),
                                      snapshot.data[index]['carid'].toString(),
                                      "2"
                                  );
                                  Navigator.pop(context);
                                  yorumController.clear();
                                  setState(() {

                                  });
                                }


                              },
                              emoji: snapshot.data[index]['user2degerleme'],
                              yorumController: yorumController,
                              karsiuserid: snapshot.data[index]['userid2'].toString() ,
                              etid: widget.card['etid'].toString(),
                              carid:snapshot.data[index]['carid'] ,
                            );

                            showDialog(
                                context: context,
                                builder: (BuildContext context) => dialog);

                          },
                          child: Text(
                              "Yorum yap",
                              style:  TextStyle(
                                  color:  const Color(0xffcc59d2),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 14.0.spByWidth
                              ),
                              textAlign: TextAlign.left
                          ),
                        ) : Container() : Container() : Container(),
                        trailing:  Container(
                          width: 125.0.w,
                          child:StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("etkinlikKatilimYorum").doc(_userModel.user.userId).collection("katilimci").where('karsiuser',isEqualTo: snapshot.data[index]['userid2'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot2) {
                                print("2");
                                selectedEmoji= snapshot.data!= null ? snapshot2.data !=null ? snapshot2.data.docs.toString() == "[]" ? snapshot2.data.docs.isEmpty == false ? snapshot2.data.docs[0]['yorumdeger'].toString() : "" : "": "":"";

                                if (!snapshot.hasData) return Container();
                                return snapshot2.data !=null ? snapshot2.data.docs.toString() == "[]" ?
                                OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid2'].toString(),carid: snapshot.data[index]['carid'],)
                                    : snapshot2.data.docs[0]['onay'] == true ?
                                OylamaEmojileriEtkinTurnuva(deger: snapshot2.data.docs[0]['yorumdeger'].toString(),userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid2'].toString(),carid: snapshot.data[index]['carid']):
                                OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid2'].toString(),carid: snapshot.data[index]['carid'],) :Container();
                              }),

                        )
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid2'].toString()).snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshotdocs) {

                          if (!snapshotdocs.hasData) return Container();

                          return  snapshotdocs.data['katilmaYorumu'] == false ?    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyButton(text: "Katıldı", onPressed: (){

                                FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid2'].toString()).update({'katilmaYorumu':true});
                                FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid2']).update({'etkinlikKatildi':FieldValue.increment(1)});

                              }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                              MyButton(text: "Katılmadı", onPressed: (){

                                FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid2'].toString()).update({'katilmaYorumu':true});
                                FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid2']).update({'etkinlikKatilmadi':FieldValue.increment(1)});


                              }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                            ],
                          ) : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            ],
                          );

                        }
                    ),
                  ],
                ),
              ),
            ) : Container(),
          ],
        ):
        _userModel.user.userId != snapshot.data[index]['userid1'] ?  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
          child: GestureDetector(
            onTap: () async {
              FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid1']).get().then((value) {

                Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: value.data(),)),);

              });
            },
            child: Column(
              children: [
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data[index]['user1foto'].toString()),
                      radius: 25.70.w,
                    ),
                    title: Text(
                      snapshot.data[index]['user1ad'].toString(),
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0.spByWidth),
                    ),
                  //  snapshot.data != null ?  snapshot.data.isEmpty == false ? snapshot.data.length != 0 ?
                    subtitle: yeniliste.contains(index).toString() == "false" ?  snapshot.data != null ?  snapshot.data.isEmpty == false ? snapshot.data.length != 0 ?   snapshot.data[index]['yorumdurumu'+snapshot.data[index]['sira'].toString()].toString() == "true" ? Text("Yorum Yapıldı") :
                    GestureDetector(
                      onTap: (){

                        var dialog = YorumYapAlertDialog(
                          ad: snapshot.data[index]['user1ad'].toString(),
                          profilFoto: snapshot.data[index]['user1foto'].toString(),
                          Pressed: () async {
                            var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(snapshot.data[index]['carid']).get();

                              if(deger['user'+snapshot.data[index]['sira'].toString()+'degerleme'] == null || yorumController.text==""){
                                var dialogBilgi = AlertBilgilendirme(
                                  message: "Lütfen Emoji Ve Yorum Değerlendirmesi yapınız.",
                                  onPostivePressed: (){
                                    Navigator.pop(context);
                                  },
                                );

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => dialogBilgi);
                              }else{
                                _firestoreDBService.yorumkaydetTurnuva(
                                    _userModel.user.userId,
                                    widget.card['etid'].toString(),
                                    yorumController.text,
                                    snapshot.data[index]['userid1'].toString(),
                                    snapshot.data[index]['user1degerleme'].toString(),
                                    snapshot.data[index]['carid'].toString(),
                                    snapshot.data[index]['sira'].toString(),

                                ).then((value) {
                                  setState(() {
                                    // ignore: unnecessary_statements
                                  //  totalUsers[index]['yorumdurumu'+snapshot.data[index]['sira'].toString()]=="true";
                                    yeniliste.add(index);
                                  });

                                });
                                Navigator.pop(context);
                                yorumController.clear();

                              }



                          },
                          emoji: snapshot.data[index]['user1degerleme'].toString(),
                          yorumController: yorumController,
                          karsiuserid: snapshot.data[index]['userid1'].toString(),
                          etid: widget.card['etid'].toString(),
                          carid: snapshot.data[index]['carid'],
                        );

                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog);

                      },
                      child: Text(
                          "Yorum yap",
                          style:  TextStyle(
                              color:  const Color(0xffcc59d2),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle:  FontStyle.normal,
                              fontSize: 14.0.spByWidth
                          ),
                          textAlign: TextAlign.left
                      ),
                    ) : Container() : Container() : Container(): Text("Yorum Yapıldı") ,
                    trailing:  Container(
                      width: 125.0.w,
                      child:StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("etkinlikKatilimYorum").doc(_userModel.user.userId).collection("katilimci").where('karsiuser',isEqualTo: snapshot.data[index]['userid1'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot2) {
                            print("2:"+yeniliste.contains(index).toString());

                            if (!snapshot.hasData) return Container();
                            return snapshot2.data !=null ? snapshot2.data.docs.toString() == "[]" ?
                            OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid1'].toString(),carid: snapshot.data[index]['carid'],)
                                : snapshot2.data.docs[0]['onay'] == true ?
                            OylamaEmojileriEtkinTurnuva(deger: snapshot2.data.docs[0]['yorumdeger'].toString(),userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid1'].toString(),carid: snapshot.data[index]['carid']):
                            OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userid1'].toString(),carid: snapshot.data[index]['carid'],) :Container();
                          }),

                    )
                ),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc( snapshot.data[index]['userid1'].toString()).snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshotdocs) {

                      if (!snapshotdocs.hasData) return Container();

                      return  snapshotdocs.data['katilmaYorumu'] == false ?    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyButton(text: "Katıldı", onPressed: (){

                            FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid1'].toString()).update({'katilmaYorumu':true});
                            FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid1']).update({'etkinlikKatildi':FieldValue.increment(1)});

                          }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                          MyButton(text: "Katılmadı", onPressed: (){

                            FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").doc(snapshot.data[index]['userid1'].toString()).update({'katilmaYorumu':true});
                            FirebaseFirestore.instance.collection("users").doc(snapshot.data[index]['userid1']).update({'etkinlikKatilmadi':FieldValue.increment(1)});


                          }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                        ],
                      ) : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        ],
                      );

                    }
                ),
              ],
            ),
          ),
        ) : Container();
      },
      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context,listen: false);
    return  Scaffold(

      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Katılımcılar",
            style: TextStyle(
                color: const Color(0xff343633),
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 21.7.spByWidth),
            textAlign: TextAlign.center),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 40.0.w),
              child: Container(
                width: 293.3333333333333.w,
                height: 41.666666666666664.h,
                margin: EdgeInsets.symmetric(vertical: 20.0.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.8.h)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x2b000000), offset: Offset(0, 2), blurRadius: 14.30.w, spreadRadius: 0)
                  ],
                  color: Theme.of(context).backgroundColor,),
                child: TextFormField(
                  onChanged: (text) => _searchUser(text),
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.disabled,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 15.0.spByWidth),
                  decoration: InputDecoration(
                    hintText: "Katılımcı Ara",
                    border: InputBorder.none,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 18.0.h,
                      ),
                    ),
                    labelStyle: TextStyle(
                        color: const Color(0xbf343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 15.3.spByWidth),
                  ),
                ),

              ),
            ),
            usersWidget(_userModel.user.userId),
          ],
        ),
      ),
    );
  }


}
