import 'dart:io';
import 'package:etkinlik_kafasi/AdminPanel/adminTakip.dart';
import 'package:etkinlik_kafasi/AdminPanel/takipci.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/adminuyelikdegistiralert.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:image_picker/image_picker.dart';

class AdminKarsiKullaniciInfoContainer extends StatefulWidget {
  final Map<String, dynamic> card;

  AdminKarsiKullaniciInfoContainer({this.card});
  @override
  _AdminKarsiKullaniciInfoContainerState createState() => _AdminKarsiKullaniciInfoContainerState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _AdminKarsiKullaniciInfoContainerState extends State<AdminKarsiKullaniciInfoContainer> {
  final picker = ImagePicker();
  PickedFile _profilFoto;

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width / 100.0;
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
            top: (MediaQuery.of(context).size.height / 100) * 11,
            left: 23.0.w,
            right: 23.0.w,
            child: Container(
                width: 312.3333333333333.w,
                height: 200.0.h,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(11.70.h)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x36000000),
                        offset: Offset(0, 2),
                        blurRadius: 22.70,
                        spreadRadius: 0)
                  ],
                  color: Theme.of(context).backgroundColor,
//                        color: Colors.red,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
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
                              Image.asset("assets/kafalar/premium_kafasi.png",width: 33.0*screen,height: 29.0*screen),
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


                          Row(
                            children: [
                              widget.card['uyelikTipi'] == "gold" ?   Padding(
                                padding:  EdgeInsets.only(right: 5.0.w,bottom: 20.0.h),
                                child: Container(width:33.0.w,height: 16.0.h,child: Image.asset("assets/gold.png",)),
                              ) : widget.card['uyelikTipi'] == "plus" ?   Padding(
                                padding:  EdgeInsets.only(right: 5.0.w,bottom: 20.0.h),
                                child: Container(width:33.0.w,height: 16.0.h,child: Image.asset("assets/PLUS.png",)),
                              ) :widget.card['uyelikTipi'] == "standart" ?   Padding(
                                padding: EdgeInsets.only(right: 5.0.w,bottom: 20.0.h),
                                child: Container(),
                              ) : Container(),
                              InkWell(
                                onTap: (){
                                  var dialogBilgi = AdminAlertUyelik(
                                    userid: widget.card['userId'],
                                  );

                                  showDialog(
                                      context: context,
                                      builder: (
                                          BuildContext context) => dialogBilgi);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10,left: 2),
                                  child: Icon(Icons.create,color: Colors.blue,size: 17.0.h,),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding:  EdgeInsets.only(left: 20.0.w),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [

                              Row(

                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.card['ad'].toString(),
                                          style: TextStyle(
                                            color:
                                            const Color(0xff343633),
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
                                          Text( widget.card['hesaptipi'].toString(),style: TextStyle(fontSize: 14.0.h),),
                                          SizedBox(width: 16.0.w,),
                                          widget.card['mavitik'] ? SizedBox(height:25,width: 25,child: Image.asset("assets/mavitik.png",)) : Container(),
                                        ],
                                      ),
                                      SizedBox(height: 1,),
                                    ],
                                  ),

                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        var dialog = CustomAlertDialog(
                                            message: "Bu kişiyi silmek istediğinize emin misiniz?",
                                            onPostivePressed: () {
                                              _firestoreDBService.hesapSil(widget.card['userId']);
                                              Navigator.pop(context);
                                            },
                                            onNegativePressed: (){

                                            },
                                            positiveBtnText: 'Evet',
                                            negativeBtnText: 'İptal');
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => dialog);
                                      },
                                      child: Icon(Icons.delete,size: 25.0.h,)),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: 20.0.w),
                                child: Container(

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0.w)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0x36000000),
                                          offset: Offset(0, 0),
                                          blurRadius: 4.3,
                                          spreadRadius: 0)
                                    ],
                                    color:
                                    Theme.of(context).backgroundColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text("Etkinlik",
                                              style: TextStyle(
                                                  color: const Color(
                                                      0xff343633),
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  fontSize:
                                                  11.3.spByWidth),
                                              textAlign:
                                              TextAlign.center),
                                          Text(
                                              widget.card['etkinliksayim'].toString(),
                                              style: TextStyle(
                                                  color: const Color(
                                                      0xff343633),
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontFamily: "OpenSans",
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  fontSize:
                                                  15.0.spByWidth),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => AdminTakipci(card: widget.card,)),);

                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text("Takipçi",
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff343633),
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontFamily: "OpenSans",
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize:
                                                    11.3.spByWidth),
                                                textAlign:
                                                TextAlign.center),
                                            Text(widget.card['takipci'].toString(),
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff343633),
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontFamily: "OpenSans",
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize:
                                                    15.0.spByWidth),
                                                textAlign: TextAlign.center)
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => AdminTakip(card: widget.card,)),);

                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text("Takip",
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff343633),
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontFamily: "OpenSans",
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize:
                                                    11.3.spByWidth),
                                                textAlign:
                                                TextAlign.center),
                                            Text(widget.card['takip'].toString(),
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff343633),
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontFamily: "OpenSans",
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize:
                                                    15.0.spByWidth),
                                                textAlign: TextAlign.center),

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
                                    width: 75.70.w,
                                    height: 25.70.h,
                                    color: Colors.white,
                                  ),

                                  Container(
                                    width: 75.70.w,
                                    height: 25.70.h,
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
                top:  (MediaQuery.of(context).size.height / 100) * 33,
                left: 132.0.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(width: 30.0.w,height: 10.0.h,),
                    Center(
                      child: Container(
                        width: 120.70.w,
                        height: 32.70.h,
                        child: RaisedButton(
                          color:
                          Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                65.7.w),
                          ),
                          onPressed: () {
                            var dialog = CustomAlertDialog(
                                message: "Bu kişiyi banlamak istediğinize emin misiniz?",
                                onPostivePressed: () {
                                 _firestoreDBService.hesapbanla(widget.card['userId']);
                                  Navigator.pop(context);
                                },
                                onNegativePressed: (){

                                },
                                positiveBtnText: 'Evet',
                                negativeBtnText: 'İptal');
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => dialog);


                          },
                          elevation: 8.3,
                          child: widget.card['userbanvarmi'] ? Text(
                            "Banlanmış",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.30.spByWidth),
                          ) :
                          Text(
                            "Banla",
                            style: TextStyle(
                                color:
                                const Color(0xff343633),
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.30.spByWidth),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    /*
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.30,
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
            top: (MediaQuery.of(context).size.height / 100) * 14,
            left: 23.0.w,
            right: 23.0.w,
            child: Container(
                width: 312.3333333333333.w,
                height: 152.33333333333334.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(11.70.h)),
                  boxShadow: [
                    BoxShadow(color: const Color(0x36000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
                  ],
                  color: Theme.of(context).backgroundColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius: 34.0.h,
                              backgroundColor: Color(0xfff7cb15),
                              child: CircleAvatar(
                                radius: 32.0.h,
                                backgroundImage: _profilFoto == null
                                    ? NetworkImage(widget.card['avatarImageUrl'].toString())
                                    : FileImage(File(_profilFoto.path)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,top: 4),
                            child: Row(
                              children: [
                                widget.card['uyelikTipi'] != "gold" ? Icon(
                                  Icons.alternate_email,
                                  color: Color(0xfff7cb15),
                                  size: 20.0.h,
                                ) : Container(width:30,height: 30,child: Image.asset("assets/kafalar/premium_kafasi.png",)),
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => UyeTipleri()),);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10,left: 2),
                                    child: Icon(Icons.create,color: Colors.blue,size: 17.0.h,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(_userModel.user.adsoyad.toString(),
                                          style: TextStyle(
                                            color:
                                            const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 13.3.spByWidth,
                                          ),
                                          textAlign: TextAlign.left),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: () {
                                            var dialog = CustomAlertDialog(
                                                message: "Bu kişiyi silmek istediğinize emin misiniz?",
                                                onPostivePressed: () {
                                                  _firestoreDBService.hesapSil(widget.card['userId']);
                                                  Navigator.pop(context);
                                                },
                                                onNegativePressed: (){

                                                },
                                                positiveBtnText: 'Evet',
                                                negativeBtnText: 'İptal');
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => dialog);
                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                  Container(
                                    //  margin: EdgeInsets.symmetric(vertical: 8.0.h),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0.w)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0x36000000),
                                            offset: Offset(0, 0),
                                            blurRadius: 4.3,
                                            spreadRadius: 0)
                                      ],
                                      color:
                                      Theme.of(context).backgroundColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text("Etkinlik",
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff343633),
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontFamily: "OpenSans",
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize:
                                                    11.3.spByWidth),
                                                textAlign:
                                                TextAlign.center),
                                            Text(
                                                widget.card['etkinliksayim'].toString(),
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff343633),
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontFamily: "OpenSans",
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize:
                                                    15.0.spByWidth),
                                                textAlign: TextAlign.center)
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => AdminTakipci(card: widget.card.data(),)),);

                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text("Takipçi",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff343633),
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontFamily: "OpenSans",
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      fontSize:
                                                      11.3.spByWidth),
                                                  textAlign:
                                                  TextAlign.center),
                                              Text(widget.card['takipci'].toString(),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff343633),
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontFamily: "OpenSans",
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      fontSize:
                                                      15.0.spByWidth),
                                                  textAlign: TextAlign.center)
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => AdminTakip(card: widget.card.data(),)),);

                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text("Takip",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff343633),
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontFamily: "OpenSans",
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      fontSize:
                                                      11.3.spByWidth),
                                                  textAlign:
                                                  TextAlign.center),
                                              Text(widget.card['takip'].toString(),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff343633),
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontFamily: "OpenSans",
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      fontSize:
                                                      15.0.spByWidth),
                                                  textAlign: TextAlign.center),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        width: 88.70.w,
                                        height: 25.70.h,
                                        color: Colors.white,
                                      ),

                                      Container(
                                        width: 88.70.w,
                                        height: 25.70.h,
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(widget.card['ad'].toString(),
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


                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  children: [
                                    Text( widget.card['hesaptipi'].toString()),
                                    SizedBox(width: 18.0.w,),
                                    widget.card['mavitik'] ? Icon(Icons.check,color: Colors.blue,size: 20,) : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1,),
                              Container(
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
                                        Text( widget.card['etkinliksayim'].toString(),
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
                                            print("object");
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
                                              MaterialPageRoute(builder: (context) => Takipcilerim()),
                                            );
                                          },
                                          child: Text( widget.card['takipci'].toString(),
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
                                          MaterialPageRoute(builder: (context) => Takipci()),
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
                                          Text(widget.card['takip'].toString(),
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.0.spByWidth),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 88.70.w,
                                    height: 25.70.h,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 88.70.w,
                                    height: 25.70.h,
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
        ],
      ),
    );

     */
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () async {
                        var pickedImage = await imgFromGallery(picker);
                        //TODO Upload edilecek
                        setState(() {
                          _profilFoto = pickedImage;
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () async {
                      var pickedImage = await imgFromCamera(picker);
                      //TODO Upload edilecek
                      setState(() {
                        _profilFoto = pickedImage;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
