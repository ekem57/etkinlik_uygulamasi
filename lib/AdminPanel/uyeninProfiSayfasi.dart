import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminTakip.dart';
import 'package:etkinlik_kafasi/AdminPanel/takipci.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/drawer/uye_tipleri.dart';
import 'package:etkinlik_kafasi/etkinlikler/etkinlik_card.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/fullresim.dart';
import 'package:etkinlik_kafasi/widgets/radial_painter.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UyeninProfilSayfasi extends StatefulWidget {

  final Map<String, dynamic> card;
  UyeninProfilSayfasi({this.card});
  @override
  _UyeninProfilSayfasiState createState() => _UyeninProfilSayfasiState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _UyeninProfilSayfasiState extends State<UyeninProfilSayfasi>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _selectedKafalar = [];
  double _olumluSlider = 60;
  double _notrSlider = 30;
  double _olumsuzSlider = 10;
  int toplamEtkinlikSayim = 0;
  double leftmargin=120.0.w;
  double topmargin=40.0.w;
  Future<List<DocumentSnapshot>> kafalardizisi;
  firebase_storage.FirebaseStorage storage;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);

    storage = firebase_storage.FirebaseStorage.instance;
    kafalardizisi =  _firestoreDBService.usersKafalariGetir(widget.card['userId']);
    int i=0;
    kafalardizisi.then((value) {
      for (DocumentSnapshot snap in value) {
        if (!_selectedKafalar.contains(kafalar[i]["title"])) {
          _selectedKafalar.add(snap['kafa']);
        }
        i++;

      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return
      Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(

          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,

        ),
        body: Container(
          child: Column(
            children: [
              Container(
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
                      top: (MediaQuery.of(context).size.height / 100) * 13,
                      left: 23.0.w,
                      right: 23.0.w,
                      child: Container(
                          width: 312.3333333333333.w,
                          height: 139.33333333333334.h,
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
                            padding: EdgeInsets.all(12.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 34.0.h,
                                      backgroundColor: Color(0xfff7cb15),
                                      child: CircleAvatar(
                                        radius: 32.0.h,
                                        backgroundImage:
                                        NetworkImage(widget.card['avatarImageUrl'].toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 22,
                                              height: 22,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/gold_uye.png'),
                                                ),
                                              )),
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
                                  ],
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
                                        Text(
                                            widget.card['ad'],
                                            style: TextStyle(
                                              color: const Color(0xff343633),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "OpenSans",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 13.3.spByWidth,
                                            ),
                                            textAlign: TextAlign.left),
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

                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Positioned(
                          top:  (MediaQuery.of(context).size.height / 100) * 28,
                          left: 122.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(width: 30.0.w,),
                              Center(
                                child: Container(
                                  width: 120.70.w,
                                  height: 25.70.h,
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
                                    child: Text(
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
              ),
              SizedBox(
                height: 60.0.h,
              ),
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
                  Tab(child: Icon(Icons.person)),
                  Tab(child: Icon(Icons.emoji_emotions)),
                  Tab(child: Icon(Icons.location_on)),
                  Tab(child: Icon(Icons.star_rate)),
                  Tab(child: Icon(Icons.photo_album)),
                ],
              ),
              widget.card['profilGizlilik'] ? Center(child: Text("Bu Kullanıcının Profili Gizlidir.")) :

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      padding:
                      EdgeInsets.only(top: 10.0, left: 8.0.w, right: 16.0.w),
                      children: [
                        ListTile(
                          title: Text(widget.card['hakkimda'].toString(),
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.left),
                          leading: Icon(
                            Icons.person,
                            size: 24.0.h,
                            color: Theme.of(context).primaryColor,
                          ),

                        ),
                        ListTile(
                          title: Text("Doğum Tarihi",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.left),
                          leading: Icon(
                            Icons.cake,
                            size: 24.0.h,
                            color: Theme.of(context).primaryColor,
                          ),
                          trailing: Text(
                              formatTheDate(widget.card['dogumTarihi'].toDate(), format: DateFormat("d.M.y"))??"",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.right),
                        ),
                        ListTile(
                          title: Text("İlişki Durumu",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.left),
                          leading: Icon(
                            Icons.favorite,
                            size: 24.0.h,
                            color: Colors.red,
                          ),
                          trailing: Text(
                              widget.card['iliskiDurumu']  ??"",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.right),
                        ),
                        ListTile(
                          title: Text("Meslek",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.left),
                          leading: Icon(
                            Icons.work,
                            size: 24.0.h,
                            color: Theme.of(context).accentColor,
                          ),
                          trailing: Text(widget.card['meslek']  ??"",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.right),
                        ),
                        InkWell(
                          onTap:() {
                            if(widget.card['facebook'].isEmpty){

                            }else{
                              _launchURL(widget.card['facebook']);
                            }
                          } ,
                          child: ListTile(
                            title: Text("Facebook",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.left),
                            leading: Image.asset(
                              "assets/facebook_icon.png",
                              width: 24.0.h,
                              height: 24.0.h,
//                          alignment: Alignment.bottomRight,
                              fit: BoxFit.contain,
                            ),
                            trailing: Text(widget.card['facebook'] ??"",
                                style: TextStyle(
                                    color: const Color(0xffcb59d1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                        ),
                        InkWell(
                          onTap:() {
                            if(widget.card['twitter'].isEmpty){

                            }else{
                              _launchURL(widget.card['twitter']);
                            }
                          } ,
                          child: ListTile(
                            title: Text("Twitter",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.left),
                            leading: Image.asset(
                              "assets/twitter_icon.png",
                              width: 24.0.h,
                              height: 24.0.h,
//                          alignment: Alignment.bottomRight,
                              fit: BoxFit.contain,
                            ),
                            trailing: Text(widget.card['twitter']  ??"",
                                style: TextStyle(
                                    color: const Color(0xffcb59d1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                        ),
                        InkWell(
                          onTap:() {
                            if(widget.card['instagram'].isEmpty){

                            }else{
                              _launchURL(widget.card['instagram']);
                            }
                          } ,
                          child: ListTile(
                            title: Text("Instagram",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.left),
                            leading: Image.asset(
                              "assets/instagram_icon.png",
                              width: 24.0.h,
                              height: 24.0.h,
//                          alignment: Alignment.bottomRight,
                              fit: BoxFit.contain,
                            ),
                            trailing: Text(widget.card['instagram'] ??"",
                                style: TextStyle(
                                    color: const Color(0xffcb59d1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                        ),
                        InkWell(
                          onTap:() {
                            if(widget.card['tiktok'].isEmpty){

                            }else{
                              _launchURL(widget.card['tiktok']);
                            }
                          } ,
                          child: ListTile(
                            title: Text("TikTok",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.left),
                            leading: Image.asset(
                              "assets/instagram_icon.png",
                              width: 24.0.h,
                              height: 24.0.h,
//                          alignment: Alignment.bottomRight,
                              fit: BoxFit.contain,
                            ),
                            trailing: Text(widget.card['tiktok']??"",
                                style: TextStyle(
                                    color: const Color(0xffcb59d1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                        )
                      ],
                    ),
                    _kafalarTab(),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.card['userId'])
                          .collection('etkinliklerim')
                          .orderBy('tarih', descending: true)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          print(snapshot.error);
                          return Center(
                              child: Text(
                                "Herhangi bir etkinlik yok!",
                                style: Theme.of(context).textTheme.caption,
                              ));
                        }
                        final int cardLength = snapshot.data.docs.length;

                        return cardLength == 0
                            ? Text("Herhangi bir etkinlik yok!")
                            : ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: cardLength,
                          itemBuilder: (_, int index) {
                            final DocumentSnapshot _cardetkinlikler = snapshot.data.docs[index];
                            return   StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('etkinlik').doc(_cardetkinlikler['etid'].toString()).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                print("data:"+cardLength.toString());


                                return cardLength == 0
                                    ? Text("Herhangi bir etkinlik yok!")
                                    : ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 1,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card = snapshot.data;
                                    return Column(
                                      children: [
                                        EtkinlikCard(etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),card: _card,),
                                        SizedBox(height: 40,),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        _buildYorumlarGrafikleri(),
                        _buildYorumlar(),

                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.card['userId'])
                          .collection('albumlerim')
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          print(snapshot.error);
                          return Center(
                              child: Text(
                                "Herhangi bir etkinlik yok!",
                                style: Theme.of(context).textTheme.caption,
                              ));
                        }
                        final int cardLength = snapshot.data.docs.length;

                        return  GridView.builder(
                          padding: EdgeInsets.all(16.0.w),
                          shrinkWrap:  true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cardLength,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:  3,
                            crossAxisSpacing: 14.30.w,
                            mainAxisSpacing: 13.0.h,
                          ),
                          itemBuilder: (BuildContext context, int index) {

                            return  InkWell(
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: snapshot.data.docs[index]['img'].toString())),);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data.docs[index]['img'].toString()),
                                    fit: BoxFit.fill,
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
            ],
          ),
        ),
      );
  }

  Widget _buildYorumlarGrafikleri() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final int cardLength =1;

        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cardLength,
          itemBuilder: (_, int index) {
            final DocumentSnapshot _card = snapshot.data;
            int iyi=  _card['yorumiyi'].toInt();
            int orta=  _card['yorumorta'].toInt();
            int kotu=  _card['yorumkotu'].toInt();
            int toplam = (iyi+orta+kotu) == 0 ? 0 :(iyi+orta+kotu);


            double iyiort= (iyi/toplam);

            print("toplam:"+toplam.toString());
            print("iyi:"+iyi.toString());
            print("orta:"+orta.toString());
            print("kotu:"+kotu.toString());
            print("iyiort:"+iyiort.toString());

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  Container(
                    width: 50.0.w,
                    height: 50.0.w,
                    child: CustomPaint(
                      foregroundPainter: RadialPainter(
                          bgColor: Colors.grey[200],
                          lineColor: Color(0xff00af54),
                          percent: iyiort.isNaN ? 0 : iyiort,
                          width: 5.0),
                      child: Center(
                        child: Text(
                          toplam != 0 ? '%'+(iyiort*100).ceil().toString() : "%0",
                          style: TextStyle(
                            fontSize: 13.70.spByWidth,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 14.0.h,
                          child: Row(
                            children: [
                              Container(
                                width: 30.0.w,
                                child: Text("İyi",
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 11.7.spByWidth),
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                child: SliderTheme(
                                    data: SliderThemeData(
                                      disabledActiveTrackColor: Color(0xff00af54),
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 0.0),
                                      trackHeight: 7.0.h,
                                      trackShape: CustomTrackShape(),
                                    ),
                                    child: Slider(
                                      value: toplam != 0 ? iyi.toDouble() : 0,
                                      onChanged: null,
                                      activeColor: Color(0xff00af54),
                                      max: 100,
                                      min: 0,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 14.0.h,
                          child: Row(
                            children: [
                              Container(
                                width: 30.0.w,
                                child: Text("Orta",
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 11.7.spByWidth),
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                child: SliderTheme(
                                    data: SliderThemeData(
                                      disabledActiveTrackColor: Color(0xfff7cb15),
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 0.0),
                                      trackShape: CustomTrackShape(),
                                      trackHeight: 7.0.h,
                                    ),
                                    child: Slider(
                                      value: orta.toDouble(),
                                      onChanged: null,
                                      activeColor: Color(0xff00af54),
                                      max: 100,
                                      min: 0,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 14.0.h,
                          child: Row(
                            children: [
                              Container(
                                width: 30.0.w,
                                child: Text("Kötü",
                                    style: TextStyle(
                                        color: const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 11.7.spByWidth),
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                child: SliderTheme(
                                    data: SliderThemeData(
                                      disabledActiveTrackColor: Color(0xfff21b3f),
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 0.0),
                                      trackShape: CustomTrackShape(),
                                      trackHeight: 7.0.h,
                                    ),
                                    child: Slider(
                                      value:kotu.toDouble(),
                                      onChanged: null,
                                      activeColor: Color(0xff00af54),
                                      max: 100,
                                      min: 0,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(toplam.toString()+" Yorum",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0.spByWidth),
                              textAlign: TextAlign.right),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );

  }

  Widget _buildYorumlar() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).collection("yorumlar").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final int cardLength =snapshot.data.docs.length;

        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cardLength,
          itemBuilder: (_, int index) {
            final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid']).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                String assets="";
                final String notrActive = "assets/notr_active.png";
                final String olumluActive = "assets/olumlu_active.png";
                final String olumsuzActive = "assets/olumsuz_active.png";

                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot _card = snapshot.data;

                    if(_cardYonetici['yorumdeger'].toString()=='olumsuz'){
                      assets=olumsuzActive;
                    }else if(_cardYonetici['yorumdeger'].toString()=='notr'){
                      assets=notrActive;
                    }else{
                      assets=olumluActive;
                    }
                    final gun = _cardYonetici['tarih'].toDate();
                    final bugun = DateTime.now();
                    final difference = bugun.difference(gun).inDays;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0.w),
                            title: Text(_card['ad'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.left),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(_card['avatarImageUrl'].toString()),
                              radius: 20.0.h,
                            ),
                            subtitle: Image.asset(
                              assets,
                              width: 25.0.w,
                              height: 25.0.w,
                              fit: BoxFit.contain,
                              alignment: Alignment.centerLeft,
                            ),
                            trailing: Text(difference.toString()+" gün önce",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                          Text(
                            _cardYonetici['yorum'].toString(),
                            style: const TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 13.3),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );

  }

  Widget _kafalarTab() {

    return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).collection("kafalar").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {}
        final int cardLength = snapshot.data.docs.length;
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 1,
          itemBuilder: (_, int index) {
            // final DocumentSnapshot _card= snapshot.data.docs[index];
            return  Column(
              children: [
                GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    padding: EdgeInsets.all(23.0),
                    mainAxisSpacing: 8.0.h,
                    crossAxisSpacing: 18.0.w,
                    children: List.generate(36, (index) {
                      return GestureDetector(
                        onTap: () {


                            var user = context.read<UserModel>().user;
                          if (!_selectedKafalar.contains(kafalar[index]["title"])) {
                            user.kafalar.add(kafalar[index]["title"]);
                            _firestoreDBService.usersKafaEkle(user.kafalar, widget.card['userId']);
                          } else {
//                            _selectedKafalar.remove(kafalar[index]["title"]);
                            user.kafalar.remove(kafalar[index]["title"]);
                            _firestoreDBService.usersKafaEkle(user.kafalar, widget.card['userId']);
//                            _firestoreDBService.usersKafaCikar(kafalar[index]["title"], widget.card['userId']);
                          }


                        },
                        child: _selectedKafalar.contains(kafalar[index]["title"]) ?
                        Container(
                          width: 75.66666666666667.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 22.70,
                                  spreadRadius: 0)
                            ],
                            color: Renkler.onayButonColor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.saturation),
                                child: Image.asset(
                                  kafalar[index]["image"],
                                  width: 50.0.w,
                                  height: 50.0.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  kafalar[index]["title"],
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.3.spByWidth),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),):
                        Container(
                          width: 75.66666666666667.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 22.70,
                                  spreadRadius: 0)
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColorFiltered(
                                child: Image.asset(
                                  kafalar[index]["image"],
                                  width: 50.0.w,
                                  height: 50.0.w,
                                  fit: BoxFit.contain,
                                ),
                                colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
                              ),
                              Expanded(
                                child: Text(
                                  kafalar[index]["title"],
                                  style: TextStyle(
                                      color: const Color(0xff343633),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.3.spByWidth),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
                SizedBox(height: 100.0.h,),
              ],
            );
          },
        );

      },
    );


  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
