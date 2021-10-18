import 'package:etkinlik_kafasi/widgets/oylama_emojleri.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
class KatilimciOylama extends StatefulWidget {
  @override
  _KatilimciOylamaState createState() => _KatilimciOylamaState();
}

class _KatilimciOylamaState extends State<KatilimciOylama> {
  final TextEditingController _araController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _primaryColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Katılımcılar",
            style: TextStyle(
                color: const Color(0xff343633),
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 21.7.spByWidth),
            textAlign: TextAlign.center),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 293.3333333333333.w,
              height: 41.666666666666664.h,
              margin: EdgeInsets.symmetric(vertical: 20.0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.8.h)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x2b000000), offset: Offset(0, 2), blurRadius: 14.30.w, spreadRadius: 0)
                ],
                color: Theme.of(context).backgroundColor,),
              child: TextFormField(
                controller: _araController,
                keyboardType: TextInputType.text,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.disabled,
                textInputAction: TextInputAction.done,
                style: TextStyle(fontSize: 15.0.spByWidth),
                decoration: InputDecoration(
                  labelText: "Katılımcı Ara",
                  border: InputBorder.none,
                  icon: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 18.0.h,
                    ),
                  ),
                  labelStyle: TextStyle(
                      color: const Color(0xbf343633),
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.italic,
                      fontSize: 15.3.spByWidth),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,

                itemBuilder: (context, index) =>
                    Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/avatar.png",
                      ),
                      radius: 25.70.w,
                    ),
                    title: Text(
                      "Ayşe Demir",
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0.spByWidth),
                    ),
                    subtitle: GestureDetector(
                      onTap: (){
                        print("yorum yap");
                      },
                      child: Text(
                          "Yorum yap",
                          style:  TextStyle(
                              color:  const Color(0xffcc59d2),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle:  FontStyle.normal,
                              fontSize: 14.0.spByWidth
                          ),
                          textAlign: TextAlign.left
                      ),
                    ),
                    trailing:  Container(
                      width: 125.0.w,
                      child:OylamaEmojileri(),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
