import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminSikayetIcerik.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:intl/intl.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class KatilimciOyla extends StatefulWidget {
  DocumentSnapshot card;
  KatilimciOyla({this.card});
  @override
  _KatilimciOylaState createState() => _KatilimciOylaState();
}

class _KatilimciOylaState extends State<KatilimciOyla> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("gelen card:"+widget.card.data().toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
        toolbarHeight: 70.0,
        title: Text(
            "Etkinliğe Katılanları Oyla",
            style:  TextStyle(
                color: Renkler.appbarTextColor ,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle:  FontStyle.normal,
                fontSize: 20.0
            ),
            textAlign: TextAlign.center
        ),
        leading:  Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
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

              SizedBox(height: 40,),
              StreamBuilder<QuerySnapshot>(
                stream: widget.card['etkinlikTipi'] == "Turnuva" ? FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimciList").snapshots()
                    : FirebaseFirestore.instance.collection('etkinlik').doc(widget.card.id).collection("katilimcilar").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  final int cardLength = snapshot.data.docs.length;

                  return cardLength == 0 ?
                  Center(child: Text("Katılımcı Yok")) :
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
                      print("gelen kişi:"+_cardYonetici['userid']);
                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection('users').doc(_cardYonetici['userid'].toString()).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final DocumentSnapshot _card = snapshot.data;



                          return  Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 21.0, vertical: 7.0),
                            child:  GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 110.0.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(11.70)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0x26000000),
                                          offset: Offset(0, 0),
                                          blurRadius: 5.50,
                                          spreadRadius: 0.5)
                                    ],
                                    color: Theme.of(context).backgroundColor),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        _card['ad'].toString(),
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.7.h),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(_card['avatarImageUrl'].toString()),
                                        radius: 26.0,
                                      ),
                                      trailing: Padding(
                                        padding: EdgeInsets.only(top: 4.0.h),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                             "",
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Arial",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.3.h),
                                            ),
                                          ],
                                        ),
                                      ),

                                      subtitle: Text(
                                        _card['meslek'].toString(),
                                        style: TextStyle(
                                            color: const Color(0xff343633),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 13.3.h),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    _cardYonetici['katilmaYorumu'] == false ?   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 120.0.w,
                                          child: RaisedButton(color: Colors.green,
                                            child: Text("Katıldı"),
                                            onPressed: (){
                                              _card.reference.update({'etkinlikKatildi':FieldValue.increment(1)});
                                              _cardYonetici.reference.update({'katilmaYorumu':true});

                                            },),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 120.0.w,
                                          child: RaisedButton(color: Colors.red,
                                            child: Text("Katılmadı"),
                                            onPressed: (){
                                              _card.reference.update({'etkinlikKatilmadi':FieldValue.increment(1)});
                                              _cardYonetici.reference.update({'katilmaYorumu':true});
                                            },),
                                        ),
                                      ],
                                    ) : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Yorum Yapıldı",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );

                },
              ),

            ],
          ),
        ),
      ),



    );
  }
}
