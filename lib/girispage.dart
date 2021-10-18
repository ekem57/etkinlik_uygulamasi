import 'package:etkinlik_kafasi/main_navigation.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';


class GirisPage extends StatefulWidget {
  final Users user;

  GirisPage({Key key, @required this.user,}) : super(key: key);


  @override
  _GirisPageState createState() => _GirisPageState();
}

class _GirisPageState extends State<GirisPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.user!=null) {
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => MainNavigation(user: widget.user,)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        height: 200.0.h,
        width: 200.0.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/logo.jpeg'),
            fit: BoxFit.fill,
          ),
         color: Colors.white
        ),
      )),
    );
  }
}
