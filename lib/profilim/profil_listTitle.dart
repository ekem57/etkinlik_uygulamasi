import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class ProfilListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final String trailingTitle;

  const ProfilListTile({Key key, this.title, this.icon, this.trailingTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Padding(
          padding:  EdgeInsets.only(right: 10.0.w),
          child: Text(title,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.3.spByWidth),
              textAlign: TextAlign.left),
        ),

        Flexible(
          child: Align(
            alignment: Alignment.topRight,
            child: Text(trailingTitle,
                maxLines: 3,
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 13.3.spByWidth),
                textAlign: TextAlign.left),
          ),
        ),
      ],
    );
  }
}
