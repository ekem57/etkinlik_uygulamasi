import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class ProfilListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final String trailingTitle;
  final TextAlign alignment;

  const ProfilListTile({Key key, this.title, this.icon, this.trailingTitle, this.alignment: TextAlign.right}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Padding(
          padding:  EdgeInsets.only(left: 12.0.w),
          child: Text(title,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.3.spByWidth),
              textAlign: TextAlign.left),
        ),
//        Spacer(),
        Expanded(
          child: Text(trailingTitle,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.3.spByWidth),
              textAlign: alignment),
        ),
      ],
    );
  }
}
