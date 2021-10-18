import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/GelenKutusuBolumler/mavitikicerik.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminSikayetIcerik.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:intl/intl.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class AdminMaviTalepleri extends StatefulWidget {
  @override
  _AdminMaviTalepleriState createState() => _AdminMaviTalepleriState();
}

class _AdminMaviTalepleriState extends State<AdminMaviTalepleri> {

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
        toolbarHeight: 70.0,
        title: Text(
            "Mavi Tik Talepleri",
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
                stream: FirebaseFirestore.instance.collection('iletisim').doc("mavitik").collection("mavitikler").orderBy('tarih',descending: true).snapshots(),
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
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>MaviTikIcerik(card: _card,tarih: formatTheDate(_tarih, format: DateFormat("dd.MM.y")),)),);
                                      _card.reference.update({'okundumu':true});
                                  },
                                  child: ListTile(
                                    title: Text(
                                      _card['gonderenIsim'].toString(),
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7.h),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(_card['gonderenFoto'].toString()),
                                      radius: 26.0,
                                    ),
                                    trailing: Padding(
                                      padding: EdgeInsets.only(top: 4.0.h),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            zaman.toString(),
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
                                      _card['mesaj'].toString(),
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 13.3.h),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 120.0.w,
                                      child: RaisedButton(color: Colors.blue,
                                        child: Text("Onayla"),
                                        onPressed: (){
                                        FirebaseFirestore.instance.collection("users").doc(_card['gonderenUserId']).update({'mavitik':true});
                                        _card.reference.delete();
                                        var dialogBilgi = AlertBilgilendirme(
                                          message: "Mavi Tik Verildi.",
                                          onPostivePressed: (){
                                            Navigator.pop(context);
                                          },
                                        );

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => dialogBilgi);
                                        },),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 120.0.w,
                                      child: RaisedButton(color: Colors.blue,
                                        child: Text("Reddet"),
                                        onPressed: (){

                                          FirebaseFirestore.instance.collection('iletisim').doc("mavitik").collection("mavitikler").doc(_card.id).delete();
                                        },),
                                    ),
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
              ),

            ],
          ),
        ),
      ),



    );
  }
}
