import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/radial_painter.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:provider/provider.dart';

import 'uyeninProfiSayfasi.dart';

class UyelerOzelslemler extends StatefulWidget {


  @override
  _UyelerOzelslemlerState createState() => _UyelerOzelslemlerState();
}


class _UyelerOzelslemlerState extends State<UyelerOzelslemler>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }


  int toplamEtkinlikSayim = 0;
  double _olumluSlider = 60;

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserModel>(context, listen: false);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          leading:  Padding(
            padding:  EdgeInsets.only(left: 25.0.w),
            child: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,size: 20.0.w,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding:  EdgeInsets.only(right: 25.0.w),
              child: IconButton(
                icon: Icon(Icons.settings,color: Colors.white,),
                onPressed: (){

                },
              ),
            ),
          ],

        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(21.70.h),
                  bottomLeft: Radius.circular(21.70.h),
                ),
              ),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    bottom: -60.0.h,
                    left: 23.0.w,
                    right: 23.0.w,
                    child: Container(
                        width: 312.3333333333333.w,
                        height: 139.33333333333334.h,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(11.70.h)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x36000000),
                                offset: Offset(0, 2),
                                blurRadius: 22.70,
                                spreadRadius: 0)
                          ],
                          color: Theme.of(context).backgroundColor,
//                        color: Colors.red,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 34.0.h,
                                    backgroundColor: Color(0xfff7cb15),
                                    child: CircleAvatar(
                                      radius: 32.0.h,
                                      backgroundImage:
                                      AssetImage('assets/avatar.png'),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/gold_uye.png'),
                                            ),
                                          )),
                                      // Expanded(child: IconButton(icon: Icon(Icons.search),iconSize: 13,)),
                                    ],
                                  ),
                                  Text("Gold Üye",
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0.spByWidth),
                                      textAlign: TextAlign.center)
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 8.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(userNotifier.user.adsoyad,
                                              style: TextStyle(
                                                color:
                                                const Color(0xff343633),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13.3.spByWidth,
                                              ),
                                              textAlign: TextAlign.left),
                                          Spacer(),
                                          GestureDetector(
                                              onTap: () {},
                                              child: Icon(Icons.delete)),
                                        ],
                                      ),
                                      Container(
//                                          width: 187.33333333333334.w,
//                                          height: 44.0.h,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 8.0.h),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0.w)),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                const Color(0x36000000),
                                                offset: Offset(0, 0),
                                                blurRadius: 4.3,
                                                spreadRadius: 0)
                                          ],
                                          color: Theme.of(context)
                                              .backgroundColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Etkinlik",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff343633),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontFamily:
                                                        "OpenSans",
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize:
                                                        11.3.spByWidth),
                                                    textAlign:
                                                    TextAlign.center),
                                                Text(
                                                    toplamEtkinlikSayim == 0
                                                        ? "0"
                                                        : toplamEtkinlikSayim
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff343633),
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontFamily:
                                                        "OpenSans",
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize:
                                                        15.0.spByWidth),
                                                    textAlign:
                                                    TextAlign.center)
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Takipçi",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff343633),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontFamily:
                                                        "OpenSans",
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize:
                                                        11.3.spByWidth),
                                                    textAlign:
                                                    TextAlign.center),
                                                Text("415",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff343633),
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontFamily:
                                                        "OpenSans",
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize:
                                                        15.0.spByWidth),
                                                    textAlign:
                                                    TextAlign.center)
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Takip",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff343633),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontFamily:
                                                        "OpenSans",
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize:
                                                        11.3.spByWidth),
                                                    textAlign:
                                                    TextAlign.center),
                                                Text("396",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xff343633),
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontFamily:
                                                        "OpenSans",
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize:
                                                        15.0.spByWidth),
                                                    textAlign:
                                                    TextAlign.center)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 88.70.w,
                                            height: 25.70.h,
                                            child: RaisedButton(
                                              color: Theme.of(context)
                                                  .accentColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    65.7.w),
                                              ),
                                              onPressed: () {
                                                print("mesaj gönder");
                                              },
                                              elevation: 8.3,
                                              child: Text(
                                                "Mesajları",
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff343633),
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontFamily: "OpenSans",
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize:
                                                    13.30.spByWidth),
                                              ),
                                            ),
                                          ),
