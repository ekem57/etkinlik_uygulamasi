import 'package:etkinlik_kafasi/AdminPanel/admin_main_navigation.dart';
import 'package:etkinlik_kafasi/landingPage.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdminLandingPage extends StatefulWidget {

  @override
  _AdminLandingPageState createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {

  @override
  Widget build(BuildContext context) {


    final _userModel = Provider.of<UserModel>(context, listen: true);
    print("admin landing page gelen: "+_userModel.user.toString());
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {

        return LandingPage();
      } else {
        return AdminMainNavigation(user:_userModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }


}
