import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/authBase.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_auth_service.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/konusma.dart';
import 'package:etkinlik_kafasi/models/mesaj.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:timeago/timeago.dart' as timeago;

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

 // BildirimGondermeServis _bildirimGondermeServis = locator<BildirimGondermeServis>();

  Map<String, String> kullaniciToken = Map<String, String>();

  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  AppMode appMode = AppMode.RELEASE;
  List<Users> tumKullaniciListesi = [];

  @override
  Future<Users> currentUser() async {
    Users _user = await _firebaseAuthService.currentUser();
    if (_user != null)
      return await _firestoreDBService.readUser(_user.userId, _user.email);
    else
      return null;
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  Future<Users> createUserWithEmailandPassword(String email, String sifre, Users users, String tel, String uid) async {
    bool _sonuc = await _firestoreDBService.saveUser(Users(
        email: email,
        dogumTarihi: users.dogumTarihi,
        password: users.password,
        adsoyad: users.adsoyad,
        meslek: users.meslek,
        iliskiDurumu: users.iliskiDurumu,
        cinsiyet: users.cinsiyet,
        sehir: users.sehir,
        telefon: tel,
        userId: uid,
        hakkimda: "",
        ogrenimDurumu: users.ogrenimDurumu,
        hesapTipi: users.hesapTipi));
    if (_sonuc) {
      return await _firestoreDBService.readUser(uid, email);
    }
  }

  @override
  Future<Users> signInWithEmailandPassword(String email, String sifre) async {
    Users _user = await _firebaseAuthService.signInWithEmailandPassword(email, sifre);

    return await _firestoreDBService.readUser(_user.userId, email);
  }

  //Mesajlaşma kısmı başlıyor

  Stream<List<Mesaj>> getMessages(String currentUserID, String sohbetEdilenUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getMessages(currentUserID, sohbetEdilenUserID);
    }
  }

  Stream<List<DocumentSnapshot>> getMessagesDoc(String currentUserID, String sohbetEdilenUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getMessagesDoc(currentUserID, sohbetEdilenUserID);
    }
  }

  Future<bool> mesajguncelle(String currentUserID, String sohbetEdilenUserID, String Docid) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbGuncellemeIslemi = await _firestoreDBService.mesajguncelle(currentUserID, sohbetEdilenUserID, Docid);
      return dbGuncellemeIslemi;
    }
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, Users currentUser) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbYazmaIslemi = await _firestoreDBService.saveMessage(kaydedilecekMesaj, currentUser.userId);

      if (dbYazmaIslemi) {
        var token = "";

        token = await _firestoreDBService.tokenGetir(kaydedilecekMesaj.kime);
        if (token != null) kullaniciToken[kaydedilecekMesaj.kime] = token;

       // if (token != null) await _bildirimGondermeServis.bildirimGonder(kaydedilecekMesaj, currentUser, token);

        return true;
      } else
        return false;
    }
  }

  Stream<List<Konusma>> getAllConversations(String userID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      var konusmaListesi = _firestoreDBService.getAllConversations(userID);

      return konusmaListesi;
    }
  }

  void timeagoHesapla(Konusma oankiKonusma, Timestamp zaman) {
    oankiKonusma.sonOkunmaZamani = zaman;

    timeago.setLocaleMessages("tr", timeago.TrMessages());

    var _duration = zaman.toDate().difference(oankiKonusma.olusturulma_tarihi.toDate());
    oankiKonusma.aradakiFark = timeago.format(zaman.toDate().subtract(_duration), locale: "tr");
  }

  Future<List<Users>> getUserwithPagination(Users enSonGetirilenUser, int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      List<Users> _userList =
          await _firestoreDBService.getUserwithPagination(enSonGetirilenUser, getirilecekElemanSayisi);
      tumKullaniciListesi.addAll(_userList);
      return _userList;
    }
  }

  Future<List<Mesaj>> getMessageWithPagination(
      String currentUserID, String sohbetEdilenUserID, Mesaj enSonGetirilenMesaj, int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      return await _firestoreDBService.getMessagewithPagination(
          currentUserID, sohbetEdilenUserID, enSonGetirilenMesaj, getirilecekElemanSayisi);
    }
  }

  Users listedeUserBul(String userID) {
    for (int i = 0; i < tumKullaniciListesi.length; i++) {
      if (tumKullaniciListesi[i].userId == userID) {
        return tumKullaniciListesi[i];
      }
    }

    return null;
  }
}
