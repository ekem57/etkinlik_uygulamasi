import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminEtkinlikler.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminGelenKutusu.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminReklamlar.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminBildirimGonder.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminUyeIslemleri.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/main_navigation.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AdminMainNavigation extends StatefulWidget {
  final Users user;

  AdminMainNavigation({Key key, @required this.user,}) : super(key: key);
  @override
  _AdminMainNavigationState createState() => _AdminMainNavigationState();
}
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AdminMainNavigationState extends State<AdminMainNavigation> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool onTapped = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onTapped = true;
  }
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color(0xffcc59d2),
    minimumSize: Size(88, 36),

    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
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
        print("index: $index");
        setState(() {
          onTapped = true;
        });
        return false;
      },

      child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).backgroundColor,
            extendBody: true,
            drawer: Drawer(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                        children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/bg_curve.png"), fit: BoxFit.fill),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(_userModel.user.avatarImageUrl.toString()),
                              radius: 40.0,
                            ),
                            Text(_userModel.user.adsoyad.toString(),
                                style: TextStyle(
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.7.spByWidth),),

                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            index = 0;
                            _navigationQueue.addLast(index);
                            CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                            d.setPage(index);
                          });
                        },
                        title: Text(
                          "Etkinlikler",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        leading: Icon(
                          Icons.date_range,
                          size: 25.0.w,
                          color: Renkler.draweIconColor,
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
                          "Reklamlar",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        leading: Icon(
                          Icons.campaign,
                          size: 25.0.w,
                          color: Renkler.draweIconColor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            index = 2;
                            _navigationQueue.addLast(index);
                            CurvedNavigationBarState d = _bottomNavigationKey.currentState;
                            d.setPage(index);
                          });
                        },
                        title: Text(
                          "Üye İşlemleri",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        leading: Icon(
                          Icons.supervisor_account,
                          size: 25.0.w,
                          color: Renkler.draweIconColor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AdminGelenKutusu()),);
                        },
                        title: Text(
                          "Gelen Kutusu",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        leading: Stack(
                          children: <Widget>[
                            new Icon(Icons.email,color: Renkler.draweIconColor,size: 25.0.w,),
                            new Positioned(
                              right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  color: const Color(0xfff7cb15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminBildirimGonder(),),);
                        },
                        title: Text(
                          "Bildirim Gönder",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        leading: Icon(
                          Icons.notifications,
                          size: 20.0.w,
                          color: Renkler.draweIconColor,
                        ),
                      ),

                      ListTile(
                        onTap: () {
                           _userModel.signOut();
                        },
                        title: Text(
                          "Çıkış",
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0.spByWidth),
                        ),
                        leading: Icon(
                          Icons.logout,
                          size: 20.5.w,
                          color:Renkler.draweIconColor ,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 10.0.h,),
              ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    MainNavigation(user: _userModel.user,)), (Route<dynamic> route) => false);
              },
              child: Text("Uygulamaya geç",style: TextStyle(color: Colors.white),),
              ),
                SizedBox(height: 56,),
                ],
              ),
            ),
            body: (_getBody(index)),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 75.0,
              items: <Widget>[
                Icon(Icons.date_range, size: 40, color: Theme.of(context).backgroundColor),
                Icon(Icons.campaign, size: 40, color: Theme.of(context).backgroundColor),
                Icon(Icons.add, size: 40, color: Theme.of(context).backgroundColor),
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

  @override
  void dispose() {
    print("dispose call");
    super.dispose();
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
        return AdminEtkinlikler();
      case 1:
        return AdminUyeIslemleri();
      case 2:
        return AdminUyeIslemleri();
    }
  }
}
