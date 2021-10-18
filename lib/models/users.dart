import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/models/YoneticiYetkileri.dart';
import 'package:flutter/cupertino.dart';

class Users extends ChangeNotifier {
  String userId;
  String telefon;
  String email;
  String password;
  String adsoyad;
  String meslek;
  String iliskiDurumu;
  String cinsiyet;
  String sehir;
  String hakkimda;
  DateTime dogumTarihi;
  int yas;
  int etkinliksayim;
  int takip;
  int takipci;
  String avatarImageUrl;
  String photoFilePath;
  String uyelikTipi;
  DateTime hedefhafta;
  int acilanetkinliksayim;
  int katilinanetkinliksayim;
  int etkinlikKatilma;
  int etkinlikKatilmama;
  String hesapTipi;
  String ogrenimDurumu;
  String temsilciyeri;
  bool userbanvarmi;
  DateTime banAcilmaTarihi;
  List<String> kafalar = [];
  List<BlockedUser> blockedUsers = [];
  bool mavitik;
  String temsil;
  String sosyalmedyaadres;
  String facebook;
  String instagram;
  String twitter;
  String tiktok;
  bool profilgizlilik;
  bool yoneticimi;
  bool temsilcimi;
  YoneticiYetkileri yoneticiyetkileri;
  Users({
    this.userId,
    this.email,
    this.photoFilePath,
    this.dogumTarihi,
    this.password,
    this.adsoyad,
    this.meslek,
    this.sehir,
    this.iliskiDurumu,
    this.cinsiyet,
    this.yas,
    this.takip,
    this.takipci,
    this.etkinliksayim,
    this.avatarImageUrl,
    this.kafalar,
    this.mavitik,
    this.temsil,
    this.sosyalmedyaadres,
    this.facebook,
    this.instagram,
    this.twitter,
    this.tiktok,
    this.telefon,
    this.hakkimda,
    this.profilgizlilik,
    this.yoneticimi,
    this.temsilcimi,
    this.yoneticiyetkileri,
    this.uyelikTipi,
    this.hedefhafta,
    this.katilinanetkinliksayim,
    this.acilanetkinliksayim,
    this.hesapTipi,
    this.ogrenimDurumu,
    this.temsilciyeri,
    this.etkinlikKatilma,
    this.etkinlikKatilmama,
    this.userbanvarmi,
    this.banAcilmaTarihi,
  });

  Map<String, dynamic> toMap(Users users, String uid) {

    Map<String, dynamic> kullaniciVerileri = Map();
    kullaniciVerileri['userId'] = uid;
    kullaniciVerileri['ad'] = users.adsoyad;
    kullaniciVerileri['meslek'] = users.meslek;
    kullaniciVerileri['iliskiDurumu'] = users.iliskiDurumu;
    kullaniciVerileri['dogumTarihi'] = users.dogumTarihi;
    kullaniciVerileri['avatarImageUrl'] = users.avatarImageUrl == null
        ? "https://firebasestorage.googleapis.com/v0/b/etkinlik-kafasi-40b44.appspot.com/o/etkinlik_kafasi_genel_fotograflar%2Flogo.jpeg?alt=media&token=6400947d-e882-4607-ae3e-1fb5c89aabc3"
        : users.avatarImageUrl.toString();
    kullaniciVerileri['facebook'] = users.facebook == null ? "" : users.facebook;
    kullaniciVerileri['twitter'] = users.twitter == null ? "" : users.twitter;
    kullaniciVerileri['instagram'] = users.instagram == null ? "" : users.instagram;
    kullaniciVerileri['tiktok'] = users.tiktok == null ? "" : users.tiktok;
    kullaniciVerileri['cinsiyet'] = users.cinsiyet;
    kullaniciVerileri['sehir'] = users.sehir;
    kullaniciVerileri['photoFilePath'] = users.photoFilePath;
    kullaniciVerileri['etkinliksayim'] = 0;
    kullaniciVerileri['takip'] = 0;
    kullaniciVerileri['telefon'] = users.telefon;
    kullaniciVerileri['takipci'] = 0;
    kullaniciVerileri['yorumiyi'] = 0;
    kullaniciVerileri['yorumorta'] = 0;
    kullaniciVerileri['yorumkotu'] = 0;
    kullaniciVerileri['email'] = users.email;
    kullaniciVerileri['mavitik'] = false;
    kullaniciVerileri['profilGizlilik'] = false;
    kullaniciVerileri['yoneticimi'] = false;
    kullaniciVerileri['temsilcimi'] = false;
    kullaniciVerileri['hakkimda'] = users.hakkimda.isEmpty ? " " : users.hakkimda;
    kullaniciVerileri['kafalar'] = users.kafalar;
    kullaniciVerileri['uyelikTipi'] = users.uyelikTipi == null ? "plus" : users.uyelikTipi;
    kullaniciVerileri['hedefhafta'] = users.hedefhafta == null ? Timestamp.now() : users.hedefhafta;
    kullaniciVerileri['katilinanetkinliksayisi'] = users.katilinanetkinliksayim  == null ? 0 : users.katilinanetkinliksayim;
    kullaniciVerileri['acilanetkinliksayisi'] = users.acilanetkinliksayim == null ? 0 : users.acilanetkinliksayim;
    kullaniciVerileri['ogrenimdurumu'] = users.ogrenimDurumu == null ? " ": users.ogrenimDurumu;
    kullaniciVerileri['etkinlikKatildi'] = users.etkinlikKatilma == null ? 0: users.etkinlikKatilma;
    kullaniciVerileri['etkinlikKatilmadi'] = users.etkinlikKatilmama == null ? 0: users.etkinlikKatilmama;
    kullaniciVerileri['hesaptipi'] = users.hesapTipi == null ? "Bireysel" : users.hesapTipi;
    kullaniciVerileri['userbanvarmi'] = users.userbanvarmi == null ? false : users.userbanvarmi;
    kullaniciVerileri['banAcilmaTarihi'] = users.banAcilmaTarihi == null ? DateTime(2000) : users.banAcilmaTarihi;

    return kullaniciVerileri;
  }

