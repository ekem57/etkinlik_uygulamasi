import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/alertBilgilendirme.dart';
import 'package:etkinlik_kafasi/widgets/resimliCard.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class KisiDavetEt extends StatefulWidget {
  final DocumentSnapshot card;

  const KisiDavetEt({Key key, this.card}) : super(key: key);
  @override
  _KisiDavetEtState createState() => _KisiDavetEtState();
}


class UserBloc extends Bloc {
  final userController = StreamController<List>.broadcast();


  @override
  void dispose() {
    // TODO: implement dispose
    userController.close();
  }
}
abstract class Bloc {
  void dispose();
}



UserBloc userBloc = UserBloc();
List<DocumentSnapshot> etkinlikozelKatilimci = [];
List<String> etkinlikozelKatilimciidler = [];

class _KisiDavetEtState extends State<KisiDavetEt>  with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool isSearching = false;
  List<DocumentSnapshot> totalUsersTakipci = [];
  List<DocumentSnapshot> totalUsersTakipEttiklerim = [];
  List totalBilgi = [];
  List data;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  final yorumController = TextEditingController();
  void _searchUserTakipci(String searchQuery) {

    List<Map<dynamic,dynamic>> searchResult = [];

    userBloc.userController.sink.add(null);
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsersTakipci);
      return;
    }
    totalUsersTakipci.forEach((DocumentSnapshot user) {
      String tamad=user['ad'];
      if (tamad.toLowerCase().contains(searchQuery.toLowerCase()) ||
          tamad.toLowerCase().contains(searchQuery.toLowerCase())) {
          searchResult.add(user.data());
      }
    });


    userBloc.userController.sink.add(searchResult);
  }


  void _searchUserTakipEttiklerim(String searchQuery) {

    List<Map<dynamic,dynamic>> searchResult = [];

    userBloc.userController.sink.add(null);
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsersTakipEttiklerim);
      return;
    }
    totalUsersTakipEttiklerim.forEach((DocumentSnapshot user) {
      String tamad=user['ad'];
      if (tamad.toLowerCase().contains(searchQuery.toLowerCase()) ||
          tamad.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(user.data());
      }
    });


    userBloc.userController.sink.add(searchResult);
  }
  Widget usersWidget(String userid) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return StreamBuilder(

        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List> snapshot) {

          if (snapshot.data == null) {

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(_userModel.user.userId).collection("takipEttiklerim").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final int cardLength = snapshot.data.docs.length;

                return cardLength == 0 ?  Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(child: Text("Takip Ettiğiniz Kişi Yok.",style: TextStyle(fontSize: 20),)),
                ) : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];

                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users').where('userId',isEqualTo: _cardYonetici['userid'])
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (_, int index) {
                                  final DocumentSnapshot _card = snapshot.data.docs[index];
                                  if(cardLength > totalUsersTakipEttiklerim.length)
                                  {
                                    totalUsersTakipEttiklerim.add(_card);
                                    totalBilgi.add(_card);
                                  }
                                return ResimliCard(textSubtitle: null, textTitle: _card['ad'].toString(),
                                    onPressed: (){
                                      if (!etkinlikozelKatilimciidler.contains(_card.id)) {
                                        etkinlikozelKatilimci.add(_card);
                                        etkinlikozelKatilimciidler.add(_card.id);
                                        Fluttertoast.showToast(
                                            msg: "Davet Edildi.",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            textColor: Colors.white,
                                            backgroundColor: Theme.of(context).primaryColor,
                                            fontSize: 16.0.h);
                                      }else{
                                        var dialogBilgi = AlertBilgilendirme(
                                          message: "Bu kişiyi davet listesinde zaten var.",
                                          onPostivePressed: (){
                                            Navigator.pop(context);
                                          },
                                        );

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => dialogBilgi);
                                      }

                                }, fontSize: 12,
                                    img: _card['avatarImageUrl'].toString(), tarih: null);

                              },
                            );
                          }

                      );
                    }


                );

              },
            );
          }

          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : _randomUsers(snapshot: snapshot,);
        });
  }
  Widget usersWidgetTakipci(String userid) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return StreamBuilder(

        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List> snapshot) {

          if (snapshot.data == null) {

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(_userModel.user.userId).collection("takipcilerim").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final int cardLength = snapshot.data.docs.length;

                return cardLength == 0 ? Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(child: Text("Takipçiniz Yok.",style: TextStyle(fontSize: 20),)),
                ) : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];

                      return  StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users').where('userId',isEqualTo: _cardYonetici['userid'])
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (_, int index) {
                                final DocumentSnapshot _card = snapshot.data.docs[index];
                                if(cardLength > totalUsersTakipci.length)
                                {
                                  totalUsersTakipci.add(_card);
                                }
                                return  ResimliCard(textSubtitle: null, textTitle: _card['ad'].toString(), onPressed: (){

                                  if (!etkinlikozelKatilimciidler.contains(_card.id)) {
                                    etkinlikozelKatilimci.add(_card);
                                    etkinlikozelKatilimciidler.add(_card.id);
                                    Fluttertoast.showToast(
                                        msg: "Davet Edildi.",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        textColor: Colors.white,
                                        backgroundColor: Theme.of(context).primaryColor,
                                        fontSize: 16.0.h);
                                  }else{
                                    var dialogBilgi = AlertBilgilendirme(
                                      message: "Bu kişiyi davet listesinde zaten var.",
                                      onPostivePressed: (){
                                        Navigator.pop(context);
                                      },
                                    );

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) => dialogBilgi);
                                  }
                                }, fontSize: 12,
                                    img: _card['avatarImageUrl'].toString(), tarih: null);

                              },
                            );
                          }

                      );
                    }


                );

              },
            );
          }

          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : _randomUsers(snapshot: snapshot,);
        });
  }

  Widget _randomUsers({AsyncSnapshot<List> snapshot}) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return snapshot.data.length != 0 ?
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        return ResimliCard(textSubtitle: null, textTitle: snapshot.data[index]['ad'], onPressed: (){
          if (!etkinlikozelKatilimciidler.contains(snapshot.data[index]['userId'])) {
            etkinlikozelKatilimci.add(snapshot.data[index]);
            etkinlikozelKatilimciidler.add(snapshot.data[index]['userId']);
            Fluttertoast.showToast(
                msg: "Davet Edildi.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                fontSize: 16.0.h);
          }else{
            var dialogBilgi = AlertBilgilendirme(
              message: "Bu kişiyi davet listesinde zaten var.",
              onPostivePressed: (){
                Navigator.pop(context);
              },
            );

            showDialog(
                context: context,
                builder: (BuildContext context) => dialogBilgi);
          }
        }, fontSize: 12,
            img: snapshot.data[index]['avatarImageUrl'].toString(), tarih: null);
      },
      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context,listen: false);
    return  Scaffold(

      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Davet Et",
            style: TextStyle(
                color: const Color(0xff343633),
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 21.7.spByWidth),
            textAlign: TextAlign.center),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Column(

        children: [

          TabBar(
            controller: _tabController,
            unselectedLabelColor: const Color(0xff343633),
            labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 11.3.spByWidth),
            labelColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).buttonColor,
            tabs: [
              Tab(child: Text("Takip Ettiklerim",style: TextStyle(fontSize: 14.0.spByWidth),)),
              Tab(child: Text("Takipçilerim",style: TextStyle(fontSize: 14.0.spByWidth),)),
            ],
          ),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                          child: Container(
                            width: 293.3333333333333.w,
                            height: 41.666666666666664.h,
                            margin: EdgeInsets.symmetric(vertical: 20.0.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.8.h)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x2b000000), offset: Offset(0, 2), blurRadius: 14.30.w, spreadRadius: 0)
                              ],
                              color: Theme.of(context).backgroundColor,),
                            child:  TextFormField(
                              onChanged: (text) => _searchUserTakipEttiklerim(text),
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              autovalidateMode: AutovalidateMode.disabled,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(fontSize: 15.0.spByWidth),
                              decoration: InputDecoration(
                                hintText: "Takip Ettiklerimde Ara",
                                border: InputBorder.none,
                                icon: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 18.0.h,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                    color: const Color(0xbf343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.3.spByWidth),
                              ),
                            ),

                          ),
                        ),
                        usersWidget(_userModel.user.userId),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                          child: Container(
                            width: 293.3333333333333.w,
                            height: 41.666666666666664.h,
                            margin: EdgeInsets.symmetric(vertical: 20.0.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.8.h)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x2b000000), offset: Offset(0, 2), blurRadius: 14.30.w, spreadRadius: 0)
                              ],
                              color: Theme.of(context).backgroundColor,),
                            child: TextFormField(
                              onChanged: (text) => _searchUserTakipci(text),
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              autovalidateMode: AutovalidateMode.disabled,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(fontSize: 15.0.spByWidth),
                              decoration: InputDecoration(
                                hintText: "Takipcilerimde Ara",
                                border: InputBorder.none,
                                icon: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 18.0.h,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                    color: const Color(0xbf343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.3.spByWidth),
                              ),
                            ),

                          ),
                        ),
                        usersWidgetTakipci(_userModel.user.userId),
                      ],
                    ),

                  ])),



        ],
      ),
    );
  }


}