//                                          Spacer(),
//                                        SizedBox(width: 12.0.w,),
                                          Container(
                                            width: 88.70.w,
                                            height: 25.70.h,
                                            child: RaisedButton(
                                              color: Theme.of(context)
                                                  .buttonColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    65.7.w),
                                              ),
                                              onPressed: () {},
                                              elevation: 8.3,
                                              child: FittedBox(
                                                child: Text(
                                                  "Banla",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff343633),
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontFamily: "OpenSans",
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      fontSize:
                                                      13.30.spByWidth),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 50.0.h,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.h),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: const Color(0xff343633),
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0.spByWidth),
                labelColor: Theme.of(context).primaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Theme.of(context).buttonColor,
                tabs: [
                  Tab(child: Text("Kafalar",style: TextStyle(fontSize: 13),)),
                  Tab(child: Text("Etkinlikler",style: TextStyle(fontSize: 13),)),
                  Tab(child: Text("Yorumlar",style: TextStyle(fontSize: 13),)),
                  Tab(child: Text("Albüm",style: TextStyle(fontSize: 13),)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                  Text("data"),
                  Text("data"),
                  Container(
                    height: 300,
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        padding: EdgeInsets.only(top: 8.0.h, bottom: 56.0.h),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? _buildYorumlarGrafikleri()
                              : _buildYorumlar();
                        }),
                  ),
                  Text("data"),

                ],
              ),
            ),




          ],
        ),
      );
  }

  Widget _buildYorumlarGrafikleri() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        children: [
          Container(
            width: 50.0.w,
            height: 50.0.w,
            child: CustomPaint(
              foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: Color(0xff00af54),
                  percent: 0.6,
                  width: 5.0),
              child: Center(
                child: Text(
                  '%90',
                  style: TextStyle(
                    fontSize: 16.70.spByWidth,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.0.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 14.0.h,
                  child: Row(
                    children: [
                      Container(
                        width: 30.0.w,
                        child: Text("İyi",
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 11.7.spByWidth),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: SliderTheme(
                            data: SliderThemeData(
                              disabledActiveTrackColor: Color(0xff00af54),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 0.0),
                              trackHeight: 7.0.h,
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              value: _olumluSlider,
                              onChanged: null,
                              activeColor: Color(0xff00af54),
                              max: 100,
                              min: 0,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 14.0.h,
                  child: Row(
                    children: [
                      Container(
                        width: 30.0.w,
                        child: Text("Orta",
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 11.7.spByWidth),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: SliderTheme(
                            data: SliderThemeData(
                              disabledActiveTrackColor: Color(0xfff7cb15),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 0.0),
                              trackShape: CustomTrackShape(),
                              trackHeight: 7.0.h,
                            ),
                            child: Slider(
                              value: _olumluSlider,
                              onChanged: null,
                              activeColor: Color(0xff00af54),
                              max: 100,
                              min: 0,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 14.0.h,
                  child: Row(
                    children: [
                      Container(
                        width: 30.0.w,
                        child: Text("Kötü",
                            style: TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 11.7.spByWidth),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: SliderTheme(
                            data: SliderThemeData(
                              disabledActiveTrackColor: Color(0xfff21b3f),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 0.0),
                              trackShape: CustomTrackShape(),
                              trackHeight: 7.0.h,
                            ),
                            child: Slider(
                              value: _olumluSlider,
                              onChanged: null,
                              activeColor: Color(0xff00af54),
                              max: 100,
                              min: 0,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text("5 Yorum",
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 10.0.spByWidth),
                      textAlign: TextAlign.right),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildYorumlar() {
    return Container(
//      height: 126.30.h,
//      color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0.w),
            title: Text("Selin Çiçek",
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 13.3.spByWidth),
                textAlign: TextAlign.left),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/avatar.png"),
              radius: 20.0.h,
            ),
            subtitle: Image.asset(
              "assets/olumlu_active.png",
              width: 25.0.w,
              height: 25.0.w,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
            trailing: Text("1 gün önce",
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 10.0.spByWidth),
                textAlign: TextAlign.right),
          ),
          Text(
            """Lorem ipsum dolor sit amet, consectetur elit, sed do eiusmod tempor incididunt ut labore et dolor magna aliqua""",
            style: const TextStyle(
                color: const Color(0xff343633),
                fontWeight: FontWeight.w400,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 13.3),
//    textAlign: TextAlign.left
          )
        ],
      ),
    );
  }
}
