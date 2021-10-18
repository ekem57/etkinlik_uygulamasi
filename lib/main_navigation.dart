import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etkinlik_kafasi/Anasayfa/newanasayfa.dart';
import 'package:etkinlik_kafasi/ChattApp/mesajlarAnasayfa.dart';
import 'package:etkinlik_kafasi/drawer/Sikca_sorulan_sorular.dart';
import 'package:etkinlik_kafasi/drawer/adminLandingPage.dart';
import 'package:etkinlik_kafasi/drawer/hakkimizda.dart';
import 'package:etkinlik_kafasi/drawer/iletisim.dart';
import 'package:etkinlik_kafasi/etkinlikler/etkinliklerim.dart';
import 'package:etkinlik_kafasi/extensions/size_config.dart';
import 'package:etkinlik_kafasi/landingPage.dart';
import 'package:etkinlik_kafasi/login/bansayfasi.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/profilim/ayarlar.dart';
import 'package:etkinlik_kafasi/profilim/profilim.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  final Users user;

  MainNavigation({Key key, this.user,}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool onTapped = true;
 static bool _banvarmi = false;
 static bool _logo = true;

  @override
  void initState() {
    super.initState();
    index = 0;
    if(widget.user.hedefhafta.compareTo(DateTime.now()).isNegative){
      Map<String, dynamic> haftalikreset = Map();
      haftalikreset['hedefhafta'] = widget.user.hedefhafta.add(Duration(days: 7));
      haftalikreset['acilanetkinliksayisi'] = 0;
      haftalikreset['katilinanetkinliksayisi'] = 0;
      FirebaseFirestore.instance.collection("users").doc(widget.user.userId).update(haftalikreset);
    }
    if( widget.user.userbanvarmi==true){
      _banvarmi=true;
    }
 //   PushNotificationsManager().init();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onTapped = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context).init();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (_navigationQueue.isEmpty){
          onTapped = true;
          return true;
        }
        setState(() {
          _navigationQueue.removeLast();
          int position = _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
          onTapped = false;
          index = position;
        });
        final CurvedNavigationBarState navBarState = _bottomNavigationKey.currentState;
        navBarState.setPage(index);
        setState(() {
          onTapped = true;
        });
        return false;
      },
      child: Scaffold(
          backgroundColor:Theme.of(context).backgroundColor,
          extendBody: true,
          resizeToAvoidBottomInset: false,
          drawer: Drawer(
            child: ListView(children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/bg_curve.png"), fit: BoxFit.fill),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 23.0.h,
                      backgroundImage: NetworkImage(_userModel.user.avatarImageUrl.toString()),
                    ),
                    SizedBox(height: 10.0.h,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Text(widget.user.adsoyad,
                            maxLines: 1,
                            style: TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.7.h),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left),
                      ),
                    ),
                    Text("${_userModel.user.takipci ?? 0} Takipçi",
                        style: TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.3.h),
                        textAlign: TextAlign.center)
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    index = 4;
                    _navigationQueue.addLast(index);
                    CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                    d.setPage(index);
                  });
                },
                title: Text(
                  "Profil",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.person,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    index = 3;
                    _navigationQueue.addLast(index);
                    CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                    d.setPage(index);
                  });
                },
                title: Text(
                  "Mesajlar",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.message,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    index = 1;
                    _navigationQueue.addLast(index);
                    CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                    d.setPage(index);
                  });
                },
                title: Text(
                  "Etkinliklerim",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.date_range,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AyarlarView(),
                    ),
                  );
                },
                title: Text(
                  "Ayarlar",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.settings,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Hakkimizda()));
                },
                title: Text(
                  "Hakkımızda",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.info,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SikcaSorulanSorular()));
                },
                title: Text(
                  "Sıkça Sorulan Sorular",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.info,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => IletisimView()));
                },
                title: Text(
                  "İletişim",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.perm_phone_msg,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  _userModel.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      LandingPage()), (Route<dynamic> route) => false).then((value)  {
                      });
                },
                title: Text(
                  "Çıkış",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.logout,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            _userModel.user.yoneticimi ?   ListTile(
                onTap: () {

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      AdminLandingPage()), (Route<dynamic> route) => false);
                },
                title: Text(
                  "Admin Panel",
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                ),
                leading: Icon(
                  Icons.perm_phone_msg,
                  size: 20.0.w,
                  color: Theme.of(context).primaryColor,
                ),
              ) : Container(),


            ]),
          ),
          body:_getBody(index),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.home, size: 40, color: Theme.of(context).backgroundColor),
              Icon(Icons.date_range, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.add, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.message, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.person, size: 30, color: Theme.of(context).backgroundColor),
            ],
            color: Theme.of(context).primaryColor,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            onTap: onTapped ? onNavButtonTapped: changeNavButtonAnimation,
            letIndexChange: (index) => true,
          )),
    );
  }


  void onNavButtonTapped(int _index){
    if (index != _index) {
      _navigationQueue.removeWhere((element) => element == _index);
      _navigationQueue.addLast(_index);
      setState(() {
        this.index = _index;
      });
    }
  }
  void changeNavButtonAnimation(int _index){
    setState(() {
      this.index = _index;
    });
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return NewAnasayfa(user: widget.user,);
      case 1:
        return Etkinliklerim();
      case 2:
        return Etkinliklerim();
      case 3:
        return MesajlarNewAnasayfa();
      case 4:
        return Profilim();
    }
  }
}
