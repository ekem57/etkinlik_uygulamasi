import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class BanliSayfasi extends StatefulWidget {
  DateTime zaman;
  BanliSayfasi({this.zaman});
  @override
  _BanliSayfasiState createState() => _BanliSayfasiState();
}

class _BanliSayfasiState extends State<BanliSayfasi> {
 static int kalangun;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   DateTime beklenentarih= widget.zaman.toLocal();
   kalangun= beklenentarih.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 20.0.w),
            child: IconButton(onPressed: (){
              _userModel.signOut();
            }, icon: Icon(Icons.exit_to_app,size: 40.0.w,)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 100.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("Admin Tarafından 3 ay süreli banlandınız.",style: TextStyle(fontSize: 25.0.spByWidth,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          SizedBox(height: 100.0.h,),
          Text("Hesabınızın açılmasına kalan süre:",style: TextStyle(fontSize: 20.0.spByWidth),),
            SizedBox(height: 10.0.h,),
          Text(kalangun.toString(),style: TextStyle(fontSize: 40.0.spByWidth,fontWeight: FontWeight.bold),),
          Text("Gün sonra hesabınız aktifleşecektir.",style: TextStyle(fontSize: 20.0.spByWidth,fontWeight: FontWeight.bold),),
        ],),
      ),
    );
  }
}
