import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/helpers.dart';

class EtkinlikModel {
  int katilimciSayisi;
  String id;
  String baslik;
  String etkinlikID;
  String etkinlikFoto;
  String konum;
  DateTime tarih;
  String saat;
  String yayinlayanAdSoyad;
  String userId;
  String hakkinda;
  String etkinlikTipi;
  int katilimci;
  int kimKatilabilir;
  int gelensayisi;
  String etid;
  List kategori;
  List keywords;
  List il;
  List cinsiyet;
  List ogrenimdurumu;
  String yasaraligi;
  List meslek;
  List iliskidurumu;
  bool yonetici;
  int etkinlikKatildi;
  int maxkatilimcisayisi;


  EtkinlikModel(
      {this.id,
      this.baslik,
      this.etkinlikFoto,
        this.iliskidurumu,
        this.maxkatilimcisayisi,
        this.yonetici,
        this.etkinlikKatildi,
        this.etkinlikTipi,
        this.kimKatilabilir,
        this.gelensayisi,
        this.ogrenimdurumu,
        this.il,
        this.cinsiyet,
        this.yasaraligi,
        this.meslek,
      this.konum,
      this.yayinlayanAdSoyad,
      this.userId,
      this.etkinlikID,
      this.tarih,
      this.saat,
      this.hakkinda,
      this.etid,
      this.katilimci,
      this.katilimciSayisi,
      this.kategori});

  EtkinlikModel.fromMap(Map<String, dynamic> map)
      :
        this.tarih = map["tarih"].toDate(),
        this.saat = map["saat"],
        this.baslik = map["baslik"],
        this.etkinlikFoto = map["etkinlikFoto"],
        this.konum = map["konum"],
        this.etid = map["etid"],
        this.katilimci = map["katilimci"],
        this.yayinlayanAdSoyad = map["yayinlayanAdSoyad"],
        this.userId = map["userId"],
        this.kategori = map["kategori"],
        this.keywords = map["keywords"],
        this.hakkinda = map["hakkinda"];

  EtkinlikModel.fromSnapshot({DocumentSnapshot snapshot}) : this.fromMap(snapshot.data());

  Map<String, String> kalanSure() {}
}

//}}
