import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class CustomCheckBox extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color butonColor;
  final bool value;

  const CustomCheckBox({
    Key key,
    @required this.text,
    this.butonColor: const Color(0xfff7cb15),
    @required this.onPressed,
    @required this.fontSize,
    this.value,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 30.0.w),
        child: Row(
          children: [
            Container(
                decoration: value
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xff91c4f2), width: 3),
                      )
                    : BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                        border: Border.all(
                            color: const Color(0xff91c4f2), width: 3),
                      ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                )),
            SizedBox(
              width: 20.0.w,
            ),
            Text(text,
                style:  TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0.spByWidth),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
