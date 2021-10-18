import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
class ArrowRight extends StatelessWidget {
  final Function onPressed;

  const ArrowRight({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 121.33333333333333.w,
      height: 43.666666666666664.h,
//      margin: EdgeInsets.only(bottom: 80.0.h),
//    alignment: Alignment.bottomCenter,
      child: RaisedButton(
        color: Theme.of(context).buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(65.7.w),
        ),
        onPressed: onPressed,
        elevation: 8.3,
        child: Image.asset(
          "assets/arrow_right.png",
          width: 40.3.w,
          height: 21.0.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
