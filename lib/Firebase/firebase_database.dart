import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/YoneticiYetkileri.dart';
import 'package:etkinlik_kafasi/models/konusma.dart';
import 'package:etkinlik_kafasi/models/mesaj.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirestoreDBService {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  //BildirimGondermeServis _bildirimGondermeServis = locator<BildirimGondermeServis>();

  @override
  Future<bool> saveUser(Users user) async {
    await _firebaseDB.collection("users").doc(user.userId).set(user.toMap(user, user.userId));

    await _firebaseDB
        .collection("users")
        .doc(user.userId)
        .collection("profil_iconlar")
        .doc("adaletli")
        .set({'sayi': 0});
    await _firebaseDB.collection("users").doc(user.userId).collection("profil_iconlar").doc("cilgin").set({'sayi': 0});
    await _firebaseDB.collection("users").doc(user.userId).collection("profil_iconlar").doc("comert").set({'sayi': 0});
    await _firebaseDB
        .collection("users")
        .doc(user.userId)
        .collection("profil_iconlar")
        .doc("guvenilir")
        .set({'sayi': 0});
    await _firebaseDB.collection("users").doc(user.userId).collection("profil_iconlar").doc("ek").set({'sayi': 0});
    await _firebaseDB.collection("users").doc(user.userId).collection("profil_iconlar").doc("lider").set({'sayi': 0});
    await _firebaseDB
        .collection("users")
        .doc(user.userId)
        .collection("profil_iconlar")
        .doc("romantik")
        .set({'sayi': 0});
    await _firebaseDB.collection("users").doc(user.userId).collection("profil_iconlar").doc("saygili").set({'sayi': 0});
    return true;
  }

  Future<void> setMeAsVisitor({String profileOwnerUserId, String name, String imageUrl, String myUserId}) {
    return _firebaseDB
        .collection("users")
        .doc(profileOwnerUserId)
        .collection("visitors")
        .add({"name": name, "image": imageUrl, "userId": myUserId, "date": Timestamp.fromDate(DateTime.now())});
  }

  Future<QuerySnapshot> getVisitorsData(String userId) async {
    return await _firebaseDB.collection("users").doc(userId).collection("visitors").orderBy("date",  descending: true).get();
  }

  Future<void> deleteVisitorTile(String userId, String documentId) async {
    return await _firebaseDB.collection("users").doc(userId).collection("visitors").doc(documentId).delete();
  }

  Future<void> blockUser(BuildContext context, String userId, String blockedUserId, String blockedUserName) {
    var blockedUser = BlockedUser(blockedUserName,blockedUserId);
    context.read<UserModel>().blockUser(blockedUser);
    return _firebaseDB
        .collection("users")
        .doc(userId)
        .collection("blockedUsers")
        .doc(blockedUserId)
        .set({"userId": blockedUserId, "name": blockedUserName});
  }

  Future<List<BlockedUser>> getBlockedUsers(String userId) async {
    var docRef = await _firebaseDB.collection("users").doc(userId).collection("blockedUsers").get();
    return docRef.docs.map((e) => BlockedUser.fromMap(e.data())).toList();
  }

  Future<bool> deleteBlockedUser(String blockedUserId, userId) async {
    await _firebaseDB.collection("users").doc(userId).collection("blockedUsers").doc(blockedUserId).delete();
    return true;
  }

  Future<void> reportUser(String reportedUseremail, String reportedUserId) {
    return _firebaseDB.collection("reportedUsers").add({"userId": reportedUserId, "email": reportedUseremail});
  }

  Future<bool> checkParticipant(String eventId, String userId) async {
    var document = await _firebaseDB.collection("etkinlik").doc(eventId).collection("katilimcilar").doc(userId).get();
    return document.exists;
  }

  @override
  Future<Users> readUser(String userID, String email) async {
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("users").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    if (_okunanUser.data != null) {
      Users _okunanUserNesnesi;
      if (_okunanUserBilgileriMap['yoneticimi'].toString() == "true") {
        DocumentSnapshot documentSnapshot =
            await _firebaseDB.collection("yonetici").doc(_okunanUserBilgileriMap['userId']).get();
        YoneticiYetkileri _yoneticiYetkileri = YoneticiYetkileri.fromMap(documentSnapshot.data());
        _okunanUserNesnesi = Users.fromMapYonetici(_okunanUserBilgileriMap, _yoneticiYetkileri);
      } else {
        _okunanUserNesnesi = Users.fromMap(_okunanUserBilgileriMap);
      }
      _okunanUserNesnesi.blockedUsers = await getBlockedUsers(userID);

      return _okunanUserNesnesi;
    } else {
      return null;
    }
  }

  @override
  Future<void> adminEtkinlikOnayla(DocumentSnapshot card) async {
    Map<String, dynamic> etkinliklerim = Map();

    etkinliklerim['etid'] = card['etid'].toString();
    etkinliklerim['tarih'] = card['tarih'];

    _firebaseDB
        .collection("users")
        .doc(card['userId'].toString())
        .collection("etkinliklerim")
        .doc(card.id)
        .set(etkinliklerim);

    _firebaseDB.collection("users").doc(card['userId'].toString()).update({"etkinliksayim": FieldValue.increment(1)});

    await _firebaseDB.collection("etkinlik").doc(card.id).set(card.data()).then((value) {
      _firebaseDB.collection("etkinlikOnayBekleyenler").doc(card.id).delete();
    });
  }

  @override
  Future<void> adminEtkinlikDavetlileriGetir(DocumentSnapshot card) async {
    Map<String, dynamic> etkinliklerim = Map();

    etkinliklerim['etid'] = card['etid'].toString();
    etkinliklerim['tarih'] = card['tarih'];
    String etsahibi = card['yayinlayanAdSoyad'].toString().toUpperCase();
    _firebaseDB
        .collection("users")
        .doc(card['userId'].toString())
        .collection("etkinliklerim")
        .doc(card.id)
        .set(etkinliklerim);

    await _firebaseDB.collection("etkinlik").doc(card.id).set(card.data()).then((value) {
      _firebaseDB.collection("etkinlikOnayBekleyenler").doc(card.id).delete();
    });

    QuerySnapshot veri =
        await _firebaseDB.collection("etkinlikOnayBekleyenler").doc(card.id).collection("davetliler").get();
    for (DocumentSnapshot snap in veri.docs) {
      await _firebaseDB.collection("etkinlik").doc(card.id).collection("davetliler").doc(snap.id).set(snap.data());
      await _firebaseDB.collection("users").doc(snap['userid']).collection("bildirimler").doc().set({
        'icerik': '$etsahibi sizi özel etkinliğine davet etti.',
        'tarih': DateTime.now(),
        'etid': card.id,
        'okundu': false
      });
    }
    await _firebaseDB.collection("etkinlikOnayBekleyenler").doc(card.id).delete();
  }

  @override
  Future<void> adminEtkinlikReddet(DocumentSnapshot card, String mesaj) async {
    QuerySnapshot veri =
        await _firebaseDB.collection("etkinlikOnayBekleyenler").doc(card.id).collection("davetliler").get();

    for (DocumentSnapshot snap in veri.docs) {
      print(snap.reference.path);
      await snap.reference.delete();
    }
    _firebaseDB.collection("etkinlikOnayBekleyenler").doc(card.id).delete();
    _firebaseDB
        .collection("users")
        .doc(card['userId'])
        .collection("bildirimler")
        .doc()
        .set({'icerik': mesaj, 'okundu': false, 'tarih': Timestamp.now(), 'etid': null});
  }

  @override
  Future<void> adminSikayetSil(DocumentSnapshot card) async {
    card.reference.delete();
  }

  @override
  Future<void> adminOneriSil(DocumentSnapshot card) async {
    card.reference.delete();
  }

  @override
  Future<void> adminReklamlarSil(DocumentSnapshot card) async {
    card.reference.delete();
  }

  @override
  Future<void> adminMaviTikSil(DocumentSnapshot card) async {
    card.reference.delete();
  }

  @override
  Future<void> adminDigerSil(DocumentSnapshot card) async {
    card.reference.delete();
  }

  @override
  Future<void> adminTemsilciGorevdenAl(DocumentSnapshot card) async {
    card.reference.delete();
    _firebaseDB.collection("users").doc(card['userId'].toString()).update({"temsilcimi": false});
  }

  @override
  Future<void> adminYoneticiGorevdenAl(DocumentSnapshot card) async {
    card.reference.delete();
    _firebaseDB.collection("users").doc(card['userId'].toString()).update({"yoneticimi": false});
  }

  @override
  Future<void> adminReklamSil(DocumentSnapshot card) async {
    _firebaseDB.collection("reklamlar").doc(card.id).delete();
  }

  @override
  Future<bool> adminYoneticiAta(DocumentSnapshot card) async {
    Map<String, dynamic> Yonetici = Map();
    Yonetici['userId'] = card['userId'].toString();
    Yonetici['etkinlik_onay'] = false;
    Yonetici['mavi_tik'] = false;
    Yonetici['moderator_atama'] = false;
    Yonetici['reklam_yetkisi'] = false;
    Yonetici['temsilci_atama'] = false;
    Yonetici['uye_islemleri'] = false;
    _firebaseDB.collection("yonetici").doc(card['userId']).set(Yonetici);
    _firebaseDB.collection("users").doc(card['userId']).update({'yoneticimi': true});
    return true;
  }

  @override
  Future<bool> adminPaketDegistir(String userid, String paketadi) async {
    _firebaseDB.collection("users").doc(userid).update({'uyelikTipi': paketadi});
    return true;
  }

  @override
  Future<bool> adminTemsilciAta(DocumentSnapshot card, String temsilciadres) async {
    _firebaseDB.collection("users").doc(card['userId']).update({'temsilcimi': true});
    _firebaseDB.collection("users").doc(card['userId']).update({'temsilciAdres': temsilciadres});
    _firebaseDB.collection("temsilciler").doc(card['userId']).set({'userId': card['userId']});
    return true;
  }

  @override
  Future<bool> adminReklamOlustur(Map<String, dynamic> card) async {
    await _firebaseDB.collection("reklamlar").doc().set(card);
    return true;
  }

  @override
  Future<bool> adminReklamDuzenle(Map<String, dynamic> card, String docid) async {
    await _firebaseDB.collection("reklamlar").doc(docid).update(card);
    return true;
  }

  @override
  Future<bool> adminEtkinlikOlustur(Map<String, dynamic> card) async {
    await _firebaseDB.collection("etkinlik").doc().set(card);
    return true;
  }

  @override
  Future<bool> takipetButonu(String userid, String takipedilenuserid) async {
    print("takipedilenuserid:" + takipedilenuserid + "   userid:" + userid);
    await _firebaseDB
        .collection("users")
        .doc(userid)
        .collection("takipEttiklerim")
        .doc(takipedilenuserid)
        .set({'userid': takipedilenuserid});
    await _firebaseDB
        .collection("users")
        .doc(takipedilenuserid)
        .collection("takipcilerim")
        .doc(userid)
        .set({'userid': userid});
    await _firebaseDB.collection("users").doc(userid).update({'takip': FieldValue.increment(1)});
    await _firebaseDB.collection("users").doc(takipedilenuserid).update({'takipci': FieldValue.increment(1)});
    return true;
  }

  @override
  Future<bool> takipCikButonu(String userid, String takipedilenuserid) async {
    await _firebaseDB.collection("users").doc(userid).collection("takipEttiklerim").doc(takipedilenuserid).delete();
    await _firebaseDB.collection("users").doc(takipedilenuserid).collection("takipcilerim").doc(userid).delete();
    await _firebaseDB.collection("users").doc(userid).update({'takip': FieldValue.increment(-1)});
    await _firebaseDB.collection("users").doc(takipedilenuserid).update({'takipci': FieldValue.increment(-1)});
    return true;
  }

  @override
  Future<bool> etkinlikKatilButonu(String etid, String userid) async {
    await _firebaseDB.collection("etkinlik").doc(etid).update({'katilimaIstegi': FieldValue.increment(-1)});

    _firebaseDB.runTransaction((Transaction transaction) async {
      transaction.update(_firebaseDB.collection("etkinlik").doc(etid), {'katilimci': FieldValue.increment(1)});
    });

    Map<String, dynamic> KatilimciEkle = Map();

    KatilimciEkle['userid'] = userid;
    KatilimciEkle['yorumdeger'] = null;
    KatilimciEkle['yorumdurumu'] = false;
    KatilimciEkle['katilmaYorumu'] = false;

    await _firebaseDB.collection("etkinlik").doc(etid).collection("katilimcilar").doc(userid).set(KatilimciEkle);
    await _firebaseDB.collection("users").doc(userid).collection("katilim").add({"etid":etid});

    await _firebaseDB.collection("etkinlikKatilimİstekleri").doc(etid).collection("katilimcilar").doc(userid).delete();

    Map<String, dynamic> EtkinlikEkle = Map();

    EtkinlikEkle['etid'] = etid;
    EtkinlikEkle['onay'] = "katildi";
    await _firebaseDB.collection("usersEtkinlik").doc(userid).collection("katilimci").doc(etid).set(EtkinlikEkle);
    await _firebaseDB.collection("users").doc(userid).update({'katilinanetkinliksayisi': FieldValue.increment(1)});

    return true;
  }

  @override
  Future<bool> etkinlikKatilmaIstegiButonu(DocumentSnapshot card, String userid, String istegiatanisim) async {
    Map<String, dynamic> EtkinlikIstek = Map();

    EtkinlikIstek['etid'] = card['etid'];
    EtkinlikIstek['userid'] = userid;

    await _firebaseDB.collection("etkinlik").doc(card['etid']).update({'katilimaIstegi': FieldValue.increment(1)});

    await _firebaseDB
        .collection("etkinlikKatilimİstekleri")
        .doc(card['etid'].toString())
        .collection("katilimcilar")
        .doc(userid)
        .set(EtkinlikIstek);

    Map<String, dynamic> EtkinlikEkle = Map();

    EtkinlikEkle['etid'] = card['etid'];
    EtkinlikEkle['onay'] = "istekte";
    await _firebaseDB
        .collection("usersEtkinlik")
        .doc(userid)
        .collection("katilimci")
        .doc(card['etid'])
        .set(EtkinlikEkle);

    var token = "";
    Map<String, String> kullaniciToken = Map<String, String>();

    token = await tokenGetir(card['userId']);
    if (token != null) kullaniciToken[userid] = token;

    //if (token != null) await _bildirimGondermeServis.etkinlik_katilma_istegi_bildirim(istegiatanisim, token);

    await _firebaseDB.collection("users").doc(card['userId']).collection("bildirimler").doc().set({
      'icerik': '$istegiatanisim etkinliğinize katılma isteği gönderdi.',
      'tarih': DateTime.now(),
      'etid': card.id,
      'okundu': false
    });
    return true;
  }

  @override
  Future<bool> etkinlikKatilmaIstegiVazgecButonu(DocumentSnapshot card, String userid) async {
    Map<String, dynamic> EtkinlikIstek = Map();

    EtkinlikIstek['etid'] = card['etid'];
    EtkinlikIstek['userid'] = userid;

    await _firebaseDB.collection("etkinlik").doc(card['etid']).update({'katilimaIstegi': FieldValue.increment(-1)});

    await _firebaseDB
        .collection("etkinlikKatilimİstekleri")
        .doc(card['etid'].toString())
        .collection("katilimcilar")
        .doc(userid)
        .delete();

    await _firebaseDB.collection("usersEtkinlik").doc(userid).collection("katilimci").doc(card['etid']).delete();
    return true;
  }

  @override
  Future<bool> etkinlikKatilmaktanReddetButonu(String etid, String userid) async {
    await _firebaseDB.collection("etkinlik").doc(etid).update({'katilimaIstegi': FieldValue.increment(-1)});

    await _firebaseDB.collection("etkinlikKatilimİstekleri").doc(etid).collection("katilimcilar").doc(userid).delete();

    await _firebaseDB.collection("usersEtkinlik").doc(userid).collection("katilimci").doc(etid).delete();
    return true;
  }

  @override
  Future<bool> adminYetkilendirme(Map<String, dynamic> card, String docid) async {
    await _firebaseDB.collection("yonetici").doc(docid).update(card);
    return true;
  }

  @override
  Future<bool> etkinlikFavla(String userid, String etid) async {
    Map<String, dynamic> EtkinlikEkle = Map();

    EtkinlikEkle['etid'] = etid;
    EtkinlikEkle['userid'] = userid;

    await _firebaseDB.collection("users").doc(userid).collection("favoriEtkinliklerim").doc(etid).set(EtkinlikEkle);

    Map<String, dynamic> EtkinlikEkleFav = Map();

    EtkinlikEkleFav['etid'] = etid;
    EtkinlikEkleFav['onay'] = true;
    await _firebaseDB
        .collection("usersEtkinlikFavori")
        .doc(userid)
        .collection("katilimci")
        .doc(etid)
        .set(EtkinlikEkleFav);
    return true;
  }

  @override
  Future<bool> etkinlikFavdanCik(String userid, String etid) async {
    await _firebaseDB.collection("users").doc(userid).collection("favoriEtkinliklerim").doc(etid).delete();
    await _firebaseDB.collection("usersEtkinlikFavori").doc(userid).collection("katilimci").doc(etid).delete();
    return true;
  }

  @override
  Future<bool> yorumkaydet(String userid, String etid, String yorum, String karsiuser, String yorumdeger) async {
    Map<String, dynamic> YorumEkle = Map();

    YorumEkle['tarih'] = Timestamp.now();
    YorumEkle['userid'] = userid;
    YorumEkle['yorum'] = yorum;
    YorumEkle['yorumdeger'] = yorumdeger;

    await _firebaseDB.collection("users").doc(karsiuser).collection("yorumlar").doc(etid + "-" + userid).set(YorumEkle);
    await _firebaseDB
        .collection("etkinlik")
        .doc(etid)
        .collection("katilimcilar")
        .doc(karsiuser)
        .update({'yorumdurumu': true});
    return true;
  }

  @override
  Future<bool> yorumkaydetTurnuva(
      String userid, String etid, String yorum, String karsiuser, String yorumdeger, String cardid, String a) async {
    Map<String, dynamic> YorumEkle = Map();

    YorumEkle['tarih'] = Timestamp.now();
    YorumEkle['userid'] = userid;
    YorumEkle['yorum'] = yorum;
    YorumEkle['yorumdeger'] = yorumdeger;

    print("etid: " + etid + "  karsiuser: " + karsiuser + " yorum: " + yorum);
    await _firebaseDB.collection("users").doc(karsiuser).collection("yorumlar").doc(etid + "-" + userid).set(YorumEkle);

    await _firebaseDB
        .collection("etkinlik")
        .doc(etid)
        .collection("katilimcilar")
        .doc(cardid)
        .update({'yorumdurumu' + a.toString(): true});
    return true;
  }

  @override
  Future<bool> emojiDegerlendirkaydet(String userid, String deger, String etid, String karsiuser, String cardid) async {
    if (deger == "olumsuz") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumkotu": FieldValue.increment(1)});
    } else if (deger == "notr") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumorta": FieldValue.increment(1)});
    } else if (deger == "olumlu") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumiyi": FieldValue.increment(1)});
    }

    Map<String, dynamic> YorumEkle = Map();
    YorumEkle['tarih'] = Timestamp.now();
    YorumEkle['userid'] = userid;
    YorumEkle['yorum'] = null;
    YorumEkle['yorumdeger'] = deger;
    YorumEkle['katilmaYorumu'] = false;

    Map<String, dynamic> KatilimYorum = Map();

    KatilimYorum['karsiuser'] = karsiuser;
    KatilimYorum['etid'] = etid;
    KatilimYorum['onay'] = true;
    KatilimYorum['yorumdeger'] = deger;

    await _firebaseDB
        .collection("etkinlikKatilimYorum")
        .doc(userid)
        .collection("katilimci")
        .doc(etid + "-" + karsiuser)
        .set(KatilimYorum);
    await _firebaseDB.collection("users").doc(karsiuser).collection("yorumlar").doc(etid + "-" + userid).set(YorumEkle);

    DocumentSnapshot _userid1 =
        await _firebaseDB.collection("etkinlik").doc(etid).collection("katilimcilar").doc(cardid).get();

    if (karsiuser == _userid1['userid1'].toString()) {
      await _firebaseDB
          .collection("etkinlik")
          .doc(etid)
          .collection("katilimcilar")
          .doc(cardid)
          .update({'user1degerleme': deger});
    } else {
      await _firebaseDB
          .collection("etkinlik")
          .doc(etid)
          .collection("katilimcilar")
          .doc(cardid)
          .update({'user2degerleme': deger});
    }

    return true;
  }

  @override
  Future<bool> emojiDegerlendirmeGuncelle(
      String userid, String deger, String etid, String karsiuser, String cardid) async {
    print("emoji değerlendirme güncelledi çalıştı.");
    print("user id:" + userid);
    print("deger:  " + deger);
    print("et id:  " + etid);
    print("karsi user:  " + karsiuser);
    print("card id:  " + cardid);
    if (deger == "olumsuz") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumkotu": FieldValue.increment(1)});
    } else if (deger == "notr") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumorta": FieldValue.increment(1)});
    } else if (deger == "olumlu") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumiyi": FieldValue.increment(1)});
    }
    Map<String, dynamic> YorumEkle = Map();
    YorumEkle['yorumdeger'] = deger;

    Map<String, dynamic> KatilimYorum = Map();

    KatilimYorum['karsiuser'] = karsiuser;
    KatilimYorum['etid'] = etid;
    KatilimYorum['onay'] = true;
    KatilimYorum['yorumdeger'] = deger;
    KatilimYorum['carid'] = cardid;

    await _firebaseDB
        .collection("etkinlik")
        .doc(etid)
        .collection("katilimcilar")
        .doc(karsiuser)
        .update({'yorumdeger': deger});
    await _firebaseDB
        .collection("etkinlikKatilimYorum")
        .doc(userid)
        .collection("katilimci")
        .doc(etid + "-" + karsiuser)
        .set(KatilimYorum);
    await _firebaseDB
        .collection("users")
        .doc(karsiuser)
        .collection("yorumlar")
        .doc(etid + "-" + userid)
        .update(YorumEkle);
  }

  @override
  Future<bool> emojiDegerlendirmeGuncelleTurnuva(
      String userid, String deger, String etid, String karsiuser, String cardid) async {
    print("emoji değerlendirme güncelledi TURNUVA çalıştı.");
    print("user id:" + userid);
    print("deger:  " + deger);
    print("et id:  " + etid);
    print("karsi user:  " + karsiuser);
    print("card id:  " + cardid);
    if (deger == "olumsuz") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumkotu": FieldValue.increment(1)});
    } else if (deger == "notr") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumorta": FieldValue.increment(1)});
    } else if (deger == "olumlu") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumiyi": FieldValue.increment(1)});
    }
    Map<String, dynamic> YorumEkle = Map();
    YorumEkle['yorumdeger'] = deger;

    Map<String, dynamic> KatilimYorum = Map();

    KatilimYorum['karsiuser'] = karsiuser;
    KatilimYorum['etid'] = etid;
    KatilimYorum['onay'] = true;
    KatilimYorum['yorumdeger'] = deger;
    KatilimYorum['carid'] = cardid;

    await _firebaseDB
        .collection("etkinlik")
        .doc(etid)
        .collection("katilimciList")
        .doc(karsiuser)
        .update({'yorumdeger': deger});
    await _firebaseDB
        .collection("etkinlikKatilimYorum")
        .doc(userid)
        .collection("katilimci")
        .doc(etid + "-" + karsiuser)
        .set(KatilimYorum);
    await _firebaseDB
        .collection("users")
        .doc(karsiuser)
        .collection("yorumlar")
        .doc(etid + "-" + userid)
        .update(YorumEkle);
  }

  @override
  Future<bool> emojiDegerlendirkaydetEtkinlik(
      String userid, String deger, String etid, String karsiuser, String cardid, String yorum) async {
    print("oylama emoji değerlendirme kaydet");
    print("karsiuser id:" + karsiuser);
    print("et id:" + etid);
    print("yorum deger:" + deger);
    if (deger == "olumsuz") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumkotu": FieldValue.increment(1)});
    } else if (deger == "notr") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumorta": FieldValue.increment(1)});
    } else if (deger == "olumlu") {
      await _firebaseDB.collection("users").doc(karsiuser).update({"yorumiyi": FieldValue.increment(1)});
    }
    Map<String, dynamic> YorumEkle = Map();
    YorumEkle['tarih'] = Timestamp.now();
    YorumEkle['userid'] = userid;
    YorumEkle['yorum'] = yorum;
    YorumEkle['yorumdeger'] = deger;
    YorumEkle['katilmaYorumu'] = false;

    Map<String, dynamic> KatilimYorum = Map();

    KatilimYorum['karsiuser'] = karsiuser;
    KatilimYorum['etid'] = etid;
    KatilimYorum['onay'] = true;
    KatilimYorum['yorumdeger'] = deger;
    KatilimYorum['carid'] = cardid;
    await _firebaseDB.collection("users").doc(karsiuser).collection("yorumlar").doc(etid + "-" + userid).set(YorumEkle);
    await _firebaseDB
        .collection("etkinlik")
        .doc(etid)
        .collection("katilimcilar")
        .doc(karsiuser)
        .update({'yorumdeger': deger});
    await _firebaseDB
        .collection("etkinlikKatilimYorum")
        .doc(userid)
        .collection("katilimci")
        .doc(etid + "-" + karsiuser)
        .set(KatilimYorum);

    return true;
  }

  @override
  Future<bool> eslestirKimseyok(String userid, String etid, String userfoto, String userad, int cardindex) async {
    DocumentReference documentReference = _firebaseDB.collection("etkinlik").doc(etid).collection("katilimcilar").doc();
    DocumentReference documentReferencelist =
        _firebaseDB.collection("etkinlik").doc(etid).collection("katilimciList").doc(userid);
    Map<String, dynamic> Turnuva = Map();

    Turnuva['tarih'] = Timestamp.now();
    Turnuva['user1ad'] = userad;
    Turnuva['user1foto'] = userfoto;
    Turnuva['userid1'] = userid;
    Turnuva['carid'] = documentReference.id;
    Turnuva['user2ad'] = null;
    Turnuva['user2foto'] = null;
    Turnuva['userid2'] = null;
    Turnuva['user1degerleme'] = null;
    Turnuva['user2degerleme'] = null;
    Turnuva['yorumdurumu1'] = false;
    Turnuva['yorumdurumu2'] = false;
    Turnuva['index'] = cardindex == 0 ? cardindex + 1 : (cardindex * 2) + 1;

    await documentReference.set(Turnuva);
    await documentReferencelist.set({'userid': userid, 'index': (cardindex * 2) + 1, 'katilmaYorumu': false});

    await _firebaseDB.collection("etkinlik").doc(etid).update({'katilimciSayisi': FieldValue.increment(1)});

    return true;
  }

  @override
  Future<bool> eslestirIkinciKisi(
      String userid, String etid, String userfoto, String userad, String cardid, int cardindex) async {
    Map<String, dynamic> Turnuva = Map();

    Turnuva['user2ad'] = userad;
    Turnuva['user2foto'] = userfoto;
    Turnuva['userid2'] = userid;

    await _firebaseDB.collection("etkinlik").doc(etid).collection("katilimcilar").doc(cardid).update(Turnuva);

    DocumentReference documentReferencelist =
        _firebaseDB.collection("etkinlik").doc(etid).collection("katilimciList").doc(userid);
    await documentReferencelist
        .set({'userid': userid, 'index': cardindex == 0 ? 2 : (cardindex + 1) * 2, 'katilmaYorumu': false});
    await _firebaseDB.collection("etkinlik").doc(etid).update({'katilimciSayisi': FieldValue.increment(1)});
    return true;
  }

  @override
  Future<void> usersKafaEkle(List<String> kafalar, String userid) async {
    await _firebaseDB.collection("users").doc(userid).update({"kafalar": kafalar});
  }

  @override
  Future<void> usersProfil_Kafaya_Oy_Ver(
      String userid, List<String> kafa_icon_list, String oylayanid, String kafaadi, int sayi) async {
    print("kafa oy userid :" + userid);
    print("kafa oy sayi :" + sayi.toString());
    print("kafa oy kafaadi :" + kafaadi.toString());

    if (kafaadi == "Lider") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("lider"), {'sayi': sayi + 1});
      });
    } else if (kafaadi == "Çılgın") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("cilgin"), {'sayi': sayi + 1});
      });
    } else if (kafaadi == "Adaletli") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("adaletli"),
            {'sayi': sayi + 1});
      });
    } else if (kafaadi == "Saygılı") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("saygili"),
            {'sayi': sayi + 1});
      });
    } else if (kafaadi == "Güvenilir") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("guvenilir"),
            {'sayi': sayi + 1});
      });
    } else if (kafaadi == "Romantik") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("romantik"),
            {'sayi': sayi + 1});
      });
    } else if (kafaadi == "Cömert") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("comert"), {'sayi': sayi + 1});
      });
    } else if (kafaadi == "EK") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("ek"), {'sayi': sayi + 1});
      });
    }

    await _firebaseDB
        .collection("users")
        .doc(oylayanid)
        .collection("profil_oy_attiklarim")
        .doc(userid)
        .set({"kafalar": kafa_icon_list, "userid": userid});
  }

  @override
  Future<void> usersProfil_Kafaya_Oydan_Cikar(
      String userid, List<String> kafa_icon_list, String oylayanid, String kafaadi, int sayi) async {
    if (kafaadi == "Lider") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("lider"), {'sayi': sayi - 1});
      });
    } else if (kafaadi == "Çılgın") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("cilgin"), {'sayi': sayi - 1});
      });
    } else if (kafaadi == "Adaletli") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("adaletli"),
            {'sayi': sayi - 1});
      });
    } else if (kafaadi == "Saygılı") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("saygili"),
            {'sayi': sayi - 1});
      });
    } else if (kafaadi == "Güvenilir") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("guvenilir"),
            {'sayi': sayi - 1});
      });
    } else if (kafaadi == "Romantik") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(_firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("romantik"),
            {'sayi': sayi - 1});
      });
    } else if (kafaadi == "Cömert") {
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("comert"), {'sayi': sayi - 1});
      });
    } else if (kafaadi == "EK") {
      await _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("ek").set({"sayi": sayi - 1});
      _firebaseDB.runTransaction((Transaction transaction) async {
        await transaction.set(
            _firebaseDB.collection("users").doc(userid).collection("profil_iconlar").doc("ek"), {'sayi': sayi - 1});
      });
    }

    await _firebaseDB
        .collection("users")
        .doc(oylayanid)
        .collection("profil_oy_attiklarim")
        .doc(userid)
        .set({"kafalar": kafa_icon_list, "userid": userid});
  }

  @override
  Future<void> usersKafaCikar(String kafaadi, String userid) async {
    await _firebaseDB.collection("users").doc(userid).collection("kafalar").doc(kafaadi).delete();
  }

  @override
  Future<List<DocumentSnapshot>> usersKafalariGetir(String userid) async {
    QuerySnapshot kafalarVerisi = await _firebaseDB.collection("users").doc(userid).collection("kafalar").get();
    return kafalarVerisi.docs;
  }

  @override
  Future<bool> updateProfilFoto(String userid, String dowlandurl) async {
    await _firebaseDB.collection("users").doc(userid).update({'avatarImageUrl': dowlandurl});
    return true;
  }

  @override
  Future<void> updategizlilik(String userid, bool deger) async {
    await _firebaseDB.collection("users").doc(userid).update({'profilGizlilik': deger});
  }

  @override
  Future<bool> hesapbanla(String userid) async {
    await _firebaseDB
        .collection("users")
        .doc(userid)
        .update({'userbanvarmi': true, 'banAcilmaTarihi': Timestamp.now().toDate().add(Duration(days: 90))});
    return true;
  }

  @override
  Future<bool> hesapSil(String userid) async {
    await _firebaseDB.collection("users").doc(userid).delete();
    await _firebaseDB.collection('users').doc(userid).collection("albumlerim").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await _firebaseDB.collection('users').doc(userid).collection("favoriEtkinliklerim").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await _firebaseDB.collection('users').doc(userid).collection("kafalar").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await _firebaseDB.collection('users').doc(userid).collection("takipEttiklerim").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await _firebaseDB.collection('users').doc(userid).collection("takipcilerim").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await _firebaseDB.collection('users').doc(userid).collection("yorumlar").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    Reference photoRef =
        await FirebaseStorage.instance.ref().storage.refFromURL("gs://etkinlikkafasi-1de35.appspot.com/users/$userid");
    photoRef.delete();
    return true;
  }

  @override
  Stream<List<Konusma>> getAllConversations(String userID) {
    var querySnapshot = _firebaseDB
        .collection("users")
        .doc(userID)
        .collection("sohbetler")
        .orderBy("olusturulma_tarihi", descending: true)
        .snapshots();

    return querySnapshot
        .map((mesajListesi) => mesajListesi.docs.map((mesaj) => Konusma.fromMap(mesaj.data())).toList());
  }

  @override
  Stream<List<Mesaj>> getMessages(String currentUserID, String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("users")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID)
        .collection("mesajlar")
        .where("konusmaSahibi", isEqualTo: currentUserID)
        .orderBy("date", descending: true)
        .limit(1)
        .snapshots();
    return snapShot.map((mesajListesi) => mesajListesi.docs.map((mesaj) => Mesaj.fromMap(mesaj.data())).toList());
  }

  @override
  Stream<List<DocumentSnapshot>> getMessagesDoc(String currentUserID, String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("users")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID)
        .collection("mesajlar")
        .where("konusmaSahibi", isEqualTo: currentUserID)
        .orderBy("date", descending: true)
        .limit(1)
        .snapshots();

    return snapShot.map((mesajListesi) => mesajListesi.docs.toList());
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, String userid) async {
    var _mesajID = _firebaseDB.collection("users").doc(userid).collection("sohbetler").doc().id;
    var _myDocumentID = kaydedilecekMesaj.kime;
    var _receiverDocumentID = kaydedilecekMesaj.kimden;

    var _kaydedilecekMesajMapYapisi = kaydedilecekMesaj.toMap();
    await _firebaseDB
        .collection("users")
        .doc(userid)
        .collection("sohbetler")
        .doc(_myDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);

    await _firebaseDB.collection("users").doc(userid).collection("sohbetler").doc(_myDocumentID).set({
      "konusma_sahibi": kaydedilecekMesaj.kimden,
      "kimle_konusuyor": kaydedilecekMesaj.kime,
      "son_yollanan_mesaj": kaydedilecekMesaj.mesaj,
      "konusma_goruldu": false,
      "olusturulma_tarihi": FieldValue.serverTimestamp(),
    });

    _kaydedilecekMesajMapYapisi.update("bendenMi", (deger) => false);
    _kaydedilecekMesajMapYapisi.update("konusmaSahibi", (deger) => kaydedilecekMesaj.kime);

    await _firebaseDB
        .collection("users")
        .doc(kaydedilecekMesaj.kime)
        .collection("sohbetler")
        .doc(_receiverDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);

    await _firebaseDB
        .collection("users")
        .doc(kaydedilecekMesaj.kime)
        .collection("sohbetler")
        .doc(_receiverDocumentID)
        .set({
      "konusma_sahibi": kaydedilecekMesaj.kime,
      "kimle_konusuyor": kaydedilecekMesaj.kimden,
      "son_yollanan_mesaj": kaydedilecekMesaj.mesaj,
      "konusma_goruldu": false,
      "olusturulma_tarihi": FieldValue.serverTimestamp(),
    });

    return true;
  }

  @override
  Future<DateTime> saatiGoster(String userID) async {
    await _firebaseDB.collection("server").doc(userID).set({
      "saat": FieldValue.serverTimestamp(),
    });

    var okunanMap = await _firebaseDB.collection("server").doc(userID).get();
    Timestamp okunanTarih = okunanMap["saat"];
    return okunanTarih.toDate();
  }

  @override
  bool mesajguncelle(String currentUserID, String sohbetEdilenUserID, String docid) {
    var snapShot = _firebaseDB
        .collection("users")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID)
        .collection("mesajlar")
        .doc(docid)
        .update({'goruldumu': true});

    _firebaseDB
        .collection("users")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID)
        .update({'son_gorulme': true});

    return true;
  }

  @override
  Future<List<Users>> getUserwithPagination(Users enSonGetirilenUser, int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<Users> _tumKullanicilar = [];

    if (enSonGetirilenUser == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.docs) {
      print("userid: " + snap['kimle_konusuyor'].toString());
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection("users").doc(snap['kimle_konusuyor']).get();
      Users _tekUser = Users.fromMap(snapshot.data());
      _tumKullanicilar.add(_tekUser);
    }

    return _tumKullanicilar;
  }

  Future<List<Mesaj>> getMessagewithPagination(
      String currentUserID, String sohbetEdilenUserID, Mesaj enSonGetirilenMesaj, int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<Mesaj> _tumMesajlar = [];

    if (enSonGetirilenMesaj == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("sohbetler")
          .doc(sohbetEdilenUserID)
          .collection("mesajlar")
          .where("konusmaSahibi", isEqualTo: currentUserID)
          .orderBy("date", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("sohbetler")
          .doc(sohbetEdilenUserID)
          .collection("mesajlar")
          .where("konusmaSahibi", isEqualTo: currentUserID)
          .orderBy("date", descending: true)
          .startAfter([enSonGetirilenMesaj.date])
          .limit(getirilecekElemanSayisi)
          .get();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.docs) {
      Mesaj _tekMesaj = Mesaj.fromMap(snap.data());
      _tumMesajlar.add(_tekMesaj);
    }
    print("gelen toplam mesaj:" + _querySnapshot.docs.length.toString());

    return _tumMesajlar;
  }

  Future<String> tokenGetir(String kime) async {
    print("kime:" + kime);
    DocumentSnapshot _token = await _firebaseDB.doc("tokens/" + kime).get();

    if (_token != null)
      return _token['token'];
    else
      return null;
  }
}
