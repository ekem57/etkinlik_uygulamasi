import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EslestirmeNew extends StatefulWidget {
  final DocumentSnapshot card;

  EslestirmeNew({this.card});
  @override
  _EslestirmeNewState createState() => _EslestirmeNewState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
class _EslestirmeNewState extends State<EslestirmeNew> {
  List<Users> _turnuva_katilimci_Listesi_orjinal=[];
  List<Users> _turnuva_katilimci_Listesi=[];
  List<String> _turnuva_katilimci_Listesi_User_Idler=[];
  List<Users> _turnuva_eslesmeyenler_Listesi=[];
  List<Users> turnuva_index_Listesi=[];
  List<Users> Son_Kullanicilar_Listesi=[];
  List<int> index_listesi=[];
  List<DocumentSnapshot> etkinlikCardId=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    katilimciListesigetir();
  }



  int enbuyukindex=0;
  Future<void> katilimciListesigetir() async {

    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("etkinlik").doc(widget.card.id).collection("katilimciList").orderBy("index",descending: false).get();
    print("gelen son kullanıcı:"+querySnapshot.docs.last['index'].toString());
     int grupsayisi= querySnapshot.docs.last['index'];
    int olusanSatir =  grupsayisi % 2 == 1 ? ((grupsayisi/2)+1).floor() : ((grupsayisi/2)).ceil();

    for(int i=0; i< olusanSatir*2;i++){
      Son_Kullanicilar_Listesi.add(null);
      _turnuva_katilimci_Listesi.add(null);
      _turnuva_katilimci_Listesi_orjinal.add(null);
      _turnuva_katilimci_Listesi_User_Idler.add(null);
    }

    print("gelen son kullanıcı liste uzunluk:"+Son_Kullanicilar_Listesi.length.toString());
    for (DocumentSnapshot snap in querySnapshot.docs) {

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(snap['userid']).get();
      _turnuva_katilimci_Listesi[snap['index']-1]=Users.fromMap(documentSnapshot.data());
      _turnuva_katilimci_Listesi_orjinal[snap['index']-1]=Users.fromMap(documentSnapshot.data());

      Son_Kullanicilar_Listesi[snap['index']-1]= Users.fromMap(documentSnapshot.data());
      _turnuva_katilimci_Listesi_User_Idler[snap['index']-1]=Users.fromMap(documentSnapshot.data()).userId;
      if(enbuyukindex==0){
        enbuyukindex=snap['index'];
      }else if(snap['index'] > enbuyukindex){
        enbuyukindex=snap['index'];
      }

      index_listesi.add(snap['index']);

      print("user id index:"+ (snap['index']-1).toString()+"  adı:"+_turnuva_katilimci_Listesi[snap['index']-1].adsoyad);
    }

    setState(() {

    });
    print("katilimci list lenght:"+_turnuva_katilimci_Listesi.length.toString());
    print("katilimci list en buyuk index:"+enbuyukindex.toString());
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
            size: 17.0.w,
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
            future: futureget(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              final int cardLength = snapshot.data.docs.length;
              //ikiside tam ise gelen
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: enbuyukindex % 2 == 1 ? ((enbuyukindex/2)+1).floor() : ((enbuyukindex/2)).ceil(),
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
                    padding: EdgeInsets.all(12.0.w),
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
                                _showPicker(context,index,snapshot.data.docs[index]['index'],0);
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
                                          image: NetworkImage(_turnuva_katilimci_Listesi[0].avatarImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(3.0.w),
                                      child: Text(_turnuva_katilimci_Listesi[0].adsoyad.toString(),
                                        style: TextStyle(
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
                              height: 38.0.h,
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

                            _turnuva_katilimci_Listesi.length <= 1 ?
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
                                      padding: EdgeInsets.all(3.0.w),
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
                            ) ,


                          ],
                        ),
                      ),
                    ),
                  )
                      :


                  Padding(
                    padding: EdgeInsets.all(12.0.w),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 110.0.h,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0.w),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            enbuyukindex <= index+1
                                ?
                            GestureDetector(
                              onTap: (){
                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+(index));
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
                            _turnuva_katilimci_Listesi[index+(index)] !=null ?
                            GestureDetector(
                              onTap: (){
                                _showPicker(context,index,snapshot.data.docs[index]['index'],index+(index));
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
                                          image: NetworkImage(_turnuva_katilimci_Listesi[index+(index)].avatarImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(3.0.w),
                                      child: Text(_turnuva_katilimci_Listesi[index+(index)].adsoyad.toString(),
                                        style: TextStyle(
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

                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+(index));
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
                              height: 38.0.h,
                              decoration: new BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,

                              ),
                              child: Center(
                                child: Text(
                                  "VS",
                                  style: TextStyle(
                                      color:  const Color(0xff343633),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 16.0.spByWidth
                                  ),

                                ),
                              ),
                            ),

                            _turnuva_katilimci_Listesi.length < index+1 ?
                            GestureDetector(
                              onTap: (){

                                _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+(index+1));
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
                            ):
                               _turnuva_katilimci_Listesi[index+(index+1)] != null ?
                            GestureDetector(
                              onTap: (){
                                _showPicker(context,index,snapshot.data.docs[index]['index'],index+(index+1));
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
                                          image: NetworkImage(_turnuva_katilimci_Listesi[index+(index+1)].avatarImageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3.0.w),
                                      child: Text(_turnuva_katilimci_Listesi[index+(index+1)].adsoyad.toString(),
                                        style: TextStyle(
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
                                print((index+(index+1)).toString());
                                if(enbuyukindex % 2 == 1){
                                  if(enbuyukindex==(index+(index+1))){

                                  }else{
                                    _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+(index+1));

                                  }
                                }else{
                                  _showPickerKimseYok(context,index,snapshot.data.docs[index]['index'],index+(index+1));

                                }
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
                  );
                },
              );

            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 20.0.w),
            child: MyButton(text: "Değişiklikleri Kaydet", textColor: null, fontSize: 12.0.spByWidth, width: MediaQuery.of(context).size.width, height: 50.0.h,
                onPressed:() async {
                  int listedekiuser=0;
                  for(var item in _turnuva_katilimci_Listesi){

                    if(item !=null){
                      listedekiuser++;
                    }
                  }
                  if (index_listesi.length  !=  listedekiuser) {
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





                    for (var snap in Son_Kullanicilar_Listesi) {
                      if(snap != null) {
                        await FirebaseFirestore.instance.collection("etkinlik")
                            .doc(
                            widget.card.id).collection("katilimciList").doc(
                            snap.userId)
                            .delete();
                      }
                    }
                    int j = 0;
                    for (var snap in _turnuva_katilimci_Listesi) {
                      j++;
                      if(snap != null) {
                        Map<String, dynamic> KatilimciList = Map();
                        KatilimciList['userid'] = snap.userId;
                        KatilimciList['katilmaYorumu'] = false;
                        KatilimciList['index'] = j;
                        await FirebaseFirestore.instance.collection("etkinlik")
                            .doc(
                            widget.card.id).collection("katilimciList").doc(
                            snap.userId)
                            .set(KatilimciList);
                      }
                    }



                    ///buraya bak


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
                        if(_turnuva_katilimci_Listesi[i+(i)]==null){
                          etkinliklerimKatilimci['user1ad'] = null;
                          etkinliklerimKatilimci['user1foto'] = null;
                          etkinliklerimKatilimci['userid1'] = null;
                        }else{
                          etkinliklerimKatilimci['user1ad'] =
                              _turnuva_katilimci_Listesi[i+(i)].adsoyad;
                          etkinliklerimKatilimci['user1foto'] =
                              _turnuva_katilimci_Listesi[i+(i)].avatarImageUrl;
                          etkinliklerimKatilimci['userid1'] =
                              _turnuva_katilimci_Listesi[i+(i)].userId;
                        }



                          if(_turnuva_katilimci_Listesi[i+(i+1)]==null){
                            etkinliklerimKatilimci['user2ad'] = null;
                            etkinliklerimKatilimci['user2foto'] = null;
                            etkinliklerimKatilimci['userid2'] = null;
                          }else{
                            etkinliklerimKatilimci['user2ad'] =
                                _turnuva_katilimci_Listesi[i+(i+1)].adsoyad;
                            etkinliklerimKatilimci['user2foto'] =
                                _turnuva_katilimci_Listesi[i+(i+1)].avatarImageUrl;
                            etkinliklerimKatilimci['userid2'] =
                                _turnuva_katilimci_Listesi[i+(i+1)].userId;
                          }


                      }

                      i++;

                      print("et id:"+snap['carid'].toString());


                      etkinliklerimKatilimci['index'] = i;

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

  Future<QuerySnapshot> futureget() async {

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
            child: ListView(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 25.0.w,top: 10.0.h),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Turnuvadakiler:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),)),
                ),
                Container(
                  height: 320.0.h,
                  child: ListView.builder(
                    shrinkWrap: true,

                    itemCount: Son_Kullanicilar_Listesi.length,
                    itemBuilder: (_, int index) {


                      return Son_Kullanicilar_Listesi[index] != null ?
                      ResimliCard(textSubtitle: Son_Kullanicilar_Listesi[index].meslek, textTitle: Son_Kullanicilar_Listesi[index].adsoyad.toString(),
                          backcolor: _turnuva_katilimci_Listesi_User_Idler.indexOf(Son_Kullanicilar_Listesi[index].userId) == -1 ? Colors.blue :  Theme.of(context).backgroundColor,
                          onPressed: (){



                            int veri = _turnuva_katilimci_Listesi_User_Idler.indexOf(Son_Kullanicilar_Listesi[index].userId);
                            print("gelen veri:"+veri.toString());

                            veri != -1 ?  _turnuva_katilimci_Listesi[veri]=null : null;

                            _turnuva_katilimci_Listesi[kisiindex]=Son_Kullanicilar_Listesi[index];

                            _turnuva_katilimci_Listesi_User_Idler[kisiindex]=Son_Kullanicilar_Listesi[index].userId;


                            Navigator.pop(context);

                            setState(() {

                            });


                          }, fontSize: 12.0.spByWidth,
                          img: Son_Kullanicilar_Listesi[index].avatarImageUrl.toString(), tarih: "") : Container();
                    },
                  ),
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
                Center(child: Text("Turnuvadakiler:",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),)),
                Container(
                  height: 320.0.h,
                  child: ListView.builder(
                    shrinkWrap: true,

                    itemCount: Son_Kullanicilar_Listesi.length,
                    itemBuilder: (_, int index) {


                      return Son_Kullanicilar_Listesi[index] != null ? ResimliCard(textSubtitle: Son_Kullanicilar_Listesi[index].meslek, textTitle: Son_Kullanicilar_Listesi[index].adsoyad.toString(),
                          backcolor: _turnuva_katilimci_Listesi_User_Idler.indexOf(Son_Kullanicilar_Listesi[index].userId) == -1 ? Colors.blue :  Theme.of(context).backgroundColor,
                          onPressed: (){


                        int veri = _turnuva_katilimci_Listesi_User_Idler.indexOf(Son_Kullanicilar_Listesi[index].userId);
                        print("gelen veri:"+veri.toString());

                        veri != -1 ?  _turnuva_katilimci_Listesi[veri]= null : null;

                        _turnuva_katilimci_Listesi[kisiindex]=Son_Kullanicilar_Listesi[index];

                        _turnuva_katilimci_Listesi_User_Idler[kisiindex]=Son_Kullanicilar_Listesi[index].userId;


                        Navigator.pop(context);

                        setState(() {

                        });



                      }, fontSize: 12.0.spByWidth,
                          img: Son_Kullanicilar_Listesi[index].avatarImageUrl.toString(), tarih: ""): Container();
                    },
                  ),
                ),

              ],
            ),
          );
        });
  }

}
