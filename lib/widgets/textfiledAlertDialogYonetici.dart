import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminFirebaseIslemleri.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class TextfieldAlertDialogYonetici extends StatefulWidget {

  String title;
  DocumentSnapshot card;

  TextfieldAlertDialogYonetici({
    this.title,
    this.card,
  }) ;

  @override
  _TextfieldAlertDialogYoneticiState createState() => _TextfieldAlertDialogYoneticiState();
}
class _TextfieldAlertDialogYoneticiState extends State<TextfieldAlertDialogYonetici>with AutomaticKeepAliveClientMixin {

  AdminFirebaseIslemleri _adminIslemleri = locator<AdminFirebaseIslemleri>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    TextEditingController editingController = TextEditingController();
    return AlertDialog(
      contentPadding: EdgeInsets.all(15.0.w),
      insetPadding: EdgeInsets.all(12.0.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title:  Text(widget.title,textAlign: TextAlign.center,),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 140.0.h,
        child: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Divider(thickness: 0.5,color: Colors.black,),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
              child: TextFormField(
                controller: editingController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines: 2,
                style: TextStyle(fontSize: 15.0.spByWidth),
                decoration: InputDecoration(
                  hintText: "Yönetici Yeri",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.0.w,vertical: 20.0.h),
              child: MyButton(text: "Gönder", butonColor: Renkler.onayButonColor,
                  fontSize: 15.0.spByWidth, width: 157.0.w, height: 33.0.h,
                  onPressed: (){
                    _adminIslemleri.adminYoneticiAta(widget.card);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}


