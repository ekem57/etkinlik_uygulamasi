import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/profilim/takipciEttiklerim.dart';
import 'package:etkinlik_kafasi/profilim/takipcilerim.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/fullresim.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilInfoContainer extends StatefulWidget {
  @override
  _ProfilInfoContainerState createState() => _ProfilInfoContainerState();
}

class _ProfilInfoContainerState extends State<ProfilInfoContainer> {
  final picker = ImagePicker();
  PickedFile _profilFoto;


  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width / 100.0;
    final _userModel = Provider.of<UserModel>(context);
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
            top: (MediaQuery.of(context).size.height / 100) * 12,
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
                  padding: EdgeInsets.only(left: 12.0.w,right: 12.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => ImageViewerPage(
                                  assetName: _userModel.user.avatarImageUrl,
                                )),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _userModel.user.uyelikTipi=="standart" ?
                            CircleAvatar(
                                radius: 30.0.w,
                                backgroundImage: _profilFoto == null
                                    ? NetworkImage(_userModel.user.avatarImageUrl.toString())
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
                                          ? NetworkImage(_userModel.user.avatarImageUrl.toString())
                                          : FileImage(File(_profilFoto.path)),
                                    ),
                                  ),
                                ),
                              ],
                            )


                            )),
                           _userModel.user.uyelikTipi == "gold" ?   Padding(
                             padding:  EdgeInsets.only(right: 5.0.w,),
                             child: Container(width:33.0.w,height: 16.0.h,child: Image.asset("assets/gold.png",)),
                           ) : _userModel.user.uyelikTipi == "plus" ?   Padding(
                             padding:  EdgeInsets.only(right: 5.0.w),
                             child: Container(width:33.0.w,height: 16.0.h,child: Image.asset("assets/PLUS.png",)),
                           ) : _userModel.user.uyelikTipi == "standart" ?   Padding(
                             padding: EdgeInsets.only(right: 5.0.w),
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
                              Padding(
                                padding:  EdgeInsets.only(top: 10.0.h),
                                child: Text(_userModel.user.adsoyad,
                                    style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.3.spByWidth,
                                    ),
                                    textAlign: TextAlign.left),
                              ),


                              _userModel.user.temsilcimi ? Text(_userModel.user.temsilciyeri.toString(),
                                  style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.3.spByWidth,
                                  ),
                                  textAlign: TextAlign.left) : Container(),


                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 3.0.h),
                                child: Row(
                                  children: [
                                    Text(_userModel.user.hesapTipi,style: TextStyle(fontSize: 14.0.h),),
                                    SizedBox(width: 18.0.w,),
                                    _userModel.user.mavitik ? SizedBox(height:25,width: 25,child: Image.asset("assets/mavitik.png",)) : Container(),
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
                                        Text(_userModel.user.etkinliksayim.toString(),
                                            style: TextStyle(
                                                color: const Color(0xff343633),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 15.0.spByWidth),
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if(_userModel.user.uyelikTipi == "standart"){
                                          Fluttertoast.showToast(
                                            msg: "Bu Alana Sadece Plus ve Gold Üyeler erişebilir!",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.black,
                                          );
                                          return;
                                        }
                                        Navigator.of(context, rootNavigator: true).push(
                                          MaterialPageRoute(builder: (context) => Takipcilerim()),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Takipçi",
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 11.3.spByWidth),
                                              textAlign: TextAlign.center),
                                          Text(_userModel.user.takipci.toString(),
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.0.spByWidth),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
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
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context, rootNavigator: true).push(
                                                MaterialPageRoute(builder: (context) => Takipci()),
                                              );
                                            },
                                            child: Text(_userModel.user.takip.toString(),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 70.70.w,
                                    height: 25.70.h,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 78.70.w,
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
  }



}
