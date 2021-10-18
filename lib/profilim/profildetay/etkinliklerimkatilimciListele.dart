import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../profilSayfalari/kullaniciprofili.dart';
import '../../widgets/resimliCard.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class KatilimcilarinListesi extends StatefulWidget {
  String etid;
  KatilimcilarinListesi({this.etid});
  @override
  _KatilimcilarinListesiState createState() => _KatilimcilarinListesiState();
}

class _KatilimcilarinListesiState extends State<KatilimcilarinListesi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Katılımcılar"),),
      body: FutureBuilder<QuerySnapshot>(
        future: futureget(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          final int cardLength = snapshot.data.docs.length;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cardLength,
            itemBuilder: (_, int index) {
              final DocumentSnapshot _cardFuture = snapshot.data.docs[index];
            return  StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(_cardFuture['userid']).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  final int cardLength = 1;
                  final DocumentSnapshot _card = snapshot.data;
                  return cardLength == 0 ?
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.6 ,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("Etkinlik Katılımcı Yok")),
                  ) :
                   ResimliCard(
                      textSubtitle: null,
                      textTitle: _card['ad'].toString(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => KarsiKullaniciProfili(card: _card.data(),)),
                        );
                      },
                      fontSize: 12.0.spByWidth,
                      img: _card['avatarImageUrl'].toString(),
                      tarih: null);

                },
              );
            },
          );
        },
      ),
    );
  }
  Future<QuerySnapshot> futureget() async {
      QuerySnapshot qn = await FirebaseFirestore.instance
          .collection("etkinlik")
          .doc(widget.etid)
          .collection("katilimciList")
          .get();
      return qn;

  }
}
