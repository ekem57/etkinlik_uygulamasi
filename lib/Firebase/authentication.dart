import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationNewUser {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;



  Future createNewUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Future<Users> readUser(String userID, String email) async {
    DocumentSnapshot _okunanUser =
    await _firebaseDB.collection("users").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    if(_okunanUser.data!=null){
      Users _okunanUserNesnesi = Users.fromMap(_okunanUserBilgileriMap);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null;
    }



  }

}
