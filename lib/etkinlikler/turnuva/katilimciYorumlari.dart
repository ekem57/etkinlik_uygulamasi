import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:etkinlik_kafasi/widgets/oylamaEmojileriEtkin.dart';
import 'package:etkinlik_kafasi/widgets/oylama_Emojileri_Etkinlik.dart';
import 'package:etkinlik_kafasi/widgets/yorumyapAlertDialogEtkinlik.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class KatilimciYorumlari extends StatefulWidget {
  final DocumentSnapshot card;

  const KatilimciYorumlari({Key key, this.card}) : super(key: key);
  @override
  _KatilimciYorumlariState createState() => _KatilimciYorumlariState();
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

class _KatilimciYorumlariState extends State<KatilimciYorumlari>  {


  bool isSearching = false;
  List<DocumentSnapshot> totalUsers = [];
  List totalBilgi = [];
  List data;



  final yorumController = TextEditingController();
  void _searchUser(String searchQuery) {

    List<Map<dynamic,dynamic>> searchResult = [];

    userBloc.userController.sink.add(null);
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(null);
      return;
    }
    totalUsers.forEach((DocumentSnapshot user) {
      String tamad=user['ad'];
      if (tamad.toLowerCase().contains(searchQuery.toLowerCase()) ||
          tamad.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(user.data());
      }
    });


    userBloc.userController.sink.add(searchResult);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usergetir1();

  }

