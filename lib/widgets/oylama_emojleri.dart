import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class OylamaEmojileri extends StatefulWidget {

  final String userid;
  final String etid;
  final String karsiuser;
  final String carid;

  const OylamaEmojileri({Key key,this.userid,this.etid,this.karsiuser,this.carid}) : super(key: key);
  @override
  _OylamaEmojileriState createState() => _OylamaEmojileriState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _OylamaEmojileriState extends State<OylamaEmojileri>with AutomaticKeepAliveClientMixin {
  String selectedEmoji = "";
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
    super.build(context);
    return FittedBox(
      child: Row(
        children: [
          IconButton(
              icon: Image.asset(selectedEmoji == "olumsuz" ? olumsuzActive : olumsuz),
              onPressed: () {
                setState(() {
                  selectedEmoji = "olumsuz";
                });
                _firestoreDBService.emojiDegerlendirkaydet(widget.userid , "olumsuz",widget.etid,widget.karsiuser,widget.carid);

              },iconSize: 30.0.w,),
          IconButton(icon: Image.asset(selectedEmoji == "notr" ? notrActive : notr), onPressed: () {
            setState(() {
              selectedEmoji = "notr";
            });
            _firestoreDBService.emojiDegerlendirkaydet(widget.userid , "notr",widget.etid,widget.karsiuser,widget.carid);

          },iconSize: 30.0.w),
          IconButton(icon: Image.asset(selectedEmoji == "olumlu" ? olumluActive : olumlu), onPressed: () {
            setState(() {
              selectedEmoji = "olumlu";
            });
            _firestoreDBService.emojiDegerlendirkaydet(widget.userid , "olumlu",widget.etid,widget.karsiuser,widget.carid);



          },iconSize: 30.0.w),
        ],
      ),
    );
  }
}
