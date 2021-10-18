import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminEtkinlikDetay.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminGelenKutusu.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';



class AdminEtkinlikler extends StatefulWidget {
  @override
  _AdminEtkinliklerState createState() => _AdminEtkinliklerState();
}


class _AdminEtkinliklerState extends State<AdminEtkinlikler> {
  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);



    return Scaffold(
      extendBody: true,
      backgroundColor: Renkler.backGroundColor,
      appBar:  AppBar(
        backgroundColor: Renkler.backGroundColor,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
            "Etkinlikler",
            style:  TextStyle(
                color:  Renkler.appbarTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle:  FontStyle.normal,
                fontSize: 20.0
            ),
            textAlign: TextAlign.center
        ),
        leading:  Padding(
          padding:  EdgeInsets.only(left: 20.0.w),
          child: IconButton(
            icon: Icon(Icons.menu,color: Renkler.appbarIconColor,size: 20.0.w,),
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.only(right: 20.0.w),
            child: IconButton(
              icon: Icon(Icons.email,color: Renkler.appbarIconColor,),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AdminGelenKutusu()),);

              },
            ),
          ),
        ],
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
          child: _userModel.user.yoneticiyetkileri.etkinlik_onay ?

          ListView(

            children: [

            SizedBox(height: 20.0.h,),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('etkinlikOnayBekleyenler').orderBy('tarih',descending: true).limit(50).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final int cardLength = snapshot.data.docs.length;

                return cardLength == 0 ?
                Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.6 ,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Text("Etkinlik Yok")),
                ) :
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cardLength,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot _card = snapshot.data.docs[index];
                    return  InkWell(

                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminEtkinlikDetay(card: _card,)),
                        );
                      },

                      child: Padding(
                        padding:  EdgeInsets.only(left: 30.0.w,right: 30.0.w,top: 20.0.h,bottom: 20.0.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(11.70.w),
                            ),
                            boxShadow: [
                              BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
                            ],
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Column(children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              child: Container(
                                color: Renkler.backGroundColor,
                                height: (MediaQuery.of(context).size.height * 25)/100 ,
                                width: MediaQuery.of(context).size.width,
                                child: CachedNetworkImage(
                                  imageUrl: _card['etkinlikFoto'].toString(),
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                              child: Container(
                                color: Colors.white,
                                height: (MediaQuery.of(context).size.height * 32)/100,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(height: 4.0.h,),
                                    Padding(
                                      padding:  EdgeInsets.only(left: 15.0.w),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              _card['baslik'].toString(),
                                              style:  TextStyle(
                                                color:  const Color(0xff343633),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "OpenSans",
                                                fontSize: 14.3.spByWidth,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.details_outlined,color: Renkler.fLoatButonColor,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: 10.0.w),
                                      child: Row(children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Theme.of(context).accentColor,
                                          size: 20.0.h,
                                        ),
                                        Expanded(
                                          child: Text(
                                              _card['konum'].toString(),
                                              style:  TextStyle(
                                                  color:  const Color(0xff343633),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "OpenSans",
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 12.3.spByWidth
                                              ),
                                              textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: 13.0.w),
                                      child: Row(children: [
                                        Icon(Icons.person),
                                        Text(
                                           _card['yayinlayanAdSoyad'].toString(),
                                            style:  TextStyle(
                                                color:  const Color(0xff343633),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "OpenSans",
                                                fontStyle:  FontStyle.normal,
                                                fontSize: 12.3.spByWidth
                                            ),
                                            textAlign: TextAlign.center
                                        )
                                      ],),
                                    ),

                                    Padding(
                                      padding:  EdgeInsets.all(8.0.w),
                                      child: MyButton(text: "Onayla",fontSize:12.0.spByWidth , butonColor:Renkler.onayButonColor,width: 220.0.w,height: 27.0.h,onPressed: (){
                                        var dialog = CustomAlertDialog(
                                            message: "Bu etkinliği onaylamak istediğinize emin misiniz?",
                                            onPostivePressed: () {

                                              if(_card['kimKatilabilir']== 0){
                                                _adminIslemleri.adminEtkinlikDavetlerileriGetir(_card);
                                              }else{
                                                _adminIslemleri.adminEtkinlikOnayla(_card);
                                              }
                                                Navigator.pop(context);
                                            },

                                            onNegativePressed: (){},
                                            positiveBtnText: 'Evet',
                                            negativeBtnText: 'İptal');
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => dialog);
                                      },),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(8.0.w),
                                      child: MyButton(text: "Reddet",fontSize:12.0.spByWidth , butonColor: Renkler.reddetButonColor,width: 220.0.w,height: 27.0.h,onPressed: (){

                                        _showPickerEtkinlikReddet(context,_card);

                                      }),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                          ],),
                        ),
                      ),
                    );
                  },
                );

              },
            ),

              SizedBox(height: 40.0.h,),

          ],) : Center(child: Text("Buraya Erişiminiz Yoktur.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
        ),
      ),



    );
  }


  void _showPickerEtkinlikReddet(context,DocumentSnapshot _card) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                   ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Uygunsuz Fotoğraf'),
                      onTap: () async {
                        var dialog = CustomAlertDialog(
                            message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                            onPostivePressed: () {
                              String mesaj= _card['baslik']+" başlıklı etkinliğiniz uygunsuz fotoğraftan dolayı reddedildi.";
                              _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            onNegativePressed: (){

                            },
                            positiveBtnText: 'Evet',
                            negativeBtnText: 'İptal');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog);

                      }),
                   ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Uygunsuz Başlık'),
                    onTap: () async {
                      var dialog = CustomAlertDialog(
                          message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                          onPostivePressed: () {
                            String mesaj= _card['baslik']+" başlıklı etkinliğiniz uygunsuz başlıktan dolayı reddedildi.";
                            _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
                            Navigator.pop(context);
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
                  ),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Uygunsuz İçerik'),
                    onTap: () async {
                      var dialog = CustomAlertDialog(
                          message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                          onPostivePressed: () {
                            String mesaj= _card['baslik']+" başlıklı etkinliğiniz uygunsuz içerikten dolayı reddedildi.";
                            _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
                            Navigator.pop(context);
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
                  ),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Diğer'),
                    onTap: () async {
                      var dialog = CustomAlertDialog(
                          message: "Bu etkinliği reddetmek istediğinize emin misiniz?",
                          onPostivePressed: () {
                            String mesaj= _card['baslik']+" başlıklı etkinliğiniz  reddedildi.";
                            _adminIslemleri.adminEtkinlikReddet(_card,mesaj);
                            Navigator.pop(context);
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
                  ),


                ],
              ),
            ),
          );
        });
  }


}