static  DocumentSnapshot userdata;

  Future<void> usergetir1() async {

    userdata= await FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).get();
    print("user ıd:"+widget.card.data().toString());

  }


  Widget usersWidget(String userid) {
    print("users widget çalıştı");
    return StreamBuilder(

        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext, AsyncSnapshot<List> snapshot) {

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

                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users').where('userId',isEqualTo: _cardYonetici['userid'])
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }



                            return cardLength == 0
                                ? Text("Herhangi bir etkinlik yok!")
                                : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.docs.length == 0 ? 0 : 1,
                                  itemBuilder: (_, int index) {
                                final DocumentSnapshot _card = snapshot.data.docs[0];

                                if(totalUsers.length<cardLength){
                                  totalUsers.add(_card);
                                  totalBilgi.add(_card);
                                }
                                print("total user:"+totalUsers.length.toString());
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 6.0.h),
                                  child: GestureDetector(
                                    onTap: (){
                                      print("tiklanan:"+userdata.toString());
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: _card.data(),)),);

                                    },
                                    child: Column(
                                      children: [
                                        ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  _card['avatarImageUrl'].toString()),
                                              radius: 25.70.w,
                                            ),
                                            title: Text(
                                              _card['ad'].toString(),
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0.spByWidth),
                                            ),
                                            subtitle: _cardYonetici['yorumdurumu'] ? Text("Yorum Yapıldı") :GestureDetector(
                                              onTap: () async {

                                                var dialog = YorumYapAlertDialogEtkinlik(
                                                  ad:  _card['ad'].toString(),
                                                  profilFoto:  _card['avatarImageUrl'].toString(),
                                                  Pressed: () async {

                                                  var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(_cardYonetici['userid']).get();
                                                  if(_cardYonetici['yorumdeger'] == null && deger['yorumdeger']==null  || yorumController.text==""){

                                                  var dialogBilgi = AlertBilgilendirme(
                                                  message: "Lütfen Emoji Değerlendirmesi  ve Yorum yapınız.",
                                                    onPostivePressed: (){

                                                      Navigator.pop(context);
                                                    },
                                                  );

                                                  showDialog(context: context, builder: (BuildContext context) => dialogBilgi);

                                                  }else {
                                                    final _userModel = Provider.of<UserModel>(context, listen: false);
                                                    print("kendi idim:"+ _userModel.user.userId);
                                                    print("karşı id:"+ _cardYonetici['userid'].toString());
                                                    _firestoreDBService.yorumkaydet(
                                                        _userModel.user.userId, widget.card['etid'].toString(), yorumController.text,
                                                        _cardYonetici['userid'],
                                                        _cardYonetici['yorumdeger'].toString());
                                                    Navigator.pop(context);
                                                    yorumController.clear();
                                                    print("yorum yazıldı");

                                                  }
                                                  },
                                                  emoji: _cardYonetici['yorumdeger'].toString(),
                                                  yorumController: yorumController,
                                                  karsiuserid: _card['userId'].toString(),
                                                  etid: widget.card['etid'],
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
                                                      .collection("etkinlikKatilimYorum").doc(userid).collection("katilimci").where('karsiuser',isEqualTo: _card['userId'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                                                      .snapshots(),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (!snapshot.hasData) return Container();
                                                    selectedEmoji =  snapshot.data != null ? snapshot.data.docs.length != 0 ? snapshot.data.docs.toString() == "[]" ?  snapshot.data.docs[0]['yorumdeger'].toString()  : "" : "" :"";
                                                    return  snapshot.data.docs.toString() == "[]" ?
                                                    OylamaEmojileriEtkinlik(userid:userid ,etid: widget.card['etid'].toString(),karsiuser: _card['userId'].toString(),carid: _cardYonetici.id ,)
                                                        : snapshot.data.docs[0]['onay'] == true ?
                                                    OylamaEmojileriEtkin(deger: snapshot.data.docs[0]['yorumdeger'].toString(),userid:userid ,etid: widget.card['etid'].toString(),karsiuser: _card['userId'].toString(),carid: _cardYonetici.id ,):
                                                    OylamaEmojileriEtkinlik(userid:_card['userId'].toString() ,etid: widget.card['etid'].toString(),karsiuser: _card['userId'].toString(),carid: _cardYonetici.id,);
                                                  }),
                                            )
                                        ),
                                        _cardYonetici['katilmaYorumu'] == false ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            MyButton(text: "Katıldı", onPressed: (){

                                              _cardYonetici.reference.update({'katilmaYorumu':true});
                                              _card.reference.update({'etkinlikKatildi':FieldValue.increment(1)});

                                            }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                                            MyButton(text: "Katılmadı", onPressed: (){

                                              _cardYonetici.reference.update({'katilmaYorumu':true});
                                              _card.reference.update({'etkinlikKatilmadi':FieldValue.increment(1)});


                                            }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                                          ],
                                        ) : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }

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
              : _randomUsers(snapshot: snapshot,);
        });
  }


  Widget _randomUsers({AsyncSnapshot<List> snapshot}) {
    print("random widget çalıştı");
    print("snapshot veri sayısı:"+snapshot.data.length.toString());
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return snapshot.data.length != 0 ?
    StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshotyonetici) {
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final int cardLength = snapshot.data.length;

        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cardLength,
            itemBuilder: (_, int indexyonetici) {
              final DocumentSnapshot _cardYonetici = snapshotyonetici.data != null ?   snapshotyonetici.data.docs[indexyonetici] : null;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {

                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: userdata.data(),)),);

                      },
                      child: Column(
                        children: [
                          ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data[index]['avatarImageUrl'].toString()),
                                radius: 25.70.w,
                              ),
                              title: Text(
                                snapshot.data[index]['ad'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0.spByWidth),
                              ),
                              subtitle: snapshot.data != null ?snapshotyonetici.data != null ? snapshotyonetici.data.docs[indexyonetici]['yorumdurumu'] ? Text("Yorum Yapıldı") :
                              GestureDetector(
                                onTap: (){
                                  var dialog = YorumYapAlertDialogEtkinlik(
                                    ad: snapshot.data[index]['ad'].toString(),
                                    profilFoto:  snapshot.data[index]['avatarImageUrl'].toString(),
                                    Pressed: () async {

                                      var deger = await FirebaseFirestore.instance.collection('etkinlik').doc(widget.card['etid']).collection("katilimcilar").doc(snapshot.data[index]['userId'].toString()).get();
                                      if(_cardYonetici['yorumdeger'] == null && deger['yorumdeger']==null || yorumController.text==""){
                                        var dialogBilgi = AlertBilgilendirme(
                                          message: "Lütfen Emoji Değerlendirmesi ve Yorum yapınız.",
                                          onPostivePressed: (){

                                            Navigator.pop(context);
                                          },
                                        );

                                        showDialog(context: context, builder: (BuildContext context) => dialogBilgi);

                                      }else {

                                        _firestoreDBService.yorumkaydet(snapshot.data[index]['userId'].toString(), widget.card['etid'].toString(), yorumController.text,snapshot.data[index]['userId'].toString(),_cardYonetici['yorumdeger'].toString());

                                        Navigator.pop(context);
                                        yorumController.clear();
                                        print("yorum yazıldı");

                                      }
                                    },
                                    emoji: _cardYonetici['yorumdeger'].toString(),
                                    yorumController: yorumController,
                                    karsiuserid: snapshot.data[index]['userId'].toString(),
                                    etid: widget.card['etid'],
                                    carid: _cardYonetici.id ,

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
                              ) : Container() : Container(),
                              trailing:  Container(
                                width: 125.0.w,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("etkinlikKatilimYorum").doc(_userModel.user.userId).collection("katilimci").where('karsiuser',isEqualTo: snapshot.data[index]['userId'].toString()).where('etid',isEqualTo: widget.card['etid'].toString())
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot2) {

                                      if (!snapshot.hasData) return Container();
                                      return snapshot2.data !=null ? snapshot2.data.docs.toString() == "[]" ?
                                      OylamaEmojileriEtkinlik(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userId'].toString(),)
                                          : snapshot2.data.docs[0]['onay'] == true ?
                                      OylamaEmojileriEtkin(deger: snapshot2.data.docs[0]['yorumdeger'].toString(),userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userId'].toString(),):
                                      OylamaEmojileriEtkinlik(userid:_userModel.user.userId ,etid: widget.card['etid'].toString(),karsiuser: snapshot.data[index]['userId'].toString(),carid: _cardYonetici.id,) :Container();
                                    }),

                              )
                          ),
                          snapshotyonetici.data != null ?      snapshotyonetici.data.docs[indexyonetici]['katilmaYorumu'] == false ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyButton(text: "Katıldı", onPressed: (){

                                snapshotyonetici.data.docs[index].reference.update({'katilmaYorumu':true});
                                snapshotyonetici.data.docs[index].reference.update({'etkinlikKatildi':FieldValue.increment(1)});

                              }, textColor: Colors.white, fontSize: 12, width: 140, height: 30),
                              MyButton(text: "Katılmadı", onPressed: (){

                                snapshotyonetici.data.docs[index].reference.update({'katilmaYorumu':true});
                                snapshotyonetici.data.docs[index].reference.update({'etkinlikKatilmadi':FieldValue.increment(1)});


                              }, textColor: Colors.white, fontSize: 12, width: 140, height: 30,butonColor: Colors.red,),

                            ],
                          ) : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Etkinlik Katılma Onayı Verildi ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                            ],
                          ) : Container(),
                        ],
                      ),
                    ),
                  );

                },

                itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              );
            }


        );

      },
    ) : Container();
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
              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
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
