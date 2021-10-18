import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/GelenKutusuBolumler/adminreklamIcerik.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminSikayetIcerik.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class Diger extends StatefulWidget {
  @override
  _DigerState createState() => _DigerState();
}

class _DigerState extends State<Diger> {
  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();

  String zaman="";
  final f = new DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.appbarGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
        toolbarHeight: 70.0.h,
        title: Text(
            "Diğer",
            style:  TextStyle(
                color: Renkler.appbarTextColor ,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle:  FontStyle.normal,
                fontSize: 20.0.sp
            ),
            textAlign: TextAlign.center
        ),
        leading:  Padding(
          padding:  EdgeInsets.only(left: 20.0.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,size: 20.0.w,),
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

              SizedBox(height: 40.0.h,),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('iletisim').doc("diger").collection("digerleri").orderBy('tarih',descending: true).snapshots(),
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
                      DateTime _tarih = _card['tarih'].toDate();

                      DateTime dateTimeNow = DateTime.now();
                      final differenceInHours = dateTimeNow.difference(_tarih).inHours;


                      if(differenceInHours.abs() < 24)
                      {
                        zaman= _tarih.toString().substring(11,16);
                      }else{
                        zaman= formatTheDate(_tarih, format: DateFormat("dd.MM.y"));
                      }
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.45,
                        child: ResimliCard(textSubtitle: _card['mesaj'].toString(), textTitle: _card['gonderenIsim'].toString(),
                          fontSize: 20.0.spByWidth,
                          img: _card['gonderenFoto'].toString(),
                          tarih: zaman,
                          onPressed: (){

                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AdminReklamIcerik(card: _card,tarih: formatTheDate(_tarih, format: DateFormat("dd.MM.y")),)),);
                            _card.reference.update({'okundumu':true});
                          },


                        ),
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
                                  await _adminIslemleri.adminDigerSil(_card);
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
              ),

            ],
          ),
        ),
      ),



    );
  }
}
