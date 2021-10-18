import 'package:etkinlik_kafasi/drawer/guvenlikipuclari.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class SikcaSorulanSorular extends StatelessWidget {
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
        title: Text("Sıkça Sorulan Sorular",
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_curve.png"),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            Text("EKTİNLİK KAFASI NEDİR?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""Ektinlik kafası 2021 yılında hayata geçirilen bir etkinlik ve sosyal ağ projesidir.
Amacımız insanların etkinliklerde bir araya gelerek kaliteli zaman geçirerek sosyalleşmelerini sağlamaktır.
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

            SizedBox(height: 10,),

            Text("ETKİNLİK KAFASININ AMACI NEDİR?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""Arayıpta bulmadığın senin gibi kaliteli insanları bir araya getirerek sosyal ve kültürel anlamda kaliteli topluluklar oluşturmak.
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


            SizedBox(height: 10,),

            Text("Kimler Etkinlik Oluştura bilir ve kimler oluşturulan etkinliklere katıla bilir?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Tüm kullanıcılar Etkinlik oluştura bilir ve tüm kullanıcılar aranan şartlara göre oluşturulan Etkinliklere Katıl isteği göndere bilir.                              Not: Oluşturulmuş Etkinliğe Gönderilen katılım istekleri sizin o etkinliğe katıldığınız anlamına gelmez. Etkinlik sahibinin özgür iradesi ile istediği kişi ya da kişileri kabul etmek ya da kabul etmemek hakkına sahiptir.
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

            SizedBox(height: 10,),

            Text("Kimler Turnuva Oluştura bilir ve kimler oluşturulan Turnuvaya eşleşme isteği göndere bilir?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Tüm kullanıcılar Turnuva oluşturabilir, Oluşturulan Turnuvalara tüm kullanıcılar Eşleşme talebi göndere bilir.
Not: Eşleşmeler sıra ile ya da Turnuva oluşturucusunuz özgür iradesi ile değişirle bilir. Turnuva sahibinin istediği kişi ya da kişileri turnuvadan çıkarma hakkı vardır hiçbir sebep belirtmeksizin.

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


            SizedBox(height: 10,),

            Text("Özel Etkinlik Nedir, Kimler Özel Etkinlik Oluştura bilir ve kimler oluşturulan Özel Etkinliğe katıl Talebi göndere bilir?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Özel Etkinlik sadece etkinlik sahibin istediği kişilere davet olarak gönderilen bu etkinliği her kullanıcı göre bilir fakat katılım isteği göndermez. Tüm kullanıcılar Özel Etkinlik Oluştura bilir, Özel Etkinliklere sadece Etkinlik sahibinin davet ettiği kullanıcılar ya da etkinlik sahibini takip eden kullanıcılar katıl isteği göndere bilir.
Not: Geliştirici Acılan Etkinlik, Turnuva Ya da Özel Etkinlikleri istediği zaman bireysel ya da kurumsal kullanıcıların statüsüne göre yeniden düzenleye bilir. Hali hazırda bulunan Standart, Plus ve Gold üyelik sitemini dilediği zaman aktif hale getire bilir ve hiçbir kullanıcı bu kısıtlamalardan dolayı hiçbir hak talep edemez  

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

            SizedBox(height: 10,),

            Text("Onaylı Profil olmak için ne yapmalıyım ?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
MAVİ TIK talep etmek için iletişim bölümü- Mesaj penceresinde Başlıklar sekmesinden- Mavi Tık Talebi- Anlık selfinizi göndererek başvuruda buluna bilirsiniz. 
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

            SizedBox(height: 10,),

            Text("Temsilci kimdir? Ne işe yarar.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Etkinlik Kafası uygulama ve platforma katkıda bulunan ya da buluna bilecek, uygulamayı temsil eden ya da temsil edebilecek potansiyeli sahip kişilerden seçilmiş üyelerdir. Temsilci temsil ettiği il, ilçe ya da üniversite de Etkinlik Kafası temsilcisi olarak gönüllü etkinlik ve turnuva düzenleye bilir temsilcilerin etkinlikleri ya da turnuvaları diğer etkinlik ya da turnuvalara daha prestijli ve katılımcı sayısı yüksektir.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),


            SizedBox(height: 10,),

            Text("Birden fazla profil açabilir miyim ?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Her kullanıcı bir profil açma hakkına sahiptir.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("ETKİNLİK KAFASININDA GÜVENLİĞİM İÇİN NELER YAPMALIYIM?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 292.3333333333333.w,
                height: 43.666666666666664.h,
                margin: EdgeInsets.only(top: 38.0.h),
                child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(65.7.w),
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => GuvenlikIpuclari()));
                  },
                  elevation: 8.3,
                  child: Text(
                    "İpuçları İçin Tıklayınız...",
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.7),
                  ),
                ),
              ),
            ),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}
