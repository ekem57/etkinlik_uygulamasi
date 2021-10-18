import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/profilSayfalari/kullaniciprofili.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class KatilimIstekleri extends StatefulWidget {

  final String etid;

  KatilimIstekleri({this.etid});

  @override
  _KatilimIstekleriState createState() => _KatilimIstekleriState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _KatilimIstekleriState extends State<KatilimIstekleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Katılım İstekleri",
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
//        margin: EdgeInsets.only(top: 32.70),
//        padding: EdgeInsets.symmetric(horizontal: 32.0.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_curve.png"),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child:  StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('etkinlikKatilimİstekleri').doc(widget.etid).collection("katilimcilar").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            final int cardLength2 = snapshot.data.docs.length;


            return ListView.builder(
              itemCount: cardLength2,
              itemBuilder: (_, int index) {
                final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
                return     StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').where("userId",isEqualTo: _cardYonetici['userid']).snapshots(),
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
                        final DocumentSnapshot _card = snapshot.data.docs[index];

                        return    InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card:_card.data() ,)),);

                          },
                          child: Padding(
                            padding:  EdgeInsets.all(8.0.h),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(_card['avatarImageUrl'].toString()),
                                radius: 25.70.w,
                              ),
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                _card['ad'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0.spByWidth),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Container(
                                width: 160.0.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 74.30.w,
                                      height: 24.0.h,
                                      child: RaisedButton(
                                        color: Color(0xfff7cb15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(65.7.w),
                                        ),
                                        onPressed: () {
                                          _firestoreDBService.etkinlikKatilButonu(_cardYonetici['etid'], _cardYonetici['userid']);
                                        },
                                        elevation: 8.3,
                                        child: FittedBox(
                                          child: Text(
                                            "Onayla",
                                            style: TextStyle(
                                                color: const Color(0xff343633),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 11.0.spByWidth),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 74.30.w,
                                      height: 24.0.h,
                                      child: RaisedButton(
                                        color: Color(0xff91c4f2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(65.7.w),
                                        ),
                                        onPressed: () {
                                          _firestoreDBService.etkinlikKatilmaktanReddetButonu(_cardYonetici['etid'], _cardYonetici['userid']);
                                        },
                                        elevation: 8.3,
                                        child: FittedBox(
                                          child: Text(
                                            "Reddet",
                                            style: TextStyle(
                                                color: const Color(0xff343633),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 11.0.spByWidth),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );

                      },
                    );

                  },
                );

              },
            );





          },
        ),


      ),
    );
  }
}
