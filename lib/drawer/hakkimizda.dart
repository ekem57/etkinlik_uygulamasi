import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class Hakkimizda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Hakkımızda",
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
//        margin: EdgeInsets.only(top: 32.70),
//        padding: EdgeInsets.symmetric(horizontal: 32.0.w),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/bg_curve.png"),
//             fit: BoxFit.contain,
//             alignment: Alignment.bottomCenter,
//           ),
//         ),
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 16.0.h,left: 15,right: 15),
          child: Text("""Bugüne kadar birçok sosyal ağ uygulamasın da yaşamış olduğunuz deneyimleri sizlere unutturacak ve Tam da Kafanıza göre bir uygulamayı sizlerin hizmetine sunuyoruz.
          
2021 Yılında %100 yerli sermaye ve hiçbir destek almadan kurulan Etkinlik kafası kendi bünyesinde TÜRK Yazılım Mühendislerince geliştirilmiş bir uygulamadır.

 2021 yılında hayata geçirdiğimizuygulamamızın Sıradan bir kalabalığa hitap etmemektedir. Temelini Saygılı, Seviyeli ve Kültürlü insanların oluşturduğu bir Sosyal Medya Platformudur. 

ETKİNLİK KAFASI aslında arayıp da bulamadığınız "tam benim kafadan" YA DA “Kafa nereye biz oraya” diyen insanların bir araya gelmesi ile sosyal ve kültürel anlamda kaliteli zaman geçirmelerini amaçlamaktadır.
""",
              style:  TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0.spByWidth),
              textAlign: TextAlign.justify),
        ),
      ),
    );
  }
}
