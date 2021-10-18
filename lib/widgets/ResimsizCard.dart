import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class ResimsizCard extends StatelessWidget {
  final String textTitle;
  final String collec1;
  final String doc;
  final String collec2;
  final VoidCallback onPressed;
  final double bildirimSayisi;



  const ResimsizCard(
      {Key key,
        @required this.textTitle,
        @required this.collec1,
        @required this.doc,
        @required this.collec2,
        @required this.onPressed,
        @required this.bildirimSayisi,
      })
      : assert(textTitle != null ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return  bildirimSayisi != 0 ?
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 10.0.h),
      child:  GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x26000000),
                    offset: Offset(0, 0),
                    blurRadius: 5.50,
                    spreadRadius: 0.5)
              ],
              color: Theme.of(context).backgroundColor),
          child: ListTile(
            title: Text(
              textTitle,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.7.spByWidth),
            ),
            trailing: Container(
                width: 26.0.w,
                height: 26.0.h,
                decoration: BoxDecoration(
                    color: const Color(0xff91c4f2),
                  borderRadius: BorderRadius.circular(20.0.w),
                ),
            child:
             StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(collec1).doc(doc).collection(collec2).where("okundumu",isEqualTo: false).snapshots(),
            builder: (context, snapshot){
            return snapshot.data != null ? Center(child: Text(snapshot.data.docs.length.toString(),style: TextStyle(fontSize: 15.0.h,fontWeight: FontWeight.w600,),)) : Container();
              }
            ),

            //  child: Center(child: Text(bildirimSayisi.ceil().toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,),)),
            ),

          ),
        ),
      ),
    ) :
    Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
      child:  GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11.7.w)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x26000000),
                    offset: Offset(0, 0),
                    blurRadius: 5.50,
                    spreadRadius: 0.5)
              ],
              color: Theme.of(context).backgroundColor),
          child: ListTile(
            title: Text(
              textTitle,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.7.spByWidth),
            ),


          ),
        ),
      ),
    );

  }
}
