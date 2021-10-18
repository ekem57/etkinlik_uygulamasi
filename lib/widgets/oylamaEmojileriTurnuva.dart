import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class OylamaEmojileriEtkinTurnuva extends StatefulWidget {

  String deger;
  final String userid;
  final String etid;
  final String karsiuser;
  final String carid;

  OylamaEmojileriEtkinTurnuva({Key key,this.deger,this.userid,this.etid,this.karsiuser,this.carid}) : super(key: key);
  @override
  _OylamaEmojileriEtkinTurnuvaState createState() => _OylamaEmojileriEtkinTurnuvaState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _OylamaEmojileriEtkinTurnuvaState extends State<OylamaEmojileriEtkinTurnuva>with AutomaticKeepAliveClientMixin {
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
    print("OYLAMA EMOJİLERİ TURNUVA YA GELDİ");
    super.build(context);
    return FittedBox(
      child: Row(

        children: [
          IconButton(
              icon: Image.asset(widget.deger == "olumsuz" ? olumsuzActive : olumsuz),
              onPressed: () {
                setState(() {
                  selectedEmoji = "olumsuz";
                  widget.deger="olumsuz";
                });
                _firestoreDBService.emojiDegerlendirmeGuncelleTurnuva(widget.userid , "olumsuz",widget.etid,widget.karsiuser,widget.carid);

              },iconSize: 30.0.w),
          IconButton(icon: Image.asset(widget.deger == "notr" ? notrActive : notr), onPressed: () {
            setState(() {
              selectedEmoji = "notr";
              widget.deger="notr";
            });
            _firestoreDBService.emojiDegerlendirmeGuncelleTurnuva(widget.userid , "notr",widget.etid,widget.karsiuser,widget.carid);

          },iconSize: 30.0.w),
          IconButton(icon: Image.asset(widget.deger == "olumlu" ? olumluActive : olumlu), onPressed: () {
            setState(() {
              selectedEmoji = "olumlu";
              widget.deger="olumlu";
            });
            _firestoreDBService.emojiDegerlendirmeGuncelleTurnuva(widget.userid , "olumlu",widget.etid,widget.karsiuser,widget.carid);


          },iconSize: 30.0.w),
        ],
      ),
    );
  }
}
