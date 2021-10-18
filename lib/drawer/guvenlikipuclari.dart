import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class GuvenlikIpuclari extends StatelessWidget {
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
        title: Text("Güvenlik İpuçları",
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
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""Yeni insanlarla tanışmak heyecan verici, ama tanımadığınız biriyle iletişim kurarken her zaman dikkatli olmalısınız. En iyi takdirinizi kullanın ve, ilk etkinlik veya turnuva için güvenliğinize öncelik verin. Başkalarının eylemlerini kontrol edemeseniz de, Etkinlik Kafası deneyiminiz sırasında güvende olmanıza yardımcı olmak için yapabileceğiniz şeyler vardır.
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
            Padding(padding: const EdgeInsets.only(left: 15), child: Text("Çevrimiçi Güvenlik",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Platformda Kalın",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                    """Bir Etkinlik, Turnuva ya da Özel Etkinliğe Katıldığınız zaman etkinlik sahibi, turnuva sahibi ya da diğer katılımcıları tanımaya çalışırken konuşmaları ETKİNLİK KAFASIN platformunda tutun. Kötü niyetli kullanıcılar genellikle sohbeti hemen SMS'e, mesajlaşma uygulamalarına, e-postaya veya telefona taşımaya çalışır.
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

            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Asla Para Göndermeyin veya Finansal Bilgileri Paylaşmayın",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Acılan Etkinlik, Turnuva Ya da Özel Etkinlikler için Kişi acil durumda olduğunu iddia etse bile, özellikle banka havalesi yoluyla asla para göndermeyin. Banka havalesi yapmak nakit göndermek gibidir — işlemi geriye almak veya paranın nereye gittiğini takip etmek neredeyse imkansızdır. Finansal hesaplarınıza erişmek için kullanılabilecek bilgileri asla paylaşmayın. Başka bir kullanıcı sizden para isterse, derhal bize bildirin. """,
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Kişisel Bilgilerinizi Koruyun",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
TC. Kimlik numaranız, ev veya iş adresiniz veya günlük rutininizle ilgili ayrıntılar (örneğin, her Pazartesi belirli bir spor salonuna gittiğiniz gibi) kişisel bilgilerinizi tanımadığınız insanlarla asla paylaşmayın.
 Ebeveyn iseniz, çocuklarınızla ilgili paylaştığınız bilgileri profilinizde sınırlayın. Çocuğunuzun isimleri, okula gittikleri yerler, yaşları veya cinsiyetleri gibi ayrıntıları paylaşmaktan kaçının.
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


            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("• Tüm Şüpheli ve Rahatsız Edici Davranışları Bildirin",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),



            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
                
Birisi ya da birilerinin çizgiyi aştığını farkına varırsınız bunu yapan kişi ya da kişileri bilmek istiyoruz. Şartlarımızı ihlal eden herkesi engelleyin ve şikâyet bölümünü kullanarak bizlere bildirin ayrıda katılmış olduğunuz etkinlik, Turnuva ya da Özel Etkinlikler sonrasın da size sunulacak olan bu kişi hakkında İYİ, KARARSIZIM veya KÖTÜ bölümünde oylama yapınız. Düşünceleriniz ide kullanıcının profiline girerek yorum bölümünden yaza bilirsiniz """,
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
             child: Text("ÖNEMLİ: Verilen İYİ, KARARSIZIM veya KÖTÜ puanlamalar tamamen gizli tutulmaktadır.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
           ),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5), child: Text(" İşte bazı ihlal örnekleri:",style: TextStyle(fontSize: 15),),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5), child: Text("• Para veya bağış talepleri",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("• Reşit olmayan kullanıcılar",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5), child: Text("• Taciz, tehdit ve hakaret içeren mesajlar",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("• Şahsen buluşma sırasında veya sonrasında uygunsuz veya zararlı davranış",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5), child: Text("• Sahte profiller",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("• Ticari web sitelerine bağlantılar veya ürün veya hizmet satma girişimleri dahil olmak üzere spam veya talep",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""Şüpheli davranışlarla ilgili endişelerinizi herhangi bir profil sayfasından veya buradaki mesaj penceresinden ihbar edebilirsiniz. Daha fazla bilgi için Topluluk Kurallarımıza göz atın.
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

            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("• Hesabınızı Koruyun",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Güçlü bir şifre seçtiğinizden emin olun ve genel ya da ortak bir Telefondan hesabınıza giriş yaparken daima dikkatli olun. ETKİNLİK KAFASI size asla kullanıcı adınızı ve şifrenizle ilgili bilgileri soran bir e-posta göndermez — hesap bilgilerini isteyen bir e-posta alırsanız derhal bildirin.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

          SizedBox(height: 20,),
            Padding(padding: const EdgeInsets.only(left: 15), child: Text("Yüz Yüze Buluşma",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Onaylı Profilleri Tercih Ediniz",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Etkinlik Kafası platformunda bulunan kullanıcılar profillerine isteğe bağlı olarak onaylatıp Mavi Tık etiketini alırlar bu etikete sahip olan profillerin etkinlik ve turnuvalarına katılmaya özen gösterin   


Not 1: MAVİ TIK talep etmek için iletişim bölümü mesaj penceresinde Mavi Tık Talebi başlığı altından anlık Talep edebilirsiniz. 

Not 2: MAVİ TIK alan kullanıcıların profili tamamen doğrudur anlamına gelmez.
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

            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Halkla Açık Yerlerde Buluşun ve Orada Kalın",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
İlk katılacağınınız Etkinlik, Turnuva Ya da Özel Etkinlikler ilk seferde kalabalık, halka açık yerlerde olmasına dikkat edin.
—  Etkinlik, Turnuva Ya da Özel Etkinlik açan kişinin etkinliği evinde veya başka bir özel yerde ise dikkatli olun İnsanların davranışlarını kontrol edemezsiniz. 
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

            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Arkadaşlarınıza ve Ailenize Planlarınızdan Bahsedin",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Ne zaman ve nereye gideceğiniz de dahil olmak üzere, bir arkadaşınıza veya aile üyenize planlarınızı söyleyin. Cep telefonunuzu her zaman yanınızda ve şarjı edilmiş olarak bulundurun.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Ulaşımınızın Kontrolü Sizde Olsun",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""İstediğiniz zaman ayrılabilmeniz için buluşmanıza nasıl gidip döneceğinizi kontrol etmenizi istiyoruz. Kendinizi araç kullanıyorsanız, sürüş paylaşım uygulaması veya sizi almak için bir arkadaş gibi bir yedek planınızın olması iyi bir fikirdir.
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

            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Sınırlarınızı Bilin",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Alkolün sizin üzerinizdeki etkilerinin farkında olun. İrade ve dengeniz bozula bilir. Etkinlik, Turnuva Ya da Özel Etkinlikler de kişi ya da kişiler uyuşturucu kullanmanız veya daha fazla içmeniz için size baskı yapmaya çalışırsa, oradan uzaklaşın ve rahatsız olduğunuz insan ya da insanları kolluk küvetlerine bildirin konuyla ilgili olarak bize yapılan şikâyette kullanıcı ya da kullanıcılar platformdan uzaklaştırılır.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	İçecekleri veya Kişisel Eşyaları Başı Boş Bırakmayın",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Katılmış ya da düzenlemiş olduğunuz Etkinlik, Turnuva Ya da Özel Etkinliklerde İçeceğinizin nereden geldiğini ve her zaman nerede olduğunu bilin — yalnızca doğrudan barmen veya garson tarafından servis edilen içecekleri kabul edin. Cinsel saldırıyı kolaylaştırmak için içeceklerin içine atılan birçok madde kokusuz, renksiz ve tatsızdır. Ayrıca telefonunuzu, çantanızı, cüzdanınızı ve kişisel bilgilerinizi içeren her şeyi her zaman yanınızda bulundurun.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),


            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Kendinizi Rahatsız Hissederseniz, Oradan Ayrılın",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Rahatsız oluyorsanız, Etkinlikten erken ayrıla bilirsiniz. İçgüdüleriniz size bir şeylerin ters gittiğini veya güvensiz hissettiğinizi söylüyorsa, bulunduğunuz ortamdaki çalışanlar ya da yetkililerden yardım isteyin.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("•	Etkinlik, Turnuva Ya da Özel Etkinlikler sonrası ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""Katılmış olduğunuz Etkinlik, Turnuva Ya da Özel Etkinlikler sonrası Yaşamış olduğunuz deneyimi platform üzerinden kullanıcıları değerlendirmeyi unutmayın.

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

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Değerlendirme içinin: Etkinliklerim – Geçmiş Etkinlikler- Katılımcıları Oyla sekmesinden yapabilirsiniz.
""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Yapmış olduğunuz değerlendirmeler ve yorumlar platformumuz için çok önemlidir.
Çünkü: Amacımız daha kaliteli, güvenilir, kültür seviyesi yüksek, saygılı ve seviyeli bir platform kullanıcı topluluğu oluşturmak.

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





            SizedBox(height: 8,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("Yardım, Destek veya Tavsiye Kaynakları",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),),
            SizedBox(height: 10,),

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Unutmayın bu ipuçlarını izleseniz bile, hiçbir riski azaltmak mümkün değildir. Olumsuz bir deneyiminiz varsa, lütfen bunun sizin suçunuz olmadığını ve yardım alabileceğinizi unutmayın. Etkinlik Kafasındaki herhangi bir olayı bildirin ve aşağıdaki kaynaklardan birine ulaşmayı düşünün. 
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

            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 16.0.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("""
Acil bir tehlike altında olduğunuzu düşünüyorsanız veya acil yardıma ihtiyacınız varsa, 155'i veya yerel yasa uygulayıcıları arayın.""",
                    style:  TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0.spByWidth),
                    textAlign: TextAlign.justify),
              ),
            ),



        SizedBox(height: 80,),

          ],
        ),
      ),
    );
  }
}
