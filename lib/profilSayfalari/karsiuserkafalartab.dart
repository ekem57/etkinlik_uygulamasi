import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

class KarsiUserKafalarTab extends StatefulWidget {
  final Function onTap;
  final Map<String, dynamic> card;
  List<String> kafalarim;
   KarsiUserKafalarTab({Key key, this.onTap,this.card,this.kafalarim}) : super(key: key);

  @override
  _KarsiUserKafalarTabState createState() => _KarsiUserKafalarTabState();
}

class _KarsiUserKafalarTabState extends State<KarsiUserKafalarTab> {
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("kafa deger:"+widget.kafalarim.toString());
 //   kafalarim=List<String>.from(widget.card["kafalar"]);
  }


  @override
  Widget build(BuildContext context) {

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      padding: EdgeInsets.fromLTRB(23.0.w, 23.0.h, 23.0.w, 100.0.h),
      mainAxisSpacing: 8.0.h,
      crossAxisSpacing: 18.0.w,
      children: List.generate(33, (index) {
        var seletectedColor=Colors.white;
       if(widget.kafalarim!=null){
          seletectedColor = widget.kafalarim.contains(kafalar[index]["title"].replaceAll("\n", " "))
             ? Theme.of(context).accentColor
             : Colors.white;
       }else{
         widget.kafalarim=[];
       }

        return GestureDetector(
          onTap: () {


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
                    height: 37.0.h,
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
