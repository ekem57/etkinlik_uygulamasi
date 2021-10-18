import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/etkinlikler/etkinliksayfasi/etkinlik_detay.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class Bildirimler extends StatefulWidget {
  @override
  _BildirimlerState createState() => _BildirimlerState();
}

class _BildirimlerState extends State<Bildirimler> {


  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("Bildirimler",
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 21.7.spByWidth),
              textAlign: TextAlign.center),
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
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          brightness: Brightness.light, // status bar brightness
        ),
       body: FutureBuilder<QuerySnapshot>(
         future: FirebaseFirestore.instance
             .collection('users')
             .doc(_userModel.user.userId)
             .collection('bildirimler')
             .orderBy('tarih', descending: true)
             .get(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

           if (!snapshot.hasData){
             return Center(child: CircularProgressIndicator(),);
           }
           final int cardLength = snapshot.data.docs.length;

           return cardLength == 0 ?
           Container(

           ) :
           ListView.builder(
               itemCount: cardLength,
               itemBuilder: (context, index) {
                 DocumentSnapshot _card;
                 final DocumentSnapshot _cardFuture = snapshot.data.docs[index];
                  FirebaseFirestore.instance.collection("etkinlik").doc(_cardFuture['etid']).get().then((value) {
                   _card=value;
                 });
                 return InkWell(
                   onTap: (){
                     _cardFuture["etid"] != null ?  Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (c) => EtkinlikDetay(etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),card: _card,),
                       ),
                     ) : null;
                     _card.reference.update({'okundu':true});
                   },
                   child: Padding(
                     padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 34.0.w),
                     child: Container(
                       width: 291.6666666666667.w,
                       height: 72.0.h,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(11.70)),
                         boxShadow: [
                           BoxShadow(
                               color: const Color(0x36000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
                         ],
                         color: Theme.of(context).backgroundColor,
                       ),
                       child: Center(
                         child: ListTile(
                           title: Text(_cardFuture["icerik"],
                               maxLines: 5,
                               style: TextStyle(

                                   color: const Color(0xff343633),
                                   fontWeight: _cardFuture["okundu"] ? FontWeight.w400 : FontWeight.w600,
                                   fontFamily: "OpenSans",
                                   fontStyle: FontStyle.normal,
                                   fontSize: 13.0.spByWidth),
                               textAlign: TextAlign.start),
                           leading: Padding(
                             padding: const EdgeInsets.only(top: 5),
                             child: Container(
                               width: 15.0.w,
                               height: 15.0.h,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: _cardFuture["okundu"] ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                               ),
                             ),
                           ),
                           trailing: IconButton(
                             onPressed: () {
                               _cardFuture.reference.delete();
                               setState(() {

                               });
                             },
                             icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                           ),
                         ),
                       ),
                     ),
                   ),
                 );
               });

         },
       ),
    );
  }
}
