import 'package:etkinlik_kafasi/girispage.dart';
import 'package:etkinlik_kafasi/login/login_view.dart';
import 'package:etkinlik_kafasi/main.dart';
import 'package:etkinlik_kafasi/main_navigation.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return LoginView();
      } else {
        return MainNavigation(user: _userModel.user,);
      }
    }
    return Scaffold();
  }


}
