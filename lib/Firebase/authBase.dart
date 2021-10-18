

import 'package:etkinlik_kafasi/models/users.dart';

abstract class AuthBase {
  Future<Users> currentUser();
  Future<bool> signOut();
  Future<Users> signInWithEmailandPassword(String email, String sifre);
}


