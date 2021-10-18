import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/myButton.dart';
import 'package:etkinlik_kafasi/widgets/oylamaEmojileriEtkin.dart';
import 'package:etkinlik_kafasi/widgets/oylama_emojleri.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class YorumYapAlertDialog extends StatefulWidget {
  final String ad;
  final String profilFoto;
   String emoji;
  final Function Pressed;
   TextEditingController yorumController;
   String karsiuserid;
   String etid;
   String carid;


  YorumYapAlertDialog({
    this.ad,
    this.emoji,
    this.karsiuserid,
    this.etid,
    this.carid,
    this.profilFoto,
    this.yorumController,
    this.Pressed,
  }) ;

  @override
  _YorumYapAlertDialogState createState() => _YorumYapAlertDialogState();
}
class _YorumYapAlertDialogState extends State<YorumYapAlertDialog>with AutomaticKeepAliveClientMixin {

  final String notr = "assets/notr.png";
  final String notrActive = "assets/notr_active.png";
  final String olumlu = "assets/olumlu.png";
  final String olumluActive = "assets/olumlu_active.png";
  final String olumsuz = "assets/olumsuz.png";
  final String olumsuzActive = "assets/olumsuz_active.png";
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return AlertDialog(
      contentPadding: EdgeInsets.all(15.0.w),
      insetPadding: EdgeInsets.all(15.0.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0.w)),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilFoto),
            radius: 30.70.w,
          ),
          Column(

            children: [
              SizedBox(height: 5.0.h,),
              Text(widget.ad,style: TextStyle(fontSize: 15.0.h),),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("etkinlikKatilimYorum").doc(_userModel.user.userId).collection("katilimci").where('karsiuser',isEqualTo: widget.karsiuserid).where('etid',isEqualTo: widget.etid.toString())
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (!snapshot2.hasData) return Container();
                    return  snapshot2.data.docs.toString() == "[]" ?
                    OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.etid.toString(),karsiuser: widget.karsiuserid.toString(),carid: widget.carid,)
                        : snapshot2.data.docs[0]['onay'] == true ?
                    OylamaEmojileriEtkin(deger: snapshot2.data.docs[0]['yorumdeger'].toString(),userid:_userModel.user.userId ,etid: widget.etid.toString(),karsiuser: widget.karsiuserid.toString(),carid: widget.carid,):
                    OylamaEmojileri(userid:_userModel.user.userId ,etid: widget.etid.toString(),karsiuser: widget.karsiuserid,carid: widget.carid,);
                  }),

            ],
          ),

        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 185.0.h,
        child: ListView(
          children: [
            Divider(thickness: 0.5,color: Colors.black,),

            TextFormField(
              controller: widget.yorumController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLines: 3,
              style: TextStyle(fontSize: 15.0.h),
              decoration: InputDecoration(
                hintText: "Yorumunuz",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.0.w,vertical: 20.0.h),
              child: MyButton(text: "Gönder", butonColor: Renkler.onayButonColor,
                fontSize: 15.0.h, width: 157.0.w, height: 35.0.h,
                onPressed: widget.Pressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


