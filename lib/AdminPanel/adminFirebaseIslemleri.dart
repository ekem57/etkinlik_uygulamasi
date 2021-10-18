import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_auth_service.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/users.dart';


class AdminFirebaseIslemleri  {

  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();



  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }



  @override
  Future<void> adminEtkinlikOnayla(DocumentSnapshot card) async {

    await _firestoreDBService.adminEtkinlikOnayla(card);

  }
  @override
  Future<void> adminEtkinlikDavetlerileriGetir(DocumentSnapshot card) async {

    await _firestoreDBService.adminEtkinlikDavetlileriGetir(card);

  }

  @override
  Future<void> adminEtkinlikReddet(DocumentSnapshot card,String mesaj) async {

    await _firestoreDBService.adminEtkinlikReddet(card,mesaj);

  }
  @override
  Future<void> adminsikayetSil(DocumentSnapshot card) async {

    await _firestoreDBService.adminSikayetSil(card);

  }

  @override
  Future<void> adminoneriSil(DocumentSnapshot card) async {

    await _firestoreDBService.adminOneriSil(card);

  }

  @override
  Future<void> adminReklamlarSil(DocumentSnapshot card) async {

    await _firestoreDBService.adminReklamlarSil(card);

  }

  @override
  Future<void> adminMaviTikSil(DocumentSnapshot card) async {

    await _firestoreDBService.adminMaviTikSil(card);

  }

  @override
  Future<void> adminDigerSil(DocumentSnapshot card) async {

    await _firestoreDBService.adminDigerSil(card);

  }

  @override
  Future<void> adminTemsilciGorevdenAl(DocumentSnapshot card) async {

    await _firestoreDBService.adminTemsilciGorevdenAl(card);

  }

  @override
  Future<void> adminYoneticiGorevdenAl(DocumentSnapshot card) async {

    await _firestoreDBService.adminYoneticiGorevdenAl(card);

  }
  @override
  Future<bool> adminYoneticiAta(DocumentSnapshot card) async {

    bool veri= await _firestoreDBService.adminYoneticiAta(card);
    return veri;
  }

  @override
  Future<bool> adminTemsilciAta(DocumentSnapshot card,String temsilciadres) async {

    bool veri= await _firestoreDBService.adminTemsilciAta(card,temsilciadres);
    return veri;
  }

  @override
  Future<bool> adminReklamOlustur(Map<String,dynamic> card) async {

   bool veri= await _firestoreDBService.adminReklamOlustur(card);
    return veri;
  }

  @override
  Future<bool> adminReklamDuzenle(Map<String,dynamic> card,String docid) async {

    bool veri= await _firestoreDBService.adminReklamDuzenle(card,docid);
    return veri;
  }

  @override
  Future<void> adminReklamSil(DocumentSnapshot card) async {

    await _firestoreDBService.adminReklamSil(card);
  }

  @override
  Future<bool> adminEtkinlikOlustur(Map<String,dynamic> card) async {

    bool veri= await _firestoreDBService.adminEtkinlikOlustur(card);
    return veri;
  }

  @override
  Future<bool> adminYetkilendirme(Map<String,dynamic> card,String docid) async {

    bool veri= await _firestoreDBService.adminYetkilendirme(card,docid);
    return veri;
  }


}