  Users.fromMap(Map<String, dynamic> map)
      : adsoyad = map['ad'],
        meslek = map["meslek"],
        userId = map["userId"],
        iliskiDurumu = map["iliskiDurumu"],
        cinsiyet = map["cinsiyet"],
        email = map["email"],
        avatarImageUrl = map["avatarImageUrl"],
        facebook = map["facebook"],
        twitter = map["twitter"],
        instagram = map["instagram"],
        tiktok = map["tiktok"],
        photoFilePath = map["photoFilePath"],
        sehir = map["sehir"],
        etkinliksayim = map["etkinliksayim"],
        takip = map["takip"],
        telefon = map["telefon"],
        takipci = map["takipci"],
        hakkimda = map["hakkimda"],
        profilgizlilik = map["profilGizlilik"],
        yoneticimi = map["yoneticimi"],
        temsilcimi = map["temsilcimi"],
        uyelikTipi = map["uyelikTipi"],
        katilinanetkinliksayim = map["katilinanetkinliksayisi"],
        acilanetkinliksayim = map["acilanetkinliksayisi"],
        dogumTarihi = (map["dogumTarihi"] as Timestamp).toDate(),
        hedefhafta = (map["hedefhafta"] as Timestamp).toDate(),
        yas = ((map["dogumTarihi"] as Timestamp).toDate().difference(DateTime.now()).abs().inDays/365).ceil(),
        hesapTipi = map["hesaptipi"],
        ogrenimDurumu = map["ogrenimdurumu"],
        temsilciyeri = map["temsilciAdres"],
        mavitik = map["mavitik"],
        etkinlikKatilma = map["etkinlikKatildi"],
        etkinlikKatilmama = map["etkinlikKatilmadi"],
        userbanvarmi = map["userbanvarmi"],
        // blockedUsers = map["blockedUsers"] == null ?[]: map["blockedUsers"].map((e)=>BlockedUser.fromMap(e)).toList(),
        banAcilmaTarihi = (map["banAcilmaTarihi"] as Timestamp).toDate(),
        kafalar = List<String>.from(map["kafalar"] ?? []);

  Users.fromMapYonetici(Map<String, dynamic> map,YoneticiYetkileri yoneticiYetkileri)
      : adsoyad = map['ad'],
        meslek = map["meslek"],
        userId = map["userId"],
        iliskiDurumu = map["iliskiDurumu"],
        cinsiyet = map["cinsiyet"],
        email = map["email"],
        avatarImageUrl = map["avatarImageUrl"],
        facebook = map["facebook"],
        twitter = map["twitter"],
        instagram = map["instagram"],
        tiktok = map["tiktok"],
        photoFilePath = map["photoFilePath"],
        sehir = map["sehir"],
        etkinliksayim = map["etkinliksayim"],
        takip = map["takip"],
        telefon = map["telefon"],
        takipci = map["takipci"],
        hakkimda = map["hakkimda"],
        profilgizlilik = map["profilGizlilik"],
        yoneticimi = map["yoneticimi"],
        temsilcimi = map["temsilcimi"],
        uyelikTipi = map["uyelikTipi"],
         mavitik = map["mavitik"],
        katilinanetkinliksayim = map["katilinanetkinliksayisi"],
        acilanetkinliksayim = map["acilanetkinliksayisi"],
        dogumTarihi = (map["dogumTarihi"] as Timestamp).toDate(),
        hedefhafta = (map["hedefhafta"] as Timestamp).toDate(),
        yas = ((map["dogumTarihi"] as Timestamp).toDate().difference(DateTime.now()).abs().inDays/365).ceil(),
        kafalar = List<String>.from(map["kafalar"] ?? []),
        hesapTipi = map["hesaptipi"],
        ogrenimDurumu = map["ogrenimdurumu"],
        temsilciyeri = map["temsilciAdres"],
        etkinlikKatilma = map["etkinlikKatildi"],
        etkinlikKatilmama = map["etkinlikKatilmadi"],
        // blockedUsers = map["blockedUsers"] == null ?[]: map["blockedUsers"].map((e)=>BlockedUser.fromMap(e)).toList(),
        banAcilmaTarihi = (map["banAcilmaTarihi"] as Timestamp).toDate(),
        yoneticiyetkileri = yoneticiYetkileri;

  Users.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data());

  @override
  String toString() {
    return "User: uid: $userId  adsoyad: $adsoyad, email: $email,  meslek: $meslek, dogumtarihi: $dogumTarihi, cinsiyet: $cinsiyet, sehir: $sehir ,mavitik:$mavitik";
  }
}

class BlockedUser{
  final String name;
  final String userId;

  BlockedUser(this.name, this.userId);
  BlockedUser.fromMap(Map<String, dynamic> map)
      :name = map["name"],
      userId = map["userId"];
}
