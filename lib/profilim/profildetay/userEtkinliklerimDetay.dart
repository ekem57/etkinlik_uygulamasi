import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/etkinlikler/turnuva/katilimcilar.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/profilim/eslesmeSayfasi.dart';
import 'package:etkinlik_kafasi/profilim/profildetay/etkinliklerimkatilimciListele.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/views/etkinliklerimEslesmeSayfasi.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

import '../katilimciOyla.dart';

class userEtkinlikDetay extends StatefulWidget {
  final EtkinlikModel etkinlikBilgileri;
  final DocumentSnapshot card;

  const userEtkinlikDetay({Key key, this.etkinlikBilgileri,this.card}) : super(key: key);

  @override
  _userEtkinlikDetayState createState() => _userEtkinlikDetayState();
}

class _userEtkinlikDetayState extends State<userEtkinlikDetay> {

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  List<DocumentSnapshot> userListe=[];
  QuerySnapshot qn;

  ScrollController _scrollController;
  //Offset state <-------------------------------------
  double offset = 0.0 ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    katilimcilariGetir().then((value) {


      userGetir(value.docs);


    });


  }

  Future<QuerySnapshot> katilimcilariGetir() async {
    qn =   await  FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").get();

    return qn;

  }
  Future<void> userGetir(List<QueryDocumentSnapshot> gelenliste) async {
    if(qn.docs.length==1){
      DocumentSnapshot documentSnapshot=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[0]['userid'].toString()).get();
      userListe.add(documentSnapshot);

    }else if(qn.docs.length==2){
      DocumentSnapshot documentSnapshot=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[0]['userid'].toString()).get();
      DocumentSnapshot documentSnapshot1=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[1]['userid'].toString()).get();

      userListe.add(documentSnapshot);
      userListe.add(documentSnapshot1);
    }
    else if(qn.docs.length==3){
      DocumentSnapshot documentSnapshot=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[0]['userid'].toString()).get();
      DocumentSnapshot documentSnapshot1=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[1]['userid'].toString()).get();
      DocumentSnapshot documentSnapshot2=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[2]['userid'].toString()).get();

      userListe.add(documentSnapshot);
      userListe.add(documentSnapshot1);
      userListe.add(documentSnapshot2);
    }
    else if(qn.docs.length==3){
      DocumentSnapshot documentSnapshot=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[0]['userid'].toString()).get();
      DocumentSnapshot documentSnapshot1=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[1]['userid'].toString()).get();
      DocumentSnapshot documentSnapshot2=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[2]['userid'].toString()).get();
      DocumentSnapshot documentSnapshot3=  await FirebaseFirestore.instance.collection('users').doc(gelenliste[3]['userid'].toString()).get();

      userListe.add(documentSnapshot);
      userListe.add(documentSnapshot1);
      userListe.add(documentSnapshot2);
      userListe.add(documentSnapshot3);
    }

    setState(() {

    });

  }




  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    double _bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xffffffff),
            size: 17.0.h,
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
        brightness: Brightness.light, // status bar brightness
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Positioned(
              top: 0,
              bottom: MediaQuery.of(context).size.height * 0.76,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(widget.etkinlikBilgileri.etkinlikFoto),
                    )),
              ),
            ),
            Positioned(
              bottom: 0.0,
              top: MediaQuery.of(context).size.height * 0.20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0.w),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(35.0.w, 0.0.h, 10.0.w, 33.0.h),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("usersEtkinlikFavori").doc(_userModel.user.userId).collection("katilimci").where('etid',isEqualTo: widget.etkinlikBilgileri.etid )
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {

                                if (!snapshot.hasData) return Container();

                                return  snapshot.data.docs.toString() == "[]" ?
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: (){

                                      _firestoreDBService.etkinlikFavla(_userModel.user.userId, widget.card['etid']);

                                    },
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                      size: 25.0.w,
                                    ),
                                  ),
                                ): snapshot.data.docs[0]['onay'] == true ?
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: (){


                                      _firestoreDBService.etkinlikFavdanCik(_userModel.user.userId, widget.card['etid']);
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 25.0.w,
                                    ),
                                  ),
                                ):
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: (){
                                      _firestoreDBService.etkinlikFavla(_userModel.user.userId, widget.card['etid']);
                                    },
                                    icon: Icon(
                                      Icons.favorite_border_sharp,
                                      color: Colors.grey,
                                      size: 25.0.w,
                                    ),
                                  ),
                                );
                              }),
                          Wrap(
                            children: [
                              Text(widget.etkinlikBilgileri.baslik.toString(),
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'OpenSans',
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.3.spByWidth),
                                textAlign: TextAlign.left,

                              ),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 21.0.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 20.0.h,
                          ),
                          SizedBox(
                            width: 13.0.w,
                          ),
                          Text(formatTheDate(widget.etkinlikBilgileri.tarih),
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      SizedBox(
                        height: 21.0.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 20.0.h,
                          ),
                          SizedBox(
                            width: 13.0.w,
                          ),
                          Text(widget.etkinlikBilgileri.saat,
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      SizedBox(
                        height: 21.0.h,
                      ),
                      Row(
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
                          Icon(
                            Icons.check,
                            color: Theme.of(context).accentColor,
                            size: 20.0.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 21.0.h,
                      ),
                      Row(
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
                      ),
                      SizedBox(
                        height: 21.0.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(_userModel.user.uyelikTipi=="standart"){
                            var dialogBilgi = AlertBilgilendirme(
                              message: "Standart Paketde Etkinliğe Katılanlara Erişemezsiniz.",
                              onPostivePressed: (){
                                Navigator.pop(context);
                              },
                            );

                            showDialog(
                                context: context,
                                builder: (BuildContext context) => dialogBilgi);
                          }else{

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => Katilimcilar(
                                  qn: qn,
                                )));

                          }

                        },
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (_, int index) {


                            return userListe.isEmpty == true ? Container() :

                            userListe.length == 1 ?
                            Row(
                              children: [
                                Container(
                                  width: 100.0.w,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(userListe[0]['avatarImageUrl'].toString()),
                                        radius: 20.0.w,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 13.0.w,
                                ),
                              widget.etkinlikBilgileri.katilimci == 1 ?
                              widget.etkinlikBilgileri.katilimci-1 == 0 ? Container() :  Text("+${widget.etkinlikBilgileri.katilimci-1}",

                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center) : Text(""),

                              ],
                            ) :
                            userListe.length == 2 ?
                            Row(
                              children: [
                                Container(
                                  width: 100.0.w,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(userListe[0]['avatarImageUrl'].toString()),
                                        radius: 20.0.w,
                                      ),
                                      Positioned(
                                        left: 21.0.w,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(userListe[1]['avatarImageUrl'].toString()),
                                          radius: 20.0.w,
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 13.0.w,
                                ),
                                widget.etkinlikBilgileri.katilimci == 2 ?
                                widget.etkinlikBilgileri.katilimci-2 == 0 ? Container() :  Text("+${widget.etkinlikBilgileri.katilimci-2}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center) : Text(""),

                              ],
                            ) :
                            userListe.length == 3 ?
                            Row(
                              children: [
                                Container(
                                  width: 100.0.w,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(userListe[0]['avatarImageUrl'].toString()),
                                        radius: 20.0.w,
                                      ),
                                      Positioned(
                                        left: 21.0,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(userListe[1]['avatarImageUrl'].toString()),
                                          radius: 20.0.w,
                                        ),
                                      ),
                                      Positioned(
                                        left: 21.0 * 2,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(userListe[2]['avatarImageUrl'].toString()),
                                          radius: 20.0.w,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 13.0.w,
                                ),
                                widget.etkinlikBilgileri.katilimci == 3 ?
                                widget.etkinlikBilgileri.katilimci-3 == 0 ? Container() :  Text("+${widget.etkinlikBilgileri.katilimci-3}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center) : Text(""),

                              ],
                            ) :
                            Row(
                              children: [
                                Container(
                                  width: 100.0.w,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(userListe[0]['avatarImageUrl'].toString()),
                                        radius: 20.0.w,
                                      ),
                                      Positioned(
                                        left: 21.0,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(userListe[1]['avatarImageUrl'].toString()),
                                          radius: 20.0.w,
                                        ),
                                      ),
                                      Positioned(
                                        left: 21.0 * 2,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(userListe[2]['avatarImageUrl'].toString()),
                                          radius: 20.0.w,
                                        ),
                                      ),
                                      Positioned(
                                        left: 21.0 * 3,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(userListe[3]['avatarImageUrl'].toString()),
                                          radius: 20.0.w,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 13.0.w,
                                ),
                                widget.etkinlikBilgileri.katilimci == 4 ?
                                widget.etkinlikBilgileri.katilimci-4 == 0 ? Container() :  Text("+${widget.etkinlikBilgileri.katilimci-4}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.center) : Text(""),

                              ],
                            );
                          },
                        ),


                      ),
                      SizedBox(
                        height: 21.0.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("HAKKINDA",
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.7.spByWidth),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 18.0.h,
                      ),
                      Text(widget.etkinlikBilgileri.hakkinda.toString(),
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w400,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0.spByWidth),
                          textAlign: TextAlign.left),

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20.0.h),
                        child: MyButton(text: "Katılımcıları Listele",
                          textColor: Colors.black,
                          fontSize: 18.7.spByWidth,
                          width: MediaQuery.of(context).size.width,
                          height: 43.6.h,
                          butonColor: Theme.of(context).buttonColor,
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => KatilimcilarinListesi(etid: widget.etkinlikBilgileri.etid,)),
                            );
                          },
                        ),
                      ),

                      widget.card['etkinlikTipi'] != "Turnuva" ?
                      Container():
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20.0.h),
                        child: MyButton(text: "Eşleşmeler",
                          textColor: Colors.black,
                          fontSize: 18.7.spByWidth,
                          width: MediaQuery.of(context).size.width,
                          height: 43.6.h,
                          butonColor: Renkler.onayButonColor,
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EslestirmeNew(card: widget.card,)));
                          },
                        ),
                      ),



                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20.0.h),
                        child: MyButton(text: "Katılımcıları Oyla",
                          textColor: Colors.black,
                          fontSize: 18.7,
                          width: MediaQuery.of(context).size.width,
                          height: 43.6.h,
                          butonColor: Renkler.onayButonColor,
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => KatilimciOyla(card: widget.card,)));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }


}
