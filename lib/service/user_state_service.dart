import 'package:etkinlik_kafasi/Firebase/authBase.dart';
import 'package:etkinlik_kafasi/Firebase/user_repo.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:flutter/material.dart';


enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  Users _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  Users get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<Users> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }
  void blockUser(BlockedUser buser){
    _user.blockedUsers.add(buser);
    notifyListeners();
  }

  void removeBlockUser(String userId){
    _user.blockedUsers.removeWhere((element) => element.userId == userId);
    notifyListeners();
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }


  @override
  Future<Users> createtel(String email, String sifre,Users users,String tel,String uid) async {
      try {
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmailandPassword(email, sifre,users,tel,uid);
        return _user;
      } finally {
        state = ViewState.Idle;
      }

  }



  @override
  Future<Users> signInWithEmailandPassword(String email, String sifre) async {
    try {
        _user = await _userRepository.signInWithEmailandPassword(email, sifre);
        return _user;
    } finally {
      state = ViewState.Idle;
    }
  }







}
