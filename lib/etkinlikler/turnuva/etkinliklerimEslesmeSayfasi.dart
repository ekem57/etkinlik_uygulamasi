import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/users.dart';
//<<<<<<< HEAD:lib/etkinlikler/turnuva/etkinliklerimEslesmeSayfasi.dart
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class EtkinliklerimEslesmeSayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  EtkinliklerimEslesmeSayfasi({this.card});
  @override
  _EtkinliklerimEslesmeSayfasiState createState() => _EtkinliklerimEslesmeSayfasiState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
class _EtkinliklerimEslesmeSayfasiState extends State<EtkinliklerimEslesmeSayfasi> {
  List<Users> _turnuva_katilimci_Listesi_orjinal=[];
  List<Users> _turnuva_katilimci_Listesi=[];
  List<Users> _turnuva_eslesmeyenler_Listesi=[];
  List<Users> turnuva_index_Listesi=[];
  List<DocumentSnapshot> etkinlikCardId=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    katilimciListesigetir();
  }


  Future<void> katilimciListesigetir() async {

    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("etkinlik").doc(widget.card.id).collection("katilimciList").orderBy("index",descending: false).get();

     for (DocumentSnapshot snap in querySnapshot.docs) {

     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(snap['userid']).get();
      _turnuva_katilimci_Listesi.add(Users.fromMap(documentSnapshot.data()));
     _turnuva_katilimci_Listesi_orjinal.add(Users.fromMap(documentSnapshot.data()));

     }

    setState(() {

    });
    print("katilimci list lenght:"+_turnuva_katilimci_Listesi.length.toString());
  }


  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    bool varmi=false;
    return Scaffold(
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
        title: Center(
          child: Text("Eşleşmeler",
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 21.7.spByWidth),
              textAlign: TextAlign.center),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: ListView(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: filtrelistreamkullanilan(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              final int cardLength = snapshot.data.docs.length;
              //ikiside tam ise gelen
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _turnuva_katilimci_Listesi_orjinal.length % 2 == 1 ? ((_turnuva_katilimci_Listesi_orjinal.length/2)+1).floor() : ((_turnuva_katilimci_Listesi_orjinal.length/2)).ceil(),
                itemBuilder: (_, int index) {
                  if(index != cardLength){
                    if(_userModel.user.userId==snapshot.data.docs[index]['userid1'].toString()){
                      varmi=true;
                    }
                    if(_userModel.user.userId==snapshot.data.docs[index]['userid2'].toString()){
                      varmi=true;
                    }
                  }




                  return index == 0 ?

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 110.0.h,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          _turnuva_katilimci_Listesi.length != 0 ?
                          _turnuva_katilimci_Listesi[0] == null ?
                          GestureDetector(
                            onTap: (){
                              _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],0);
                            },
                            child: Container(
                              width: 67.66666666666667.w,
                              height: 68.0.w,
                              decoration: new BoxDecoration(
                                color: const Color(0xff91c4f2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                            ),
                          ) :
                          GestureDetector(
                              onTap: (){
                                _showPicker(context,index,snapshot.data.docs[index]['index'],0);

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 67.66666666666667.w,
                                      height: 68.0.w,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(_turnuva_katilimci_Listesi[0].avatarImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(_turnuva_katilimci_Listesi[0].adsoyad.toString(),
                                        style:  TextStyle(
                                            color:  const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13.3.spByWidth
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ) : Container(),
                            Container(
                              width: 38.0.w,
                              height: 38.0.w,
                              decoration: new BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,

                              ),
                              child: Center(
                                child: Text(
                                  "VS",
                                  style:  TextStyle(
                                      color:  const Color(0xff343633),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 16.0.spByWidth
                                  ),

                                ),
                              ),
                            ),
                            snapshot.data.docs[index]['user2foto'] != null ?
                            _turnuva_katilimci_Listesi.length <= 1 ?
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],1);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.w,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ) :
                            _turnuva_katilimci_Listesi[1] != null ?
                            GestureDetector(
                              onTap: (){
                                _showPicker(context,index,snapshot.data.docs[index]['index'],1);

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 67.66666666666667.w,
                                      height: 68.0.h,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(_turnuva_katilimci_Listesi[1].avatarImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(_turnuva_katilimci_Listesi[1].adsoyad.toString(),
                                        style:  TextStyle(
                                            color:  const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13.3.spByWidth
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ) :
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],1);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.h,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ) :
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],1);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.h,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ) ,


                          ],
                        ),
                      ),
                    ),
                  ) :


                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 110.0.h,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _turnuva_katilimci_Listesi.length <= index+1 ?
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+1);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.h,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ) :
                            _turnuva_katilimci_Listesi[index+1] !=null ?
                            GestureDetector(
                              onTap: (){
                                _showPicker(context,index,snapshot.data.docs[index]['index'],index+1);
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(top: 10.0.h),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 67.66666666666667.w,
                                      height: 68.0.h,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(_turnuva_katilimci_Listesi[index+1].avatarImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(_turnuva_katilimci_Listesi[index+1].adsoyad.toString(),
                                        style:  TextStyle(
                                            color:  const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13.3.spByWidth
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ):
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+1);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.h,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ),
                            Container(
                              width: 38.0.w,
                              height: 38.0.w,
                              decoration: new BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,

                              ),
                              child: Center(
                                child: Text(
                                  "VS",
                                  style:  TextStyle(
                                      color:  const Color(0xff343633),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 16.0.spByWidth
                                  ),

                                ),
                              ),
                            ),
                            snapshot.data.docs[index]['user2foto'] != null ?
                            _turnuva_katilimci_Listesi.length < index+2 ?
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+2);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.w,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ):
                            _turnuva_katilimci_Listesi[index+2] !=null ?
                            GestureDetector(
                              onTap: (){
                                _showPicker(context,index,snapshot.data.docs[index]['index'],index+2);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 67.66666666666667.w,
                                      height: 68.0.w,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(_turnuva_katilimci_Listesi[index+2].avatarImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(_turnuva_katilimci_Listesi[index+2].adsoyad.toString(),
                                        style:  TextStyle(
                                            color:  const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13.3.spByWidth
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ) :
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+2);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.w,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ) :
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+2);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.w,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  );
                },
              );

            },
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 20.0.w),
            child: MyButton(text: "Değişiklikleri Kaydet", textColor: null, fontSize: 12.0.spByWidth, width: MediaQuery.of(context).size.width, height: 50,
              onPressed:() async {
                if (_turnuva_eslesmeyenler_Listesi.length > 0) {
                  var dialogBilgi = AlertBilgilendirme(
                    message: "Lütfen Bütün Katılımcıları Eşleştiriniz!",
                    onPostivePressed: () {
                      Navigator.pop(context);
                    },
                  );

                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialogBilgi);
                } else {
                  for (var snap in _turnuva_katilimci_Listesi_orjinal) {
                    await FirebaseFirestore.instance.collection("etkinlik").doc(
                        widget.card.id).collection("katilimciList").doc(
                        snap.userId).delete();
                  }
                  int j = 0;
                  for (var snap in _turnuva_katilimci_Listesi) {
                    j++;
                    Map<String, dynamic> KatilimciList = Map();
                    KatilimciList['userid'] = snap.userId;
                    KatilimciList['index'] = j;
                    await FirebaseFirestore.instance.collection("etkinlik").doc(
                        widget.card.id).collection("katilimciList").doc(
                        snap.userId).set(KatilimciList);
                  }
                  int i = 0;
                  for (DocumentSnapshot snap in etkinlikCardId) {
                    Map<String, dynamic> etkinliklerimKatilimci = Map();
                    if (i == 0) {
                      etkinliklerimKatilimci['user1ad'] =
                          _turnuva_katilimci_Listesi[0].adsoyad;
                      etkinliklerimKatilimci['user1foto'] =
                          _turnuva_katilimci_Listesi[0].avatarImageUrl;
                      etkinliklerimKatilimci['userid1'] =
                          _turnuva_katilimci_Listesi[0].userId;

                      etkinliklerimKatilimci['user2ad'] =
                          _turnuva_katilimci_Listesi[1].adsoyad;
                      etkinliklerimKatilimci['user2foto'] =
                          _turnuva_katilimci_Listesi[1].avatarImageUrl;
                      etkinliklerimKatilimci['userid2'] =
                          _turnuva_katilimci_Listesi[1].userId;
                    }
                    else {
                      etkinliklerimKatilimci['user1ad'] =
                          _turnuva_katilimci_Listesi[i + 1].adsoyad;
                      etkinliklerimKatilimci['user1foto'] =
                          _turnuva_katilimci_Listesi[i + 1].avatarImageUrl;
                      etkinliklerimKatilimci['userid1'] =
                          _turnuva_katilimci_Listesi[i + 1].userId;

                      etkinliklerimKatilimci['user2ad'] =
                          _turnuva_katilimci_Listesi[i + 2].adsoyad;
                      etkinliklerimKatilimci['user2foto'] =
                          _turnuva_katilimci_Listesi[i + 2].avatarImageUrl;
                      etkinliklerimKatilimci['userid2'] =
                          _turnuva_katilimci_Listesi[i + 2].userId;
                    }


                    i++;
                    await FirebaseFirestore.instance.collection("etkinlik").doc(
                        widget.card.id).collection("katilimcilar").doc(
                        snap['carid']).update(etkinliklerimKatilimci);
                  }

                  var dialogBilgi = AlertBilgilendirme(
                    message: "Eşleştirme Tamamlandı.",
                    onPostivePressed: () {
                      Navigator.pop(context);
                    },
                  );

                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialogBilgi);
                }
              }

              ),
          ),
        ],
      ),
    );
  }

  Future<QuerySnapshot> filtrelistreamkullanilan() async {

  QuerySnapshot qn= await FirebaseFirestore.instance.collection("etkinlik").doc(widget.card.id).collection("katilimcilar").orderBy("index",descending: false).get();
  etkinlikCardId.clear();
  etkinlikCardId.addAll(qn.docs);
  return qn;
  }



  void _showPicker(context,int index,int cardindex,int kisiindex) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 25.0.w,top: 10.0.h),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Eşleşenler:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),)),
                ),
                Container(
                  height: 160.0.h,
                  child: ListView.builder(
                  shrinkWrap: true,

                  itemCount: _turnuva_katilimci_Listesi_orjinal.length,
                  itemBuilder: (_, int index) {


                   return _turnuva_katilimci_Listesi[index] != null ?
                   ResimliCard(textSubtitle: _turnuva_katilimci_Listesi[index].meslek, textTitle: _turnuva_katilimci_Listesi[index].adsoyad.toString(),
                       onPressed: (){

                     //print("kisi kim liste: "+_turnuva_katilimci_Listesi[index].adsoyad+"  index:"+index.toString());

                     //print("tiklanan kisi kim kart: "+_turnuva_katilimci_Listesi[kisiindex].adsoyad+" index:"+kisiindex.toString());
                    if(kisiindex==0){
                      _turnuva_eslesmeyenler_Listesi.add( _turnuva_katilimci_Listesi[0]);
                      _turnuva_katilimci_Listesi[0]=_turnuva_katilimci_Listesi[index];
                      _turnuva_katilimci_Listesi[index]=null;

                    }else if(kisiindex==1){
                      _turnuva_eslesmeyenler_Listesi.add( _turnuva_katilimci_Listesi[1]);
                      _turnuva_katilimci_Listesi[1]=_turnuva_katilimci_Listesi[index];
                      _turnuva_katilimci_Listesi[index]=null;

                    }else{
                      _turnuva_eslesmeyenler_Listesi.add( _turnuva_katilimci_Listesi[kisiindex]);
                      _turnuva_katilimci_Listesi[kisiindex]=_turnuva_katilimci_Listesi[index];
                      _turnuva_katilimci_Listesi[index]=null;
                    }


                    setState(() {

                    });

                     Navigator.pop(context);

                   }, fontSize: 12,
                       img: _turnuva_katilimci_Listesi[index].avatarImageUrl.toString(), tarih: "") : Text((_turnuva_katilimci_Listesi_orjinal.length-_turnuva_eslesmeyenler_Listesi.length).toString());
                  },
            ),
                ),

                Padding(
                  padding:  EdgeInsets.only(left: 25.0.w,top: 10.0.h),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Eşleşmeyenler:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                ),
                ListView.builder(

                  shrinkWrap: true,
                  itemCount: _turnuva_eslesmeyenler_Listesi.length,
                  itemBuilder: (_, int index) {

                    return  ResimliCard(textSubtitle: _turnuva_eslesmeyenler_Listesi[index].meslek, textTitle: _turnuva_eslesmeyenler_Listesi[index].adsoyad.toString(), onPressed: (){

                      _turnuva_eslesmeyenler_Listesi.add(_turnuva_katilimci_Listesi[kisiindex]);
                      _turnuva_katilimci_Listesi[kisiindex]=_turnuva_eslesmeyenler_Listesi[index];
                      _turnuva_eslesmeyenler_Listesi.remove(_turnuva_eslesmeyenler_Listesi[index]);

                      setState(() {

                      });
                      Navigator.pop(context);

                    }, fontSize: 12.0.spByWidth,
                        img: _turnuva_eslesmeyenler_Listesi[index].avatarImageUrl.toString(), tarih: "");
                  },
                ),
              ],
            ),
          );
        });
  }


  void _showPickerKimseYok(context,int index,int cardindex,int kisiindex) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Column(
              children: [
                Center(child: Text("Eşleşenler:")),
                Container(
                  height: 160.0.h,
                  child: ListView.builder(
                    shrinkWrap: true,

                    itemCount: _turnuva_katilimci_Listesi_orjinal.length,
                    itemBuilder: (_, int index) {


                      return _turnuva_katilimci_Listesi[index] != null ? ResimliCard(textSubtitle: _turnuva_katilimci_Listesi[index].meslek, textTitle: _turnuva_katilimci_Listesi[index].adsoyad.toString(), onPressed: (){

                        _turnuva_katilimci_Listesi[kisiindex]=_turnuva_eslesmeyenler_Listesi[index];
                        _turnuva_eslesmeyenler_Listesi.remove(_turnuva_eslesmeyenler_Listesi[index]);
                        setState(() {

                        });
                        Navigator.pop(context);

                      }, fontSize: 12.0.spByWidth,
                          img: _turnuva_katilimci_Listesi[index].avatarImageUrl.toString(), tarih: "") : Container();
                    },
                  ),
                ),
                Center(child: Text("Eşleşmeyenler:")),
                ListView.builder(

                  shrinkWrap: true,
                  itemCount: _turnuva_eslesmeyenler_Listesi.length,
                  itemBuilder: (_, int index) {


                    return  ResimliCard(textSubtitle: _turnuva_eslesmeyenler_Listesi[index].meslek, textTitle: _turnuva_eslesmeyenler_Listesi[index].adsoyad.toString(), onPressed: (){

                      print("kisiindex:"+kisiindex.toString());
                      print("index:"+index.toString());
                     // _turnuva_katilimci_Listesi[index]=_turnuva_eslesmeyenler_Listesi[index];
                     // _turnuva_eslesmeyenler_Listesi.remove(_turnuva_eslesmeyenler_Listesi[index]);
                      if(kisiindex==0)
                      {
                        _turnuva_katilimci_Listesi[kisiindex]=_turnuva_eslesmeyenler_Listesi[index];
                        _turnuva_eslesmeyenler_Listesi.removeAt(index);
                      }else{
                        _turnuva_katilimci_Listesi[kisiindex]=_turnuva_eslesmeyenler_Listesi[index];
                        _turnuva_eslesmeyenler_Listesi.removeAt(index);
                      }

                      setState(() {

                      });
                      Navigator.pop(context);

                    }, fontSize: 12.0.spByWidth,
                        img: _turnuva_eslesmeyenler_Listesi[index].avatarImageUrl.toString(), tarih: "");
                  },
                ),
              ],
            ),
          );
        });
  }

}
