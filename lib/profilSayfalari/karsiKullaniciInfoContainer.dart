import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminTakip.dart';
import 'package:etkinlik_kafasi/AdminPanel/takipci.dart';
import 'package:etkinlik_kafasi/ChattApp/chat_view_model.dart';
import 'package:etkinlik_kafasi/ChattApp/sohbetPage.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/profilim/takipciEttiklerim.dart';
import 'package:etkinlik_kafasi/profilim/takipcilerim.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/fullresim.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class KarsiKullaniciInfoContainer extends StatefulWidget {
  final Map<String, dynamic> card;

  KarsiKullaniciInfoContainer({this.card});
  @override
  _KarsiKullaniciInfoContainerState createState() => _KarsiKullaniciInfoContainerState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _KarsiKullaniciInfoContainerState extends State<KarsiKullaniciInfoContainer> {
  final picker = ImagePicker();
  PickedFile _profilFoto;

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width / 100.0;
    final _userModel = Provider.of<UserModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(21.70.h),
          bottomLeft: Radius.circular(21.70.h),
        ),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: (MediaQuery.of(context).size.height / 100) * 12,
            left: 23.0.w,
            right: 23.0.w,
            child: Container(
                width: 312.3333333333333.w,
                height: 200.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(11.70.h)),
                  boxShadow: [
                    BoxShadow(color: const Color(0x36000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
                  ],
                  color: Theme.of(context).backgroundColor,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0.w,right: 12.0.w),
                  child: Row(

                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => ImageViewerPage(
                                  assetName: widget.card['avatarImageUrl'].toString(),
                                )),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            widget.card['uyelikTipi']=="standart" ?
                            CircleAvatar(
                                radius: 30.0.w,
                                backgroundImage: _profilFoto == null
                                    ? NetworkImage(widget.card['avatarImageUrl'].toString())
                                    : FileImage(File(_profilFoto.path)))
                                :

                            Container(width:33.0*screen,height: 28.0*screen,child:
                            Container(child:

                            Stack(
                              children: [
                                Image.asset("assets/kafalar/premium_kafasi.png",width: 33.0*screen,height: 29.0*screen,),
                                Positioned(
                                  top: 5.0*screen,
                                  left: 33.0.w,
                                  child: CircleAvatar(
                                    radius: 27.0.w,
                                    backgroundColor: Color(0xfff7cb15),
                                    child: CircleAvatar(
                                      radius: 27.0.w,
                                      backgroundImage: _profilFoto == null
                                          ? NetworkImage(widget.card['avatarImageUrl'].toString())
                                          : FileImage(File(_profilFoto.path)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            )),
                            widget.card['uyelikTipi'] == "gold" ?   Padding(
                              padding:  EdgeInsets.only(right: 5.0.w,bottom: 20.0.h),
                              child: Container(width:33.0.w,height: 16.0.h,child: Image.asset("assets/gold.png",)),
                            ) :  widget.card['uyelikTipi'] == "plus" ?   Padding(
                              padding: EdgeInsets.only(right: 5.0.w,bottom: 20.0.h),
                              child: Container(width:33.0.w,height: 16.0.h,child: Image.asset("assets/PLUS.png",)),
                            ) :  widget.card['uyelikTipi'] == "standart" ?   Padding(
                              padding: EdgeInsets.only(right: 5.0.w,bottom: 20.0.h),
                              child: Container(),
                            ) : Container(),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:  EdgeInsets.only(left: 20.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text( widget.card['ad'],
                                  style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth,
                                  ),
                                  textAlign: TextAlign.left),


                              widget.card['temsilcimi'] ? Text(widget.card['temsilciAdres'].toString(),
                                  style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.spByWidth,
                                  ),
                                  textAlign: TextAlign.left) : Container(),


                              Row(
                                children: [
                                  Text(widget.card['hesaptipi'].toString(),style: TextStyle(fontSize: 12.0.h),),
                                  SizedBox(width: 16.0.w,),
                                 widget.card['mavitik'] ? SizedBox(height:20.0.h,width: 25.0.w,child: Image.asset("assets/mavitik.png",)) : Container(),
                                ],
                              ),

                              Padding(
                                padding:  EdgeInsets.only(right: 20.0.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0x36000000),
                                          offset: Offset(0, 0),
                                          blurRadius: 4.3,
                                          spreadRadius: 0)
                                    ],
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Etkinlik",
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 11.3.spByWidth),
                                              textAlign: TextAlign.center),
                                          Text(widget.card['etkinliksayim'].toString(),
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.0.spByWidth),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context, rootNavigator: true).push(
                                                MaterialPageRoute(builder: (context) => AdminTakipci(card: widget.card,)),
                                              );
                                            },
                                            child: Text("Takipçi",
                                                style: TextStyle(
                                                    color: const Color(0xff343633),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "OpenSans",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 11.3.spByWidth),
                                                textAlign: TextAlign.center),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context, rootNavigator: true).push(
                                                MaterialPageRoute(builder: (context) => AdminTakipci(card: widget.card)),
                                              );
                                            },
                                            child: Text(widget.card['takipci'].toString(),
                                                style: TextStyle(
                                                    color: const Color(0xff343633),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "OpenSans",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.0.spByWidth),
                                                textAlign: TextAlign.center),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context, rootNavigator: true).push(
                                            MaterialPageRoute(builder: (context) => AdminTakip(card: widget.card)),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Takip",
                                                style: TextStyle(
                                                    color: const Color(0xff343633),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "OpenSans",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 11.3.spByWidth),
                                                textAlign: TextAlign.center),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context, rootNavigator: true).push(
                                                  MaterialPageRoute(builder: (context) => AdminTakip(card: widget.card)),
                                                );
                                              },
                                              child: Text(widget.card['takip'].toString(),
                                                  style: TextStyle(
                                                      color: const Color(0xff343633),
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "OpenSans",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 15.0.spByWidth),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 30.70.w,
                                    height: 55.70.h,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 30.70.w,
                                    height: 55.70.h,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                top:  (MediaQuery.of(context).size.height / 100) * 34,
                left: 130.0.w,
                child: Row(

                  children: [

                    Container(
                      width: 88.70.w,
                      height: 30.70.h,
                      child: RaisedButton(
                        color:
                        Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              65.7.w),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) => ChatViewModel(currentUser: _userModel.user, sohbetEdilenUser: Users.fromMap(widget.card)),
                                child: SohbetPage(fotourl: widget.card['avatarImageUrl'].toString(),userad: widget.card['ad'].toString(),userid: widget.card['userId'].toString(),),
                              ),
                            ),
                          );
                        },
                        elevation: 8.3,
                        child: Text(
                          "Mesaj",
                          style: TextStyle(
                              color:
                              const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 13.30.spByWidth),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0.w,),
                    StreamBuilder<QuerySnapshot>(
                        stream:  FirebaseFirestore.instance
                            .collection("users").doc(_userModel.user.userId).collection("takipEttiklerim").where('userid',isEqualTo:  widget.card['userId'])
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return const Text('Yükleniyor...');

                          return  snapshot.data.docs.toString() != "[]" ?
                          Container(
                            width: 88.70.w,
                            height: 30.70.h,
                            child: RaisedButton(
                              color: Renkler.reddetButonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(65.7.w),
                              ),
                              onPressed: () async {
                                await  _firestoreDBService.takipCikButonu(_userModel.user.userId.toString(),widget.card['userId']);
                                print("object");
                              },
                              elevation: 8.3,
                              child: Text(
                                "Bırak",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.40.spByWidth),
                              ),
                            ),
                          ) :
                          Container(
                            width: 88.70.w,
                            height: 30.70.h,
                            child: RaisedButton(
                              color: Theme.of(context).buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(65.7.w),
                              ),
                              onPressed: () async {
                                await  _firestoreDBService.takipetButonu(_userModel.user.userId.toString(),widget.card['userId'].toString());
                                print("takip et");
                                print(" userid:"+widget.card['userId'].toString());
                              },
                              elevation: 8.3,
                              child: Text(
                                "Takip Et",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11.30.spByWidth),
                              ),
                            ),
                          );
                        }),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
