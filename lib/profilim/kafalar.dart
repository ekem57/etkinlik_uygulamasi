import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class KafalarTab extends StatefulWidget {
  final Function onTap;

  const KafalarTab({Key key, this.onTap}) : super(key: key);

  @override
  _KafalarTabState createState() => _KafalarTabState();
}

class _KafalarTabState extends State<KafalarTab> {

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
     return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      padding: EdgeInsets.fromLTRB(23.0.w, 23.0.h, 23.0.w, 100.0.h),
      mainAxisSpacing: 8.0.h,
      crossAxisSpacing: 18.0.w,
      children: List.generate(33, (index) {
        var seletectedColor = _userModel.user.kafalar.contains(kafalar[index]["title"].replaceAll("\n", " "))
            ? Theme.of(context).accentColor
            : Colors.white;

        return GestureDetector(
          onTap: () {
            var kafaTitle = kafalar[index]["title"].replaceAll("\n", " ");
            if (_userModel.user.kafalar.contains(kafaTitle)) {
              _userModel.user.kafalar.remove(kafaTitle);
            } else {
              _userModel.user.kafalar.add(kafaTitle);
            }
            widget.onTap();
          },
          child: Container(
            width: 75.66666666666667.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
              boxShadow: [
                BoxShadow(color: const Color(0x29000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
              ],
              color: seletectedColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.saturation),
                  child: Image.asset(
                    kafalar[index]["image"],
                    width: 37.0.w,
                    height: 37.0.w,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Text(
                    kafalar[index]["title"],
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 9.7.spByWidth),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
