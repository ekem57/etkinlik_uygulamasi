import 'package:etkinlik_kafasi/Firebase/authBase.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Users> currentUser() async {
    try {
      User user = await _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  Users _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return Users(userId: user.uid, email: user.email);
    }
  }

  @override
  Future<bool> signOut() async {
    try {

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out hata:" + e.toString());
      return false;
    }
  }



  @override
  Future<Users> createUserWithEmailandPassword(String email, String sifre,Users users) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebase(sonuc.user);
  }

  @override
  Future<Users> signInWithEmailandPassword(String email, String sifre) async {
   UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
   print("giris yapıldı");
    return _userFromFirebase(sonuc.user);
  }




}
