import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/adminkullanicicontainer.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:etkinlik_kafasi/widgets/CustomCheckBox.dart';
import 'package:etkinlik_kafasi/widgets/loading.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Yetkilendirme extends StatefulWidget {
  final Map<String, dynamic> card;
  final DocumentSnapshot cardYonetici;
  Yetkilendirme({this.card,this.cardYonetici});

  @override
  _YetkilendirmeState createState() => _YetkilendirmeState();
}

FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _YetkilendirmeState extends State<Yetkilendirme>
    with SingleTickerProviderStateMixin {

  int toplamEtkinlikSayim = 0;

  bool _value1;
  bool _value2;
  bool _value3;
  bool _value4;
  bool _value5;
  bool _value6;

  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();
  bool isLoading = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value1= !widget.cardYonetici['moderator_atama'];
    _value2= !widget.cardYonetici['etkinlik_onay'];
    _value3= !widget.cardYonetici['mavi_tik'];
    _value4= !widget.cardYonetici['temsilci_atama'];
    _value5= !widget.cardYonetici['uye_islemleri'];
    _value6= !widget.cardYonetici['reklam_yetkisi'];

  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          leading:  Padding(
            padding:  EdgeInsets.only(left: 25.0.w),
            child: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,size: 20.0.w,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),

        ),
        body: isLoading
            ? Loading() :Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.38,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(21.70.h),
                    bottomLeft: Radius.circular(21.70.h),
                  ),
                ),
                child: AdminKarsiKullaniciInfoContainer(card: widget.card,),
              ),
              SizedBox(height: 50.0.h,),


              CustomCheckBox(text: "Moderatör atama yetkisi", onPressed: () {
                setState(() {
                  _value1 = !_value1;
                });
              }, fontSize: 12.0.spByWidth,value: _value1,),

              CustomCheckBox(text: "Etkinlik onay yetkisi", onPressed: () {
                setState(() {
                  _value2 = !_value2;
                });
              }, fontSize: 12.0.spByWidth,value: _value2,),

              CustomCheckBox(text: "Mavi tik yetkisi", onPressed: () {
                setState(() {
                  _value3 = !_value3;
                });
              }, fontSize: 12.0.spByWidth,value: _value3,),

              CustomCheckBox(text: "Temsilci atama yetkisi", onPressed: () {
                setState(() {
                  _value4 = !_value4;
                });
              }, fontSize: 12.0.spByWidth,value: _value4,),

              CustomCheckBox(text: "Üye işlemleri yetkisi", onPressed: () {
                setState(() {
                  _value5 = !_value5;
                });
              }, fontSize: 12.0.spByWidth,value: _value5,),

              CustomCheckBox(text: "Reklam yetkisi", onPressed: () {
                setState(() {
                  _value6 = !_value6;
                });
              }, fontSize: 12.0.spByWidth,value: _value6,),

              Padding(
                padding:  EdgeInsets.only(left: 30.0.w,right: 30.0.w,top: 20.0.h),
                child: MyButton(text: "Kaydet", textColor: Colors.black, fontSize: 19.0.spByWidth,
                    width: MediaQuery.of(context).size.width, height: 35.0.h,
                    onPressed: () async {

                      setState(() {
                        isLoading = true;
                      });

                      Map<String, dynamic> Yetkilendirme = Map();
                      Yetkilendirme['moderator_atama']= !_value1;
                      Yetkilendirme['etkinlik_onay']= !_value2;
                      Yetkilendirme['mavi_tik']= !_value3;
                      Yetkilendirme['temsilci_atama']= !_value4;
                      Yetkilendirme['uye_islemleri']= !_value5;
                      Yetkilendirme['reklam_yetkisi']= !_value6;

                      bool veri =  await _adminIslemleri.adminYetkilendirme(Yetkilendirme,widget.card['userId']);

                      if(veri)
                      {
                        setState(() {
                          isLoading = false;
                        });
                        Fluttertoast.showToast(
                          msg: "Yetkiler Kaydedildi.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.white,
                          backgroundColor: Colors.purpleAccent,
                        );

                      }
                   },
                ),
              ),

            ],
          ),
        ),
      );
  }
}
