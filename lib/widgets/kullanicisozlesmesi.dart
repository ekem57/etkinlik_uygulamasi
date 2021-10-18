import 'package:etkinlik_kafasi/drawer/guvenlikipuclari.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class KullaniciSozlesmesi extends StatelessWidget {
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
        title: Text("Sözleşmeler",
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
        child: ListView(
          children: [
            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("""KULLANICI SÖZLEŞMESİ

UYGULAMAYA ÜYE OLAN KULANICI YA DA İŞLETME, KULLANICI SÖZLEŞMESİ'Nİ OKUDUĞUNU, İÇERİĞİNİ ANLADIĞINI, HÜKÜMLERİNİ KABUL ETTİĞİNİ VE ONAYLADIĞINI GAYRIKABİLİ RUCU KABUL, BEYAN ETMİŞ OLURSUNUZ. BU SÖZLEŞMEDE YER ALAN HÜKÜMLER VE MADDELER MEVZUATA GÖRE VEYA ETKİNLİK KAFASI YÖNETİMİ TEK TARAFLI İRADESİ İLE İSTENİLDİĞİ ZAMAN DEĞİŞTİRİLEBİLİR.
Madde 1. Taraflar
İşbu Üyelik ve Kullanım Sözleşmesi (kısaca “Sözleşme”) Etkinlik Kafası Android ve iOS platformlarında yer alan Etkinlik Kafası adlı aplikasyonun ve buna bağlı tüm uygulamaların (kısaca “Etkinlik Kafası”), Etkinlik Kafası (kısaca “Geliştirici”) ile isim ve iletişim bilgilerini işbu sözleşmenin kabulü öncesinde sisteme tanımlamış olan Bireysel ya da Kurumsal üye (“Kullanıcı” olarak da anılabilecektir.) arasındadır. Kullanıcı, Etkinlik Kafası Platformuna üye olarak, işbu ‘Sözleşme’nin tamamını okuduğunu, anladığını ve tüm hükümlerini onayladığını kabul, beyan ve taahhüt eder.
Madde 2. Sözleşmenin Konusu
İşbu Sözleşme’nin konusu Geliştirici tarafından geliştirilmiş, kullanıma sunulmuş olan “ETKİNLİK KAFASI” (“Uygulama” olarak da anılabilecektir.) kullanım koşulları ile tarafların karşılıklı hak ve yükümlülüklerinin belirlenmesidir.
Madde 3. Tanımlar 
Etkinlik Kafası uygulaması: 	Etkinlik Kafası ismiyle Android ve iOS platformlarda yer alan aplikasyondur.
Site: 				www.etkinlikkafasi.com alan adıyla veya bu alan adına bağlı alt alan adlarından oluşan web siteleri ve uygulamalardır. 
Etkinlik düzenleyici: 		Uygulama aracılığıyla Bireysel ya da Kurumsal genel olarak eğlence, spor, sanat ya da kültürel etkinliği üye olarak oluşturan kullanıcı gerçek ya da tüzel kişilerdir. 
Etkinlik; 			Uygulama ’da açılan sanat, müzik, eğlence, bilimsel ya da kültürel ücretli ya da ücretsiz tüm sosyal aktivitelerdir. 
Turnuva: 			Uygulama ’da açılan Turnuva kapsamında spor, sanat, müzik, eğlence, bilimsel ya da kültürel ücretli ya da ücretsiz tüm sosyal turnuva aktivitelerdir. 
Özel Etkinlik: 			Uygulama ’da açılan sadece davet sistemiyle çalışan ve bu doğrultuda gerçekleştirilen ücretli ya da ücretsiz tüm sosyal ve kültürel aktivitelerdir. 
Bireysel Kullanıcı: 		Uygulamaya üye olan bireysel kullanıcı ve / veya Uygulamada sunulan Hizmetlerden işbu sözleşmede belirtilen dahilinde yararlanan etkinlik düzenleyiciler de dahil olmak üzere gerçek veya tüzel kişidir. Kısaca üye olarak da isimlendirilir. 
Kurumsal Kullanıcı: 		Uygulamaya üye olan işletme, kurum, kuruluş ve / veya Uygulamada sunulan Hizmetlerden, işbu sözleşmede belirtilen dahilinde yararlanan etkinlik düzenleyiciler de dahil olmak üzere gerçek veya tüzel kişidir. 

Etkinlik Katılımcısı: 		Uygulama üzerinden herhangi bir etkinlikte rezervasyon yaptırarak ve / veya herhangi bir etkinlikten rezervasyon hizmeti satın alarak etkinliğe katılım hakkı elde etmiş ve / veya bu işlemi gerçekleştirmiş haklarını devrettikleri gerçek veya tüzel kişilerdir. Katılımcılar aynı zamanda Uygulama kullanıcısı olabilirler.
Platform: 			Etkinlik düzenleyicinin organizasyon düzenleme, bu etkinlik duyurmasına, etkinlikler için rezervasyon hizmeti sunmasına, etkinlik bedelini tahsil edebilmek, sayfalarını inceleyebilmesine, seçmiş etkinliklere katılmak için rezervasyon adeti seçebilmesine ve ödeme yapabilmesine, etkinliklere giriş yapabilmeleri için elektronik posta veya kısa mesaj gönderilebildiği tarafından kullanılan yazılım ön yüzüdür.

 Kullanıcı Sözleşmesinin Konusu ve Kapsamı:
Kullanıcı Sözleşmesi konusu, Uygulama ‘da sunulan Hizmetler’ den ve bu Hizmetler ’den yararlanma şartlarının ve tarafların hak ve düzenlemelerinin tespitidir. Kullanıcı, Uygulama’ da yer verilen her türlü beyana veya açıklamaya uygun olarak davranacağını kabul, beyan ve taahhüt eder. 
 
Madde 4. Etkinlik Kafası Uygulaması ve Tanımlar
4.1. Bireysel ya da Kurumsal katılımcıların mobil uygulamalar üzerinden; tanışarak ya da bir araya gelerek ücretli/ücretsiz ve herkese açık (Genel) / kapalı (Özel) Etkinlik, Turnuva ya da Özel Etkinlik oluşturmasına veya bu alanlardaki etkinliklere birlikte katılmasına olanak sağlayan, kişilerin buluşmalarını kolaylaştıran bir sosyal ağdır.
Etkinlik Kafası Yönetimi Etkinlik, Turnuva ya da Özel Etkinlik oluşturan Bireysel ya da Kurumsal Kişiler ve oluşturulan Etkinlik, Turnuva ya da Özel Etkinliğe katılan Üyeler den Etkinlik, Turnuva ya da Özel Etkinlik için herhangi bir ücret talep etmez.  
4.2.   Kullanıcı, Bireysel ya da Kurumsal kendisine ilişkin talep edilen bilgilerin, güvenlik ve uygulamanın geliştirilmesi amacıyla Gizlilik Politikamızın en güncel halinde açıklandığı şekilde işlenmesine ve saklanmasına rıza göstermektedir.
 
Madde 5. Puanlama, Yorum ve Kafa Gönderme Sistemi
 	5.1. Etkinlik Kafası, Etkinlik, Turnuva ya da Özel Etkinlik oluşturan ve katılan kişilere yönelik bir puanlama ve yorum özelliği ihtiva etmektedir. Bu özellik sayesinde Kullanıcılar, birbirlerini değerlendire bilir ve yorum yapabilir. Kullanıcılar tarafından yapılan değerlendirmeler ve yorumlar herkesin profilinde görüntülenebilmektedir. Bunun yanı sıra Etkinlik Kafası insanların iyi yönlerini ortaya çıkarmak amacıyla aynı Etkinlik, Turnuva ya da Özel Etkinliğe katılan kullanıcılar arasında birbirlerine olumlu sayılabilecek bizim tabirimizle kafa gönderebilmektedir.
 	5.2. Etkinlik Kafası, kişilerin puanlanması ile ilgili olarak, düzenledikleri etkinliklere katılım, iptal, memnuniyet vs ve bunlarla sınırlı olmayan parametreleri arka planda çeşitli algoritmalar ile değerlendirerek uygulamanın ve dolaylı olarak etkinlikle ilgili içeriklerin kalitesini arttırıcı önlemler alabilir.
 
5.3. Kullanıcılar, herhangi bir içerik oluştururken ahlak ve adaba aykırı ifadeler kullanmamaya, hakaret ve küfür içeren yorumlarda bulunmamaya, kamu düzenini bozucu, insanları tahrik edici/kışkırtıcı/ayrıştırıcı vs. ifadeler kullanmamaya özen göstermek zorundadır. Kullanıcı’ nın, Etkinlik Kafası uygulaması üzerinden yapmış olduğu her bir yorum Türk Ceza Kanunu ve diğer ilgili mevzuat hükümlerinde bir suç, kabahat teşkil ediyor ise bununla ilgili tüm hukuki ve cezai sorumluluk münhasıran Kullanıcı’ ya aittir. Geliştirici, Etkinlik Kafası üzerinden yapılan yorumlar nedeniyle yapılacak şikâyet, başvuru vs. adli, idari süreçlerde hiçbir şekilde taraf sıfatı teşkil etmemekte ve bu sebeple hiçbir sorumluluğu bulunmamaktadır.
5.4 Etkinlik Kafası üzerinden yapılmış olan puanlama ve yorumlar kişilerin sosyal, maddi, güvenilirlik gibi herhangi bir alandaki durumlarını garanti etmez. Geliştirici Puan ve yorumların gerçekliğini garanti etmez ve bu nedenle doğacak zararlardan sorumluluk kabul etmez.  

6. Hak ve Yükümlülükler 

6.1. Bireysel ya da Kurumsal Kullanıcı’ nın Hak ve Yükümlülükleri 

Bireysel ya da Kurumsal Kullanıcı, Üyelik prosedürlerini yerine getirirken, uygulama’ nın Hizmetlerinden faydalanırken ve uygulama’ nın hizmetleri ile ilgili herhangi bir işlemi yerine getirirken, Kullanıcı Sözleşmesi'nde yer alan tüm şartlara, Uygulama ilgili yer belirtilen kurallara, Gizlilik Sözleşmesi ve yürürlükte tüm mevzuata uygun hareket edeceği, tüm şartları ve kuralları anladığını ve onayladığını kabul, beyan ve taahhüt eder. 

Bireysel ya da Kurumsal Kullanıcı, yürürlükteki emredici mevzuat hükümleri gereğince veya mahkeme emri veya idari kolluk birimlerinin yazılı talebiyle, Etkinlik Kafası gizli / özel / ticari bilgileri gerek resmi makamlara gerek idari makamlara açıklamaya yetkili ve bu sebeple Etkinlik Kafası her ne nam altında olursa olsun tazminat talep edilemeyeceğini kabul, beyan ve taahhüt eder. 

Bireysel ya da Kurumsal Kullanıcı, Etkinlik Kafası tarafından sunulan Hizmetlerden yararlanabilmek için sisteme erişim araçlarının (Kullanıcı ismi, şifre vb) güvenliği, saklanması, üçüncü kişilerin bilgisinden uzak tutulması ve korunması durumlarıyla ilgili hususlar sadece Kullanıcıların grubunda verilmiştir. Kullanıcıların, sisteme giriş araçlarının güvenliği, saklanması, üçüncü kişilerin bilgisinden uzak tutulması, Bu gibi hususlardaki tüm ihmal ve kusurlarından Kullanıcıların ve / veya üçüncü kişilerin uğradığı veya uğrayabileceği durumlardan Etkinlik Kafası doğrudan veya dolaylı, olarak herhangi bir sorumluluğu yoktur. 

Bireysel ya da Kurumsal Kullanıcı, Uygulama dâhilinde kendileri tarafından sağlanan bilgi ve içeriklerin doğru ve hukuka uygun olduğunu beyan, kabul ve taahhüt ederler.

Etkinlik Kafası, Kullanıcıları tarafından Etkinlik Kafası uygulaması veya Site üzerinden kendileri tarafından yüklenen, değiştirilen veya sağlanan bilgi ve içeriklerin araştırmasını araştırma, bu bilgi ve içeriklerin güvenli, doğru ve hukuka uygun olduğunu 3. Kişilere, Uygulama üyelerine veya etkinlik düzenleyen bireysel ya da kurumsal kullanıcılara taahhüt ve garanti etmekle yükümlü ve sorumlu değildir, söz konusu bilgi ve içeriklerin yanlış veya yanlışlardan ortaya çıkacak hiçbir zarardan Etkinlik Kafası geliştiricisi sahibi yöneticileri sorumlu tutulamaz. 

Bireysel ya da Kurumsal Kullanıcı, Etkinlik Kafası yazılı onayı olmadan, Kullanıcı Sözleşmesi kapsamındaki hak ve sınıflarını, birkaçını veya tamamını, üçüncü kişi ya da kişilere devredemezler. 

Etkinlik Kafası Uygulaması üzerinden, Etkinlik Kafası kendi kontrolünde olmayan üçüncü kişi satıcılar, sağlayıcılar ve başkaca üçüncü kişilere sahip olduğu ve işlettiği başka web sitelerine ve / veya portallara, dosyalara veya içeriklere 'link verebilir. Bu 'linkler, Bireysel ya da Kurumsal Kullanıcılar tarafından veya sadece referans nedeniyle Etkinlik Kafası tarafından sağlanmış olabilir ve link ile erişilen web sitesi veya siteyi işleten kişiyi desteklemek amacı veya web sitesi veya içerdiği içeriğe yönelik herhangi bir içerik bir beyan veya garanti niteliği taşımaktadır. Site üzerinde 'link'ler aracılığıyla erişilen portallar, web siteleri, dosyalar ve içerikler, bu' link'ler erişilen portallar veya web sunulan hizmetler veya ürünler veya içerik hakkında Etkinlik Kafasının herhangi bir sorumluluğu yoktur. 

Etkinlik Kafası hizmet'ler den yararlananlar ve Uygulamayı kullananlar, sadece yasalara uygun Uygulama üzerinde işlem yapabilirler. Bireysel ya da Kurumsal Kullanıcılar, Uygulama dahilinde işlem ve eylemdeki hukuki ve cezai sorumluluk alanına aittir. Her Kullanıcı, Etkinlik Kafası ve / veya başka bir üçüncü şahsın ayni veya şahsi haklarına veya malvarlığına tecavüz teşkil edecek, Uygulama dahilinde görsel ve işitsel imgeleri, resim, müzik dahil, video kliplerini, dosyaları, veri tabanlarını, çoğaltmayacağını, kopyalamayacağını, dağıtmayacağını, işlemeyeceğini gerek bu eylemleri ile gerekse de başka yollarla Etkinlik Kafası ile doğrudan ve / veya dolaylı olarak rekabete girmeyeceğini kabul, beyan ve taahhüt eder. Kullanıcı' ların Kullanıcı Sözleşmesi hükümlerine ve / veya hukuka aykırı olarak Site üzerinde gerçekleştirdikleri faaliyetler nedeniyle cezai ve hukuksal olarak tüm sorumluluğu paylaş. Üçüncü bu sebeple uğradıkları veya uğrayabilecekleri zararlardan doğrudan ve / veya dolaylı olarak, hiçbir şekilde Etkinlik Kafası sorumlu tutulamaz.

 	Bireysel ya da Kurumsal Kullanıcı da dâhil olmak üzere üçüncü kişiler Uygulama’ da sunulan hizmetlerden ve içeriklerden itibaren Etkinlik Kafası, yöneticilerinin veya çalışanlarının sorumluluğu yoktur. Herhangi bir üçüncü kişi tarafından ya da etkinlik düzenleyicisi tarafından çevrildi ve ders, içeriklerin, görsel ve işitsel imgelerin doğruluğu ve hukuka uygunluğunun taahhüdü, bütünüyle bu eylemleri gerçekleştiren diğerlerinde. Etkinlik Kafası Bireysel ya da Kurumsal Kullanıcıları da dahil olmak üzere üçüncü kişiler tarafından sağlanan hizmetlerin ve içeriklerin güvenliğini, hizmetlerin ve hukuka uygun olma taahhüt ve garanti etmemektedir.

 	Uygulama’ nın hizmetlerinden yararlanmak için başka kategoride yasal ya da yasadışı yollarla elde edilen Uygulama içerisinde gerçekleştirdikleri her türlü işlem ve eylemlerin cezai ve hukuksal sorumluluğu bunu yapan gerçek veya tüzel kişilere aittir. Bu şekilde işlem yapanlar yüzünden Etkinlik Kafası Gelişicisi, Sahibi, Yöneticileri Kesinlikle Sorumlu Tutulamaz 3. kişilere, diğer ilgili cezai ve hukuksal sorumluluğu bulunmamaktadır. 

Kullanıcıların Uygulama üzerinden bilet alma işlemi gerçekleştikten sonra herhangi bir sebeple sistem üzerinden iptal etme ya da elindeki bileti bir başka 3. Kişi ye serbest bedelli ya da Bila bedel devretme hak ve yetkisi bulunmamaktadır. Bu sebeple Etkinlik Kafası ya da 3. Kişilere karşı para iadesi ya da başka bir etkinlik ile değiştirme yapma zorunluluğu veya taahhüdü bu sebeple Etkinlik Kafası hiçbir şekilde 3. Kişilere ya da maddi ya da manevi sorumluluğu olmayacaktır. 

Etkinlik, Turnuva ya da Özel Etkinliğin iptali, ertelenmesi ya da etkinliğin herhangi bir sebeple katılımcıların beklentisini gerçekleşmemesi nedeniyle Etkinlik Kafası’ nın bu hususta ya da 3. Kişilere karşı herhangi bir cezai ya da maddi sorumluluğu bulunmamaktadır. 

Etkinlik, Turnuva ya da Özel Etkinlik alanında yerinde katılımcılara da 3. Kişilere herhangi bir sebeple gelebilecek maddi veya manevi zarardan Etkinlik Kafası Geliştiricisi, Yöneticileri ve Sahibi hiçbir şekilde ve konumda sorumlu değildir. 

Etkinlik, Turnuva ya da Özel Etkinliğin gerçekleşme biçimine, Etkinlik, Turnuva ya da Özel Etkinlik’ de oluşma sebebine, 3. Kişilere ya da etkinlik düzenleyicisinin hiçbir cezai ya da hukuksal sorumluluğu bulunmamaktadır. 

Etkinlik Kafası Uygulamasının hatasız gönderime ya da Uygulamanın veya yerine geçilmesi ya da Uygulamaya bağlantı yapılmasıyla belirli sonuçların elde edileceğini garanti ve taahhüt etmez. Bununla birlikte, Etkinlik Kafası, web sitesinde ve Uygulamada sunulan hizmetleri sunmak için belirli bir amaca uygunluk, düzensizlik, güncelleme, sağlama, doğrulama, hatasızlık dâhil, açık ya da zımni hiçbir garanti ve / veya ya da taahhüt vermez. 

Uygulama ve içerik “mevcut haliyle" aktarılabilir. Etkinlik Kafası, Uygulama üzerinden yüklenen dosyalarda virüs, kirletici veya bozucu özellikleri garanti etmemektedir. Etkinlik Kafası, Uygulaması ticari değerine garantiler veya taahhütler de dâhil olmak üzere her türlü başka aleni veya zımni garantiyi de üstlenmemektedir. 

Etkinlik Kafası Uygulaması kullanılmasından kaynaklanabilecek zararlar için Etkinlik Kafası Geliştiricisi, Yöneticileri ve Sahibi hiçbir şekil ve surette sorumlu tutulamaz. Etkinlik Kafası Uygulamasında sunulan Hizmet' ler ve özellikler istenildiği zaman değiştirebilme; Uygulama, Kullanıcı' ların sisteme yükledikleri bilgileri ve paylaştığı bilgileri, Kullanıcı' lar da dâhil olmak üzere, üçüncü kişilere tedarik edebilme ve hakkına haizdir. Etkinlik Kafası bu hakkını, hiçbir bildirimde bulunmadan ve onay almadan kullanabilir. 

Etkinlik Kafası tarafından Uygulamanın Kullanıcı sözleşmesinin ihlali halinde, Etkinlik Kafası ilgili bağlantı son verebilir, gelecekte Uygulamayı kullanmalarına engel olabilir, bilet / davetiye / katılım hakkı siparişini iptal edebilir, Satın alınmış olan bir üyelik paketi varsa hiçbir hak talep etmeden iptal edebilir ve / veya ilgili kişiler aleyhine her türlü yasal yollara müracaat edebilir. 

Kullanıcılar Uygulama üzerinde yer alan kendi üyelikleri veya tanıdıklarına ait üyelikler arasında para transferini yapmayacaklarını ve Uygulamanın işleyişini manipüle etme ya da teşebbüsünde bulunamazlar bulunmaları halinde Etkinlik Kafasının uğrayacağı Her türlü maddi ve manevi zararı tazmin edeceklerini kabul, beyan ve taahhüt eder.

 	Etkinlik Kafası hizmetlerinden etkin bir şekilde yararlanması için Uygulama da hizmetlerini istediği şekilde duyurma ve Uygulama’ da istediği şekilde uyarlama ve / veya düzenleme hak ve yetkisine sahiptir. 

Etkinlik Kafası tarafından yapılan bu paylaşım ve / veya uyarlamalarla ilgili olarak Kullanıcıların uymakla yükümlü olduğu kural ve form, Etkinlik Kafası tarafından, ilgili Hizmetin kullanımıyla ilgili açıklamaların Etkinlik, Turnuva ya da Özel Etkinlik ile Kullanıcılara duyurulur. 

6.2. Etkinlik, Turnuva ya da Özel Etkinliği Düzenleyicisinin Hak ve Yükümlülükleri “Etkinlik, Turnuva ya da Özel Etkinliği düzenleyicisi aynı zamanda Uygulama kullanıcısı olabilir ancak Etkinlik, Turnuva ya da Özel Etkinliği düzenleyen olarak aşağıda belirtilen ve koşullara uyacağını gayrikabili rücu kabul, beyan ve taahhüt eder”
Etkinlik, Turnuva ya da Özel Etkinliği düzenleyicisi Uygulamanın hizmetlerini ve platformunu kullanan kişi adına ya da başka bir tüzel ya da gerçek kişi adına kendi belirleyecekleri davetliler ve / veya tüm Uygulamaya katılım katılımı için ücretli ya da ücretsiz etkinlik düzenleyen gerçek ya da tüzel kişidir. 
Etkinlik, Turnuva ya da Özel Etkinliği oluşturan bireysel ya da kurumsal kullanıcı işbu sözleşmede yer alan kullanım koşullarını tamimiyle gayrikabili rücu kabul talep ve taahhüt eder.


Etkinlik, Turnuva ya da Özel Etkinliği oluşturan Bireysel ya da Kurumsal Kullanıcı hiçbir şekilde Uygulama üzerinden yasal olmayan Etkinlik, Turnuva ya da Özel Etkinlik düzenlemeyeceğini ve taahhüt edeceği yasal mevzuata ve taahhüt ettiği ve duyurduğu tüm koşullara uygun bir şekilde gerçekleştirileceğini, aksi takdirde 3. Kişilere ve Uygulama kullanıcılarına veya Etkinlik Kafası’ na karşı tüm cezai ve hukuksal gezinin gayrikabili, beyan ve taahhüt eder. 

Etkinlik, Turnuva ya da Özel Etkinlik için katılım giriş ve / veya satış işlemleri Etkinlik, Turnuva ya da Özel Etkinliği düzenleyen tarafından belirtilen kapasitenin dolmasına kadar ya da etkinliğin başlangıç saatine kadar devam eder. Bilgi verilmiş olan kapasitenin dolması ve / veya yüksekliğin başlaması ile Uygulama üzerinde bu etkinliğin sağlanmış satış ve rezervasyon hizmetleri sona erer. 
Etkinlik, Turnuva ya da Özel Etkinliğin sahip olma ve 3. Kişilere karşı sorumluluk Etkinlik, Turnuva ya da Özel Etkinlik düzenleyicisine aittir.

 	Biletlerin alış ve satış işlemlerinden doğan hiçbir yasal sorumluluk Etkinlik Kafasına ait değildir. Etkinlik, Turnuva ya da Özel Etkinliğin düzenleyicisinin gerçekleştirdiği internette bu mesafeli satıştan ve Tüketici haklarından Etkinlik Kafası bir sorumluluğu olmayıp, bu hususlarda sadece etkinlik düzenleyen kişi yada kurumsal sorumludur. Etkinlik Kafası Uygulaması sadece Etkinlik, Turnuva ya da Özel Etkinliklerin duyurulduğu bir platformdur bilet alış ve satış işlemlerinin muhatabı Etkinlik Kafası değildir. 
Uygulama Sayesinde Sunulan yayınlanan içerikler tamamen Etkinlik, Turnuva ya da Özel Etkinliği düzenleyen tarafından belirlenmektedir. Etkinlik Kafası herhangi bir etkisi ve yetkisi bulunmamaktadır. 
Etkinlik, Turnuva ya da Özel Etkinliğine katılan Bireysel ya da Kurumsal Kullanıcı veya Etkinlik, Turnuva ya da Özel Etkinliği düzenleyen ya da düzenleyenlerin fotoğraflarını sosyal mecralarda reklam amaçlı kullanılacağını kabul, beyan ve taahhüt eder.
Etkinlik Kafası kullanıcısı üye tek taraflı olarak sözleşmeyi feshetme yetkisine sahiptir. Tüm üyeler sözleşmesini kabul ettikleri üye olduktan itibaren katıldıkları etkinliklerdeki fotoğraf ve video görüntülerini Etkinlik Kafası uygulaması, Web sitesi, Sosyal Ağlarında kullanılmasını kabul etmiş sayılırlar. Üyelikleri tek taraflı olarak feshedilen üyeler de dahil Etkinlik, Turnuva ya da Özel Etkinliklere katılan, Bireysel ya da Kurumsal üye olan veya olmayan herkes, fotoğraf ve video olmak üzere tüm medya ve sosyal medya da üyelikleri sonlansa dahi yayınlanmasını ve paylaşılmasını kabul ederler. 

Madde 7. Geliştiricinin Hakları
7.1. Geliştirici güvenlik nedeniyle Üye’ nin Uygulama üzerindeki her türlü aktivitesini izleyebilir, kayda alabilir ve/veya gerekli gördüğünde, Uygulama’ dan uzaklaştırma, üyelik dondurma, üyelik iptal etme ve benzeri her türlü müdahalede bulunabilir.
7.2. Geliştirici, önceden Üye’ ye bildirimde bulunmaksızın Uygulamanın biçim ve içeriğini kısmen ve/veya tamamen değiştirebileceği gibi, Uygulamanın yayın yaptığı alan adını değiştirebilir, farklı alt alan adları kullanabilir, alan adı yönlendirmesi yapabilir Uygulamanın ismini değiştire bilir isme ekleme yapabilir ve/veya alan adını kapatabilir.
7.3. Geliştirici, dilediği zamanda ve/veya sebep göstermeksizin, önceden Üye’ ye bilgi vermeksizin Uygulama’ da sunduğu hizmetlerin kapsam ve/veya çeşitlerini değiştirebileceği gibi, Uygulama’ da sunulan hizmetleri kısmen veya tamamen dondurabilir, sona erdirebilir, ücretli yapabilir veya tamamen iptal edebilir.
7.4. Geliştirici sözleşmede belirtilen iş ve/veya işlemlerin daha etkin gerçekleştirilebilmesi açısından dilediği zaman hizmet, kullanım şartları ve/veya işleyişte tek taraflı olarak değişiklikler ve/veya güncellemeler yapabilir. Üyeler işbu değişiklikleri kabul ettiklerini, bu değişikliklere uygun davranacaklarını şimdiden kabul ve beyan ederler.
7.5. İşbu sözleşme Geliştirici’ nin ürün satışı için herhangi bir taahhüt içermez. Üye, bu ve sair nedenlerle Geliştiriciden hiçbir ad altında hak ve alacak talep edemez.
7.6. Geliştirici’ nin üyeliği gerekli gördüğü hallerde tek taraflı olarak durdurma, sona erdirme ve/veya iptal etme hakkı mevcuttur. Üye bu hususta herhangi bir itiraz hakkının mevcut olmadığını kabul, beyan ve taahhüt eder.
7.7. Geliştirici, kullanıcı profili ve pazar araştırmaları yapmak, Etkinlik Kafası uygulaması ve site kullanım istatistikleri oluşturmak gibi amaçlar dâhil ancak bunlarla sınırlı olmamak üzere tüm yasal amaçlar için, Üye’ nin kimlik, adres, iletişim, site ve Apptivity kullanım bilgilerini bir veri tabanında toplayabilir ve bu bilgileri herhangi bir kısıtlama olmaksızın işleyebilir. Ayrıca Geliştirici bu bilgileri, yasaların getirdiği zorunluluklara uyma amacıyla veya yetkili adli veya idari otoritenin yürüttüğü soruşturma veya araştırma açısından talep edilmesi durumunda veya kullanıcıların hak ve güvenliklerinin korunması amacıyla üçüncü kişi/kurumlarla paylaşabilir.
7.8. Geliştirici, ilave hizmetler açabilir, bazı hizmetlerini kısmen veya tamamen değiştirebilir veya ücretli hale dönüştürebilir. Bu durumda Kullanıcının Sözleşmeyi feshederek, üyelikten ayrılma hakkı saklıdır.
7.9. Geliştirici, ileride doğacak teknik zaruretler ve mevzuata uyum amacıyla kullanıcıların aleyhine olmamak kaydıyla işbu Sözleşme’nin uygulamasında değişiklikler yapabilir, mevcut maddelerini değiştirebilir veya yeni maddeler ilave edebilir.
7.10. Geliştirici, Etkinlik Kafası uygulamasında sunulan hizmetleri ve içerikleri her zaman değiştirebilme; Üyelerin sisteme yükledikleri bilgileri ve içerikleri Etkinlik Kafası kullanıcıları da dâhil olmak üzere üçüncü kişilerin erişimine kapatabilme ve silme hakkını saklı tutmaktadır. Geliştirici, bu hakkını hiçbir bildirimde bulunmadan ve önel vermeden kullanabilir. Üyeler, Geliştiricinin talep ettiği değişiklik ve/veya düzeltmeleri ivedi olarak yerine getirmek zorundadırlar. Değişiklik ve/veya düzeltmeleri gerekli görüldüğü takdirde Geliştirici bizzat yapabilir. Geliştirici tarafında n talep edilen değişiklik ve/veya düzeltme taleplerinin, kullanıcılar tarafından zamanında yerine getirilmemesi sebebiyle doğan veya doğabilecek zararlar, hukuki ve cezai sorumluluklar tamamen kullanıcılara aittir.
 	7.11. Geliştirici, uygulamanın işleyişine, hukuka, başkalarının haklarına, işbu sözleşmede yer alan koşullara, kişisel verilerin korunmasına Madde 4 ve Madde 5 de yer alan hususlara aykırı olan mesajları, yorumları, içerikleri istediği zaman ve şekilde erişimden kaldırabilir; Geliştirici bu mesaj ve içeriği giren Üyenin üyeliğine herhangi bir bildirim yapmadan son verebilir.
 
7.12. Geliştiricinin, Etkinlik Kafası üzerinde Üyeler tarafından sağlanan içeriklerin hukuka uygun olup olmadığını, gerçekliğini, doğruluğunu araştırmak ve kontrol etmek yükümlülüğü bulunmamaktadır.
 
Madde 8. Üye’ nin Yükümlülükleri
8.1. Üyelik, Etkinlik Kafası uygulaması üzerinde belirtilen üyelik prosedürlerinin üye olmak isteyen kişi tarafından yerine getirilerek kayıt işleminin yapılması ile tamamlanır. Kullanıcılar üye olmakla, işbu sözleşme hükümlerini, üyeliğe ve hizmetlere ilişkin Geliştirici tarafından açıklanan/açıklanacak her türlü beyanı da kabul etmiş olmaktadır.
8.2. Üye, üyelik işlemlerinde doldurmuş olduğu üyelik formunda yazan adı soyadı ve/veya iletişim bilgilerinin eksiksiz ve doğru olduğunu, bilgilerinde değişiklik olması halinde bu bilgileri derhal Etkinlik Kafası Uygulaması üzerinden düzenleme yaparak eksik, güncel olmayan ve/veya yanlış bilgi vermesi nedeniyle ortaya çıkabilecek her türlü hukuki uyuşmazlık ve/veya zarardan sadece kendisinin sorumlu olacağını kabul ve beyan eder. Geliştiriciye bu nedenle hiçbir sorumluluk izafe edilemez.
8.3. Üye, Uygulamayı kullanırken başkaları tarafından kolay tahmin edilemeyecek bir şifre kullanacağını, kullanıcı adı, şifre ve benzeri bilgilerini başkalarıyla paylaşmayacağını ve bu güvenliğinden bizzat ve sadece kendisinin sorumlu olacağını, söz konusu bilgilerin çalınması, kaybolması vb sebeplerle uğrayacağı zarar ve/veya ihlalden hiçbir şekilde Geliştiricinin sorumlu olmayacağını kabul ve beyan eder.
8.4. Üye, Etkinlik Kafası uygulaması üzerinde yer alan Sekme ve Hizmetleri kullanımı esnasında; Anayasa kanun, yönetmelik, kanun hükmünde kararname, yönerge, tebliğ, genelge ve talimatlara ve gerçek ve/veya tüzel kişilerim maddi ve manevi varlıklarına aykırı davranışlarda bulunmayacağını, işbu davranıştan ötürü ortaya çıkabilecek her türlü zarardan sorumlu olduğunu, söz konusu yükümlülüğe uymaması halinde Geliştiricinin üyeliği tek taraflı olarak durdurma, sona erdirme ve/veya iptal etme hakkı mevcut olduğunu kabul, beyan ve taahhüt eder.
8.5. Üye, hileli davranışlarda bulunmayacağını, Uygulamanın güvenlik mekanizmasına müdahale etmeyeceğini aksi halde oluşabilecek her türlü zarardan sorumlu olduğunu kabul ve taahhüt eder.
8.6. Üye, sadece kendisine ait üyelik hesabını kullanacağını, başka üyelerin hesap bilgilerini kullanmayacağını ve/veya kendisine ait üyelik hesabını başkalarına kullandırtmayacağını, birden fazla hesap açarak Etkinlik Kafası tarafından sağlanacak her türlü imkan/kampanya/indirimden haksız olarak faydalanmayacağını, aksi durumun Geliştirici tarafından tespit edilmesi halinde, üyeliğinin/üyeliklerinin iptal edilebileceğini ve doğmuş/doğacak her türlü zararı tazmin edeceğini kabul ve beyan eder.
8.7. Üye, üyelik hesabını üçüncü kişilere devredemez. Bu şekilde bir devrin yapılması halinde, Geliştirici üyeliği iptal etme hakkı saklıdır.
8.8. Üye, başkalarının Site ve Uygulama kullanımını kısıtlayamaz, engel olamaz ve Site, Uygulama veya bu araçları kullanılabilir hale getirmek için kullanılan sunucu veya ağların işletimine müdahale edemez.
8.9. Üyenin, Uygulamayı kullandığı cihaz ya da cihazların donanımını etkileyen virüs saldırılarından ve/veya siteden ya da uygulamadan edindiği bilgiler sebebiyle veya siteye, uygulama ya erişimine ve kullanımına ilişkin olarak doğrudan veya dolaylı olarak meydana gelebilecek zararlardan Geliştiricisi, Yöneticileri ve Sahibi sorumlu değildir.
8.10. Üye, Uygulama ve Site çalışmasına müdahale etmek veya müdahaleye teşebbüs etmek amacıyla herhangi bir alet, yazılım ve/veya araç kullanmayacağını, Uygulama ya da siteye yetkisiz olarak bağlanmayacağını ve işlem yapmayacağını, diğer internet kullanıcılarının yazılımlarına ve verilerine izinsiz olarak ulaşmayacağını veya bunları kullanmayacağını kabul eder.
8.11. Üye, üyelik işlemleri sırasında verilen bilgilerin doğru olduğunu, Geliştirici tarafından Üye bilgilerinin teyit edilmesi amacıyla belge/bilgi (SMS ve e-posta doğrulama kodları dâhil) sunulmasını isteyebileceğini, sunulmadığı zaman üyeliğin Geliştirici tarafından dondurulabileceğini kabul, beyan ve taahhüt eder.
8.12. Üye hukuka uygun amaçlarla Apptivity uygulamasını kullanabilir ve uygulama üzerinde işlem yapabilir. Üyenin, Apptivity dâhilinde yaptığı her işlem ve eylemdeki hukuki ve cezai sorumluluk kendisine aittir.  Üye, Geliştiricinin ve/veya başka bir üçüncü şahsın ayni veya şahsi haklarına, malvarlığına, kişisel verilerine tecavüz teşkil edecek nitelikteki Apptivity dâhilinde bulunan resimleri, metinleri, görsel ve işitsel imgeleri, video klipleri, dosyaları, veri tabanları, katalogları ve listeleri çoğaltmayacağını, kopyalamayacağını, dağıtmayacağını, işlemeyeceğini, başka veri tabanına aktarmayacağını veya bu nitelikte sonuçlar doğurabilecek şekilde Activuss’a yüklemeyeceğini; bu tür eylemler gerçekleştirerek herhangi bir ticari faaliyette bulunmayacağını; gerek bu eylemleri ile gerekse de başka yollarla doğrudan ve/veya dolaylı olarak haksız rekabet teşkil eden davranış ve işlemler gerçekleştirmeyeceğini kabul ve taahhüt etmektedir. Üyenin işbu sözleşme hükümlerine ve hukuka aykırı olarak gerçekleştirdikleri Activuss üzerindeki faaliyetler nedeniyle üçüncü kişilerin uğradıkları veya uğrayabilecekleri zararlardan dolayı Geliştiricisi, Yöneticileri ve Sahibi doğrudan ve/veya dolaylı olarak hiçbir şekilde sorumlu tutulamaz.
8.13. Üye, Etkinlik Kafası uygulaması üzerinden gerçekleştirdiği, buluşma, tanışma, görüşmelerde kendi güvenliğinden sorumludur. Etkinlik Kafası hiçbir üyenin güvenliğini garanti etmez.
8.14. Etkinlik Kafası bünyesinde kayıtlı olan üyelerin paylaştıkları bilgilerin gerçekliğini, doğruluğunu garanti etmez. Üye iletişime geçeceği diğer üyelerin verdiği yanlış bilgilerden dolayı uğrayacak tüm zarardan kendisi sorumludur. Geliştiricisi, Yöneticileri ve Sahibi bu nedenle yaşanacak zararlardan dolayı hiçbir sorumluluk üstlenmez.
8.15. Geliştirici, yasalara aykırı olma şüphesi barındıran üye hakkında bünyesindeki tüm bilgileri güvenlik güçleri ve resmi makamlarla paylaşmaya hazırdır.
 
Madde 9. Üyelik Paketleri
 	Etkinlik Kafası Uygulaması Siteminde farklı kullanım ve deneyim olanakları sağlayan bir katım üyelik paketleri sunmaktadır. Bu üyelik paketlerinin uygulama üzerindeki erişim ve kısıtlamalar tamamen Etkinlik Kafası Geliştiricisi, Yöneticileri ve Sahibinin inisiyatifine bağlı olarak yeniden düzenlenebilir yeni haklar verile bilir ya da verilen haklar geri alına bilir. Uygulamanın sunmuş olduğu ayrıcalıklar tamamen Geliştiricinin inisiyatifine bağlı olarak kullanıcı paketlerine göre verilen haklar ve özellikler değişebilir. Üyelik Paket içeriklerinde sunulan hak ve özelliklerin değiştirilmesi, kaldırılması, yeni özellik eklenmesi ya da tamamen o üye paketinin kaldırılması geliştiricinin inisiyatifine bağlıdır. Bu tür durumlarda üye hiçbir hak iddia edemez. Doğa bilecek zararlardan Geliştiricisi, Yöneticileri ve Sahibi sorumlu değildir.

9.1. Standart Üyelik	
	Standart Üyelik: Ekinlik ya da turnuva açabilir Acılan Etkinliklere ya da turnuvalara katıla bilir haftalık olarak etkinlik açma ve etkinliğe katılma sınırı vardır bu sınır uygulama geliştiricisinin inisiyatifine bağlı olarak arttırıla bilir ya da azaltıla bilir.
9.2. Plus Üyelik
	Plus Üyelik: Ekinlik Açabilir Acılan Etkinliklere katıla bilir haftalık olarak etkinlik açma ve etkinliğe katılma sınırı vardır bu sınır uygulama geliştiricisinin inisiyatifine bağlı olarak arttırıla bilir ya da azaltıla bilir.
9.3. Gold Üyelik
	Gold Üyelik: Ekinlik Açabilir Acılan Etkinliklere katıla bilir haftalık olarak etkinlik açma ve etkinliğe katılma sınırı yoktur. Açacağı etkinliklerde özel filtreleme sistemini aktif olarak kullana bilir ayrıcalıklardan yaralana bilir bu ayrıcalıklar tamamen uygulama geliştirişinin inisiyatifine bağlı olarak eklene bilir ya da kaldırıla bilir. ÖZEL Etkinlik açma ve katılma hakkı vardır.
9.4. Kurumsal Üyelik
	Kurumsal Üyelik: Ekinlik Açabilir Acılan Etkinliklere katıla bilir haftalık olarak etkinlik açma ve etkinliğe katılma sınırı yoktur. Açacağı etkinliklerde özel filtreleme sistemini aktif olarak kullana bilir ayrıcalıklardan yaralana bilir bu ayrıcalıklar tamamen uygulama geliştirişinin inisiyatifine bağlı olarak eklene bilir ya da kaldırıla bilir. ÖZEL Etkinlik açma ve katılma hakkı vardır.


Madde 10. Kişisel Verilerin Gizliliği ve Ticari Elektronik İleti

10.1. Geliştirici Etkinlik Kafası sizlere daha iyi hizmet sunmak adına bazı kişisel verilerinizi (ad soyad, e-posta adresi, Doğum Tarihi, Meslek, öğrenim Durumu, ilişki durumu, Cinsiyet, cep telefonu numarası, Konum Bilgileri de dâhil bunlarla sınırlı olmamak kaydıyla elde edilmiş tüm kişisel veriler) talep etmektedir. Söz konusu kişisel verileriniz açık rızanıza istinaden işbu kişisel verilerin korunması bildiriminde belirtilen amaçlar ve kapsam dışında kullanılmamak kaydıyla halka açık olmayan bir ortama işleyecek ve bu ortamda muhafaza edecektir. Üyeyi tanımlamaya yönelik her türlü kişisel veriyi toplama, saklama, aktarma gibi her türlü işleme işlemini yapmaya yetkilidir.
Etkinlik Kafası bünyesinde, mahremiyetiniz bizim için çok önemli bir önceliktir. 
10.2. Geliştirici, kişisel bilgileri kesinlikle özel ve gizli tutmayı, bunu bir sır saklama yükümlülüğü olarak addetmeyi ve gizliliğin sağlanması ve sürdürülmesi, gizli bilginin tamamının veya herhangi bir kısmının kamu alanına girmesini veya yetkisiz kullanımını veya üçüncü bir kişiye ifşasını önlemek için gerekli tüm tedbirleri almayı ve gerekli özeni göstermeyi taahhüt etmektedir. İşbu yükümlülük yasaların getirdiği zorunluluklara uyma amacıyla veya yetkili adli veya idari otoritenin yürüttüğü soruşturma veya araştırma açısından talep edilmesi durumunda uygulanmayacaktır.
10.3. Geliştiricinin gerekli bilgi güvenliği önlemlerini almasına karşın, Siteye, Uygulamaya ve sisteme yapılan saldırılar sonucunda gizli bilgilerin zarar görmesi veya üçüncü kişilerin eline geçmesi durumunda, Geliştiricisi, Yöneticileri ve Sahibi herhangi bir sorumluluğu olmayacaktır.
10.4. Geliştiricinin sunucularında toplanan bu bilgiler, dönemsel kampanya çalışmaları, üye profillerine yönelik özel promosyon faaliyetlerinin kurgulanması ve istenmeyen e-postaların iletilmemesine yönelik müşteri "sınıflandırma” çalışmalarında sadece Geliştirici tarafından kullanılacaktır. Kişisel veriler Etkinlik Kafası bünyesinde tamamen veya kısmen, otomatik olan veya olmayan yollarla elde etme, kaydetme, depolanma, muhafaza etme, değiştirme, yeniden düzenleme, aktarma vb. işlemler aracılığıyla işlenebilir.

10.5. Kişisel bilgiler Etkinlik kapsamında Organizatör ile paylaşılabilir.
10.6. Üye bilgileri, ancak resmi makamlarca usulü dairesinde bu bilgilerin talep edilmesi halinde ve yürürlükteki emredici mevzuat hükümleri gereğince resmi makamlara açıklama yapmak zorunda olduğu durumlarda resmi makamlara açıklanabilecektir.
10.7. Üye, kişisel verilerinin işlenip işlenmediğini, işlenme amacını, verilerin aktarıldığı üçüncü kişileri, verilerin düzeltilmesini, silinmesini, anonim hale getirilmesini veya yok edilmesini her zaman talep edebilir ve bilgi alabilir.
10.8. Üye, işbu Sözleşmeyi kabul ederek, Geliştiricinin “Gizlilik Politikası” bölümünü de okuduğunu ve anladığını kabul eder.
10.9. Üye aynı zamanda Geliştiricinin etkinlik, aktivite yarışma veya oyunlar dâhil olmak üzere her türlü ticari elektronik veri, ses ve görüntü içerikli iletilerin telefon, çağrı merkezi, otomatik arama, elektronik posta, kısa mesaj hizmeti gibi vasıtalar kullanılarak iletebileceğini kabul ve beyan eder.
10.10. 	Kişisel verilerin Korunması Kanunun’ dan Doğan Haklarınız 
        	Kanun’un 11. Maddesine göre kişisel veri sahibi olarak müşteriler;
•	Kişisel veri işlenip işlenmediğini öğrenme,
•	Kişisel veriler işlenmişse buna ilişkin bilgi talep etme,
•	Kişisel verilerin işlenme amacını ve bunların amacına uygun kullanıp kullanılmadığını öğrenme,
•	Yurt içinde veya yurt dışında kişisel verilerin aktarıldığı üçüncü kişileri bilme,
•	Kişisel verilerin eksik ya da yanlış işlenmiş olması halinde bunların düzeltilmesini isteme,
•	Kişisel verilerin silinmesini, anonim hale getirilmesini veya yok edilmesini isteme,
•	Düzeltilme, silinme, anonim hale getirme veya yok edilmesi halinde bunun üçüncü kişilere bildirilmesini isteme,
•	İşlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme,
•	Kişisel verilerin kanuna aykırı olarak işlenmesi sebebiyle zarar uğraması halinde zararın giderilmesini talep etme haklarına sahiptir. Söz konusu haklarınızı kullanmak için sistem üzerinden moderatörlere mesaj atabilirsiniz.

 
  

10.11. Bu Gizlilik Politikası Nerede Uygulanır

İşbu Gizlilik Politikası, Etkinlik Kafası tarafından yürütülen web siteleri, uygulamalar, etkinlikler, Etkinlik Kafası Sosyal Ağları ve diğer hizmetler için geçerlidir. Basitlik adına, işbu Mahremiyet Politikasında tüm bunlara “hizmetler” adını veriyoruz. Bazı hizmetler kendilerine özgü mahremiyet politikaları gerektirebilir. Belirli bir hizmetin kendi mahremiyet politikası varsa, bu durumda işbu Mahremiyet Politikası yerine o politika geçerli olur.

10.12. Kişisel Verilerin Aktarılması

              Tarafınızdan edinilmiş olan kişisel veriler mevzuat hükümlerinin izin verdiği ya da zorunlu tuttuğu kişi veya kuruluşlarla, Gümrük ve Ticaret Bakanlığı, BDDK, SPK, TCMB gibi kamu tüzel kişileriyle, resmi mercilerin talepleri üzerine resmi mercilerle paylaşılabilecektir.
10.13. KİŞİSEL VERİLERİN TOPLANMA YÖNTEMİ
İnternet sitesi, uygulama, gibi kanallarla kişisel verileriniz yazılı, sözlü veya elektronik ortamda toplanabilir.
10.14. 	Etkinlik Kafasına Verilen Bilgiler
Hizmetlerimizi kullandığınızda bize belirli kişisel bilgilerinizi kendi rızanızla vermeyi seçiyorsunuz. 
Bu kapsamda aşağıda bilgileri içermektedir:
•	Bir hesap oluşturduğunuzda, kişisel bilgilerinizi ve hizmetin işlemesi için gerekli olan temel bilgileri ( ad soyad, E-posta, Doğum Tarihi, Cinsiyet ve Profil doğrulamak için GSM numarası) vermiş olacaksınız.
•	Profilinizi tamamladığınızda bizler ile kişiliğiniz, yaşam tarzınız, ilgi alanlarınız, fotoğraflarınız ve diğer paylaşmayı istediğiniz ek bilgiler ile içerikleri bizimle paylaşabilirsiniz. 
•	Resim gibi belli içerikleri eklemek için, kameranıza veya fotoğraf albümünüze erişmemize izin vermeniz gerekecektir. 
•	Ücretli bir hizmete abone olduğunuzda ya da (iOS veya Android gibi bir platform aracılığıyla yapmak yerine) doğrudan uygulama yöneticisinden bir alım gerçekleştirdiğinizde, Uygulama yöneticisine veya ödeme hizmeti sağlayıcımıza banka veya kredi kartı numaranız ve diğer finansal bilgileriniz gibi bilgileri vermiş olacaksınız.
•	Erkinlik, Turnuva ya da Özel Etkinliklere katılmayı seçtiğinizde (Kiminle ya da Kimlerle, Nerede, Ne zaman vb.) bu veriler toplanır ve kayıt edilir.
•	İletişim bölümünden irtibata geçerseniz, etkileşim sırasında bize verdiğiniz bilgileri toplarız. Bazen yüksek kalitede bir hizmet sunmak için bu etkileşimleri takip ederek kaydederiz.
•	Bizden başka insanlarla iletişim (örneğin Etkinlik Paylaşımları vb.) kurmamızı ya da bu kişilerin bilgilerini işlememizi isterseniz (örneğin sizin adınıza arkadaşlarınızdan birine bir e-posta göndermemizi isterseniz), isteğinizi tamamlama amacıyla başkaları hakkındaki bize vermiş olduğunuz bilgileri tüm sorumluluk size ait olmak üzere toplarız.
•	Diğer kullanıcılarla olan Etkinlik, Turnuva ya da Özel Etkinlikler Sonucu Gerçekleşen yorum, oylama, sohbetlerinizi ve yayımladığınız içerikleri de hizmet faaliyetlerinin parçası olarak kayıt edilir ve işlenir.
Madde 11. Sorumluluk
11.1. Üye, Site ve Uygulama ’da sunulan/yayınlanan bilgi ve/veya hizmetlerde eksiklik, iletişim sorunları, teknik problemler, altyapı ve/veya internet arızaları, elektrik kesintisi ve/veya sayılanlarla sınırlı olmaksızın başkaca problemler olabileceğini kabul etmekte olup, bu tür problemler/arızalar oluşması durumunda Geliştirici, Ünye’ye herhangi bir bildirimde bulunmaya gerek olmaksızın ve/veya sebep göstermeksizin satışı durdurmaya ve/veya sona erdirmeye ve/veya iptal etmeye yetkilidir. Üye bu nedenlerle Geliştiriciden hiçbir ad altında hak ve ödeme talep edemez.
11.2. Geliştirici hizmetin hatasız olacağını veya sürekli sağlanacağını veya hizmetin virüs ve diğer zararlı unsurlardan arınmış olduğunu garanti etmemektedir.
 
Madde 12. Üyelik İptali ve Sözleşmenin Feshi
12.1. Üyenin işbu sözleşmeden kaynaklanan yükümlülüklerinden herhangi biri ve/veya tamamına kısmen ve/veya tamamen aykırı davranması durumunda Geliştirici, herhangi bir bildirime gerek olmaksızın ve/veya gerekçe göstermeksizin tek taraflı olarak işbu sözleşmeyi dilediği zaman feshederek Üyenin üyeliğini iptal edebilir ve Üyenin Uygulamadan aldığı, almakta olduğu ya da alacağı hizmetleri kısmen veya tamamen dondurulabilir veya iptal edebilir. Bu nedenle fesih durumunda Üye Geliştiriciden hiçbir hak ve/veya talepte bulunamaz. Geliştirici, doğmuş/doğacak her türlü zararını Üyeden talep etmeye yetkilidir.
12.2. Geliştirici, işbu sözleşmeyi dilediği takdirde hiçbir sebep göstermeksizin ve herhangi bir bildirime gerek olmaksızın tek taraflı olarak feshederek Üyenin üyeliğini iptal etmeye ve Üyenin Uygulamadan aldığı, almakta olduğu ya da alacağı hizmetleri kısmen veya tamamen dondurmaya ya da tümüyle iptal etmeye yetkilidir. Bu takdirde Üye haksız, yersiz, sebepsiz, huzursuz ve zamansız bir fesihte bulunulduğu, iyi niyete aykırı davranıldığı veya sair bir neden ve bahane öne sürerek Geliştiriciden hiçbir hak, alacak, kar kaybı, zarar ziyan tazminatı veya başkaca bir nam ve unvan altında herhangi bir ödeme talep edemez.
 
Madde 13. Sözleşmenin Süresi
İşbu sözleşme Sitede veya Uygulamada onaylandığı andan itibaren yürürlüğe girer ve Geliştirici veya Üyenin üyeliğini iptal etmesi ile başkaca bildirime gerek olmaksızın kendiliğinden sona erer.
 
Madde 14. Mücbir Sebepler
Etkinlik Kafası, işbu Kullanıcı Sözleşmesi ile ilgililerinden herhangi birbirini geç veya eksik ifa etme veya ifa etmeme nedeniyle yükümlü değildir. Mücbir Sebepler Hukuken 'mücbir sebep' sayılan tüm hallerde, ya da Siber saldırılar, servis erişiminin durdurulması, doğal afetler, yangın, grev, lokavt, savaş hali, ayaklanma, terör olayları, hükümetçe alınacak yasal ve idari kararlar dâhil ancak bunlarla sınırlı olmamak üzere Tarafların öngöremediği veya öngörse bile makul önlemlerle engelleyemediği mücbir sebep hallerinde Sözleşme askıya alınır ve Taraflar Sözleşmeden kaynaklanan yükümlülüklerini yerine getiremedikleri gerekçesiyle sorumlu tutulamazlar. Taraflar, mücbir sebep halinin ortaya çıkması üzerine durumu derhal diğer Tarafa bildirir. Mücbir sebep halinin ortaya çıktığı tarihten itibaren 30 (otuz) günden uzun sürmesi halinde bu sürenin sonunda Sözleşme ayrıca ihbara gerek kalmaksızın kendiliğinden sona erecektir.

Madde 15. Muhtelif Hükümler
15.1. Üye, Sözleşme ve hizmetlerde yapılacak değişikliklerin, satış ile ilgili hususların, üyeliğin iptalinin, işbu sözleşmenin feshinin, sona erdirilmesinin ve benzeri her türlü bildirimin üyelik işlemleri esnasına belirttiği e-posta adresine yapılmasına muvafakat etmiş olup, e-posta ile yapılan bildirimler ulaşsın veya ulaşmasın bildirimin Geliştirici tarafından gönderildiği andan itibaren tebliğ edilmiş olduğunu ve hukuki sonuçlarını doğuracağını kabul ve taahhüt eder. Bildirimin Üyeye geç ulaşması veya ulaşmamasından ve sonuçlarından Geliştirici sorumlu değildir.
15.2. İşbu Sözleşme’nin herhangi bir hükmünün, herhangi bir nedenden dolayı geçersiz sayılması veya uygulanabilirliğinin kalmaması halinde, sözleşmenin diğer hükümleri yürürlükte kalacaktır.
15.3. Geliştiricinin sözleşme tahtında sahip olduğu herhangi bir hak veya yetkiyi kullanmaması ya da kullanmakta gecikmesi o hak veya yetkiden feragat ettiği anlamına gelmediği gibi, bir hak veya yetkinin tek başına veya kısmen kullanılması o veya başka bir hak veya yetkinin daha sonra kullanılmasını engellemez, feragat anlamı taşımaz.
15.6. İşbu Sözleşme’ den doğan uyuşmazlıkların çözümü hususunda Ankara Mahkemeleri yetkilendirilmiştir. Sözleşmeden doğacak uyuşmazlıklarda Etkinlik Kafası kayıt ve defterleri ile online verileri HMK. Kapsamında münhasır delil olarak kabul edilecektir.
15.7. Üye Uygulamanın Üyelik Sözleşmesin de yer alan tüm maddeleri ve kuralları okuyup anladığını ve kabul ettiğini beyan eder. Üye, sözleşmenin tamamında yer alan menfaatlerine aykırı olabilecek düzenlemeleri de sonuçlarını bilerek ve anlayarak kabul ettiğini beyan eder.

16) Diğer Hükümler 

16.1. Fikri Mülkiyet Hakları Uygulamanın (tasarım, metin, imge, html kodu ve diğer kodlar da dâhil ve bunlarla beraber kaydıyla) tüm kullanıcıları (Etkinlik Kafası telif haklarına tabi çalışmalar) Etkinlik Kafasına ait olarak ve / veya Etkinlik Kafası tarafından üçüncü bir kişiden örnek lisans hakkı kullanılmaktadır. Kullanıcılar, Etkinlik Kafası Hizmetlerini, Etkinlik Kafası bilgi ve Etkinlik Kafası telif haklarına tabi yeniden satamaz, paylaşamaz, dağıtamaz, sergileyemez, çoğaltamaz, bunlardan üremiş çalışmalar yapamaz veya hazırlayamaz veya başkasının Etkinlik Kafası Hizmetlerine erişmesine veya kullanımına izin ‘in veremezsiniz; aksi takdirde, lisans verenler de ancak bunlarla dolu, Üçüncü kişilerin uğradıklarından ötürü Etkinlik Kafası talep edilen tazminat ve mahkeme masrafları ve avukatlık ücreti ve ancak bununla olmamak üzere diğer her türlü öğrenmekle sorumlu olacaklardır. 
Etkinlik Kafası, Etkinlik Kafası Hizmetleri, Etkinlik Kafası bilgileri, Etkinlik Kafası telif haklarına tabi çalışmalar, Etkinlik Kafası ticari görünümü veya Uygulamanın sahip olduğu her tür maddi ve fikri mülkiyet hakları da dâhil tüm malvarlığı, ayni ve şahsi hakları, ticari bilgiler ile ilgili tüm hakları saklıdır.

 	16.2.  Uygun Değişiklikleri Etkinlik Kafası tamamen kendi takdirine bağlı ve tek olarak, işbu Kullanıcı Sözleşmesi, uygun göreceği herhangi bir zamanda, Uygulama ya da site de ilan etmeden değiştirebilir. 
İşbu Kullanıcı Sözleşmesinin değişen hükümleri, ilan edildikleri tarihte geçerlilik kazanacak; geri kalan hükümler, aynen yürürlükte kalarak hüküm ve sonuçlarını doğurmaya devam edebilir. İşbu Kullanıcı Sözleşmesi, Kullanıcının tek taraflı beyanları ile değiştirilemez. 


16.3.  Uygulanacak Hukuk ve Yetki İşbu Kullanıcı Sözleşmesi uygulanmasında, yorumlanmasında ve hükümlerinde doğan hukuki ilişkilerin yönetiminde Türk Hukuku uygulanacaktır. İşbu Kullanıcı Sözleşmesi'nden doğan veya doğabilecek her türlü ihtilafın hallinde, Ankara Mahkemeleri ve İcra Daireleri yetkilidir. 


Etkinlik Kafası Gizlilik Politikası


Etkinlik Kafası sizlere daha iyi hizmet sunmak adına bazı kişisel verilerinizi (ad soyad, e-posta adresi, Doğum Tarihi, Meslek, öğrenim Durumu, ilişki durumu, Cinsiyet, cep telefonu numarası, Konum Bilgileri de dahil bunlarla sınırlı olmamak kaydıyla elde edilmiş tüm kişisel veriler) talep etmektedir. Söz konusu kişisel verileriniz açık rızanıza istinaden iş bu kişisel verilerin korunması bildiriminde belirtilen amaçlar ve kapsam dışında kullanılmamak kaydıyla halka açık olmayan bir ortama işleyecek ve bu ortamda muhafaza edecektir.


Etkinlik Kafası bünyesinde, mahremiyetiniz bizim için çok önemli önceliktir. 

2	GİZLİLİK POLİTİKASI NEREDE UYGULANIR

İş bu Gizlilik Politikası, Etkinlik Kafası tarafından yürütülen web siteleri, uygulamalar, etkinlikler, Etkinlik Kafası Sosyal Ağları ve diğer hizmetler için geçerlidir. Basitlik adına, iş bu Mahremiyet Politikasında tüm bunlara “hizmetler” adını veriyoruz. Bazı hizmetler kendilerine özgü mahremiyet politikaları gerektirebilir. Belirli bir hizmetin kendi mahremiyet politikası varsa, bu durumda Mahremiyet Politikası yerine o politika geçerli olur.

3	KİŞİSEL VERİLERİN İŞLENME AMACI

 	Kişisel verileriniz üye kaydınızın oluşturulmasında, profilinizin oluşturulmasında, üye istatistiklerinin oluşturulmasında, “sınıflandırma” çalışmalarında ve bunlarla sınırlı olmamak kaydıyla sizlere daha iyi hizmet sunabilmek adına gerekli görülen işlemlerde kullanılacaktır.
Kişisel verileriniz tamamen veya kısmen, otomatik olan veya olmayan yollarla elde etme, kaydetme, depolama, muhafaza etme, değiştirme, yeniden düzenleme vb. işlemler aracılığıyla işlenebilir. Toplanılan bilgiler, haberiniz ya da aksi bir talimatınız olmaksızın, üçüncü şahıslarla kesinlikle paylaşılmamakta, faaliyet dışı hiçbir nedenle ticari amaçla kullanılmamakta ve kâr elde etmek amacı ile satılmamaktadır. 
4	KİŞİSEL VERİLERİN AKTARILMASI
            
Tarafınızdan edinilmiş olan kişisel veriler mevzuat hükümlerinin izin verdiği ya da zorunlu tuttuğu kişi veya kuruluşlarla, Gümrük ve Ticaret Bakanlığı, BDDK, SPK, TCMB gibi kamu tüzel kişileriyle, resmi mercilerin talepleri üzerine resmi mercilerle paylaşılabilecektir.
5	KİŞİSEL VERİLERİN TOPLANMA YÖNTEMİ
İnternet sitesi, uygulama, gibi kanallarla kişisel verileriniz yazılı, sözlü veya elektronik ortamda toplanabilir.
Etkinlik Kafasına Verilen Bilgiler
Hizmetlerimizi kullanmak istediğinizde kişisel bilgilerinizi kendi rızanız ile Etkinlik Kafası bünyesinde KVKK (Kişisel Verileri Koruma Kanunu) kapsamında vermeyi kabul ve taahhüt etmiş sayılırsınız.


Bu kapsamda aşağıda bilgileri içermektedir:
•	Bir hesap oluşturduğunuzda, kişisel bilgilerinizi ve hizmetin işlemesi için gerekli olan temel bilgileri ( ad soyad, E-posta, Doğum Tarihi, Cinsiyet ve Profil doğrulamak için GSM numarası) vermiş olacaksınız.
•	Profilinizi tamamladığınızda bizler ile kişiliğiniz, yaşam tarzınız, ilgi alanlarınız, fotoğraflarınız ve diğer paylaşmayı istediğiniz ek bilgiler ile içerikleri bizimle paylaşabilirsiniz. 
•	Resim gibi belli içerikleri eklemek için, kameranıza veya fotoğraf albümünüze erişmemize izin vermeniz gerekecektir. 
•	Ücretli bir hizmete abone olduğunuzda ya da (iOS veya Android gibi bir platform aracılığıyla yapmak yerine) doğrudan uygulama yöneticisinden bir alım gerçekleştirdiğinizde, Uygulama yöneticisine veya ödeme hizmeti sağlayıcımıza banka veya kredi kartı numaranız ve diğer finansal bilgileriniz gibi bilgileri vermiş olacaksınız.
•	Erkinlik, Turnuva ya da Özel Etkinliklere katılmayı seçtiğinizde (Kiminle ya da Kimlerle, Nerede, Ne zaman vb.) bu veriler toplanır ve kayıt edilir.
•	İletişim bölümünden irtibata geçerseniz, etkileşim sırasında bize verdiğiniz bilgileri toplarız. Bazen yüksek kalitede bir hizmet sunmak için bu etkileşimleri takip ederek kaydederiz.
•	Bizden başka insanlarla iletişim (örneğin Etkinlik Paylaşımları vb.) kurmamızı ya da bu kişilerin bilgilerini işlememizi isterseniz (örneğin sizin adınıza arkadaşlarınızdan birine bir e-posta göndermemizi isterseniz), isteğinizi tamamlama amacıyla başkaları hakkındaki bize vermiş olduğunuz bilgileri tüm sorumluluk size ait olmak üzere toplarız.
•	Diğer kullanıcılarla olan Etkinlik, Turnuva ya da Özel Etkinlikler Sonucu Gerçekleşen yorum, oylama, sohbetlerinizi ve yayımladığınız içerikleri de hizmet faaliyetlerinin parçası olarak kayıt edilir ve işlenir.
KİŞİSEL VERİLERİN KORUNMASI KANUNU’NDAN DOĞAN HAKLARINIZ
          KVK Kanunu 11. Maddesine göre kişisel veri sahibi olarak müşterilerimiz;
•	Kişisel veri işlenip işlenmediğini öğrenme,
•	Kişisel veriler işlenmişse buna ilişkin bilgi talep etme,
•	Kişisel verilerin işlenme amacını ve bunların amacına uygun kullanıp kullanılmadığını öğrenme,
•	Yurt içinde veya yurt dışında kişisel verilerin aktarıldığı üçüncü kişileri bilme,
•	Kişisel verilerin eksik ya da yanlış işlenmiş olması halinde bunların düzeltilmesini isteme,
•	Kişisel verilerin silinmesini, anonim hale getirilmesini veya yok edilmesini isteme,
•	Düzeltilme, silinme, anonim hale getirme veya yok edilmesi halinde bunun üçüncü kişilere bildirilmesini isteme,
•	İşlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme,
•	Kişisel verilerin kanuna aykırı olarak işlenmesi sebebiyle zarar uğraması halinde zararın giderilmesini talep etme haklarına sahiptir. 
Söz konusu haklarınızı kullanmak için sistem üzerinden moderatörlere mesaj yolu ile ulaşabilirsiniz.

ETKİNLİK, TURNUVA YA DA ÖZEL ETKİNLİK İÇİN KULLANIM VE GÜVENLİK İPUÇLARI
Yeni insanlarla tanışmak heyecan verici, ama tanımadığınız biriyle ya da birileri ile iletişim kurarken her zaman dikkatli olmalısınız. En iyi takdirinizi kullanın ve ilk etkinlik veya turnuva için güvenliğinize öncelik verin. Başkalarının eylemlerini kontrol edemeseniz, Etkinlik Kafası deneyiminiz sırasında güvende olmanıza yardımcı olmak için yapabileceğiniz şeyler vardır.
Çevrimiçi Güvenlik
•	Platformda Kalın
Bir Etkinlik, Turnuva ya da Özel Etkinliğe Katıldığınız zaman etkinlik sahibi, turnuva sahibi ya da diğer katılımcıları tanımaya çalışırken konuşmaları ETKİNLİK KAFASI platformunda tutun. Kötü niyetli kullanıcılar genellikle sohbeti hemen SMS'e, mesajlaşma uygulamalarına, e-postaya veya telefona taşımaya çalışırlar. İletişim adreslerinizi paylaşmakta aceleci olmayın.
•	Asla Para Göndermeyin veya Finansal Bilgileri Paylaşmayın
Açılan Etkinlik, Turnuva Ya da Özel Etkinlikler için Kişi acil durumda olduğunu iddia etse bile, özellikle banka havalesi yoluyla asla para göndermeyin. Banka havalesi yapmak nakit göndermek gibidir işlemi geriye almak veya paranın nereye gittiğini takip etmek neredeyse imkansızdır. Finansal hesaplarınıza erişmek için kullanılabilecek bilgileri asla paylaşmayın. Başka bir kullanıcı sizden para isterse, derhal Program yönetimine bildirin. 
•	Kişisel Bilgilerinizi Koruyun
TC. Kimlik numaranız, ev veya iş adresiniz veya günlük rutininizle ilgili ayrıntılar (örneğin, her Pazartesi belirli bir spor salonuna gittiğiniz gibi) kişisel bilgilerinizi tanımadığınız insanlarla asla paylaşmayın.
Ebeveyn iseniz, çocuklarınızla ilgili paylaştığınız bilgileri profilinizde sınırlayın. Çocuğunuzun isimleri, okula gittikleri yerler, yaşları veya cinsiyetleri gibi ayrıntıları paylaşmaktan kaçının.
•	Tüm Şüpheli ve Rahatsız Edici Davranışları Bildirin
Birisi ya da birilerinin çizgiyi aştığını farkına varırsınız bunu yapan kişi ya da kişileri bilmek istiyoruz. Şartlarımızı ihlal eden herkesi engelleyin ve şikâyet bölümünü kullanarak bizlere bildirin ayrıca katılmış olduğunuz etkinlik, Turnuva ya da Özel Etkinlikler sonrasın da size sunulacak olan bu kişi hakkında İYİ, KARARSIZIM veya KÖTÜ bölümünde oylama yapınız. Düşüncelerinizi de etkinliğe katılan kullanıcının profiline girerek yorum bölümünden yaza bilirsiniz. 
ÖNEMLİ: Verilen İYİ, KARARSIZIM veya KÖTÜ puanlamalar tamamen gizli tutulmaktadır.
 İşte bazı ihlal örnekleri:
•	Para veya bağış talepleri
•	Reşit olmayan kullanıcılar
•	Taciz, tehdit ve hakaret içeren mesajlar
•	Şahsen buluşma sırasında veya sonrasında uygunsuz veya zararlı davranış
•	Sahte profiller
•	Ticari web sitelerine bağlantılar, ürün veya hizmet satma girişimleri dahil olmak üzere spam veya talep mesajları
Şüpheli davranışlar ile ilgili endişelerinizi iletişim bölümünden mesaj penceresinde şikâyet başlığı altından bizlere ihbar edebilirsiniz. 
•	Hesabınızı Koruyun
Güçlü bir şifre seçtiğinizden emin olun ve genel ya da ortak bir telefondan hesabınıza giriş yaparken daima dikkatli olun. ETKİNLİK KAFASI size asla kullanıcı adınızı ve şifrenizle ilgili bilgileri soran bir e-posta göndermez hesap bilgilerini isteyen bir e-posta alırsanız derhal bizlere bu durumu bildirin.
•	Yüz Yüze Buluşma
Güvenliğiniz için daima onaylı profilleri tercih ediniz.
Etkinlik Kafası platformunda bulunan kullanıcılarımız profillerini isteğe bağlı olarak onaylatarak Mavi Tık etiketini alırlar. Bu etikete sahip olan profillerin etkinlik ve turnuvalarına katılmaya özen gösterin.
Not 1 : MAVİ TIK talep etmek için iletişim bölümü mesaj penceresinde Mavi Tık Talebi başlığı altından anlık talep edebilirsiniz. 
Not 2 : MAVİ TIK alan kullanıcıların profili tamamen doğrudur anlamına gelmediğini unutmayın.



•	Halkla Açık Yerlerde Buluşun ve Orada Kalın
İlk katılacağınınız Etkinlik, Turnuva Ya da Özel Etkinlikler ilk seferde kalabalık, halka açık yerlerde olmasına dikkat edin.
Etkinlik, Turnuva ya da Özel Etkinlik açan kişinin etkinliği evinde veya başka bir özel yerde ise dikkatli olun İnsanların davranışlarını kontrol edemezsiniz. 
•	Arkadaşlarınıza ve Ailenize Planlarınızdan Bahsedin
Ne zaman ve nereye gideceğiniz de dâhil olmak üzere, bir arkadaşınıza veya aile üyenize planlarınızı söyleyin. Cep telefonunuzu her zaman yanınızda ve şarj edilmiş olarak bulundurun.
•	Ulaşımınızın Kontrolü Sizde Olsun
İstediğiniz zaman ayrılabilmeniz için buluşmanıza nasıl gidip döneceğinizin planlamasını kendiniz yapın. 

•	Sınırlarınızı Bilin
Alkolün sizin üzerinizdeki etkilerinin farkında olun. İrade ve dengeniz bozula bilir. Etkinlik, Turnuva Ya da Özel Etkinlikler de kişi ya da kişiler uyuşturucu kullanmanız veya daha fazla içmeniz için size baskı yapmaya çalışırsa, oradan uzaklaşın ve rahatsız olduğunuz insan ya da insanları kolluk kuvvetlerine bildirin konuyla ilgili olarak bize yapılan şikâyette kullanıcı ya da kullanıcılar platformdan uzaklaştırılır.
•	İçecekleri veya Kişisel Eşyaları Başı Boş Bırakmayın
Katılmış ya da düzenlemiş olduğunuz Etkinlik, Turnuva Ya da Özel Etkinliklerde İçeceğinizin nereden geldiğini ve her zaman nerede olduğunu bilin  yalnızca doğrudan barmen veya garson tarafından servis edilen içecekleri kabul edin. Cinsel saldırıyı kolaylaştırmak için içeceklerin içine atılan birçok madde kokusuz, renksiz ve tatsızdır. Ayrıca telefonunuzu, çantanızı, cüzdanınızı ve kişisel bilgilerinizi içeren her şeyi her zaman yanınızda bulundurun.
•	Kendinizi Rahatsız Hissederseniz, Oradan Ayrılın
Rahatsız oluyorsanız, Etkinlikten erken ayrılabilirsiniz. İçgüdüleriniz size bir şeylerin ters gittiğini veya güvensiz hissettiğinizi söylüyorsa, bulunduğunuz ortamdaki çalışanlar ya da yetkililerden yardım isteyin.

•	Etkinlik, Turnuva Ya da Özel Etkinlikler sonrası
Katılmış olduğunuz Etkinlik, Turnuva Ya da Özel Etkinlikler sonrası yaşamış olduğunuz deneyimi ve kullanıcıları platform üzerinden değerlendirmeyi unutmayın.
Değerlendirmenizi ; Etkinliklerim > Geçmiş Etkinlikler > Katılımcıları Oyla sekmesinden yapabilirsiniz. 
Yapmış olduğunuz değerlendirmeler ve yorumlar platformumuz için çok önemlidir. Çünkü amacımız daha kaliteli, güvenilir, kültür seviyesi yüksek, saygılı ve seviyeli bir platform kullanıcı topluluğu oluşturmaktır.

YARDIM, DESTEK VEYA TAVSİYE KAYNAKLARI
Unutmayın bu ipuçlarını izleseniz bile, hiçbir riski azaltmak mümkün değildir. Olumsuz bir deneyiminiz varsa, lütfen bunun sizin suçunuz olmadığını ve yardım alabileceğinizi unutmayın. Etkinlik Kafasındaki herhangi bir olayı bildirin ve aşağıdaki kaynaklardan birine ulaşmayı düşünün. Acil bir tehlike altında olduğunuzu düşünüyorsanız veya acil yardıma ihtiyacınız varsa, 155 (Polis İmdat), 156 (Jandarma), 112 (Acil Yardım) veya yerel yasa uygulayıcıları arayın.


Kullanım Hakkında Bilgilendirme
Etkinlik Kafası Uygulaması sizlerin sunduğu hizmetler ve SSS
Soru: Kimler Etkinlik Oluşturabilir ve kimler oluşturulan etkinliklere katılabilir?
Cevap: Tüm kullanıcılar Etkinlik oluşturabilir ve tüm kullanıcılar aranan şartlara göre oluşturulan Etkinliklere Katıl isteği gönderebilir. 
Not: Oluşturulmuş Etkinliğe Gönderilen katılım istekleri sizin o etkinliğe katıldığınız anlamına gelmez. Etkinlik sahibinin özgür iradesi ile istediği kişi ya da kişileri kabul etmek ya da kabul etmemek hakkına sahiptir.
Soru: Kimler Turnuva Oluşturabilir ve kimler oluşturulan Turnuvaya eşleşme isteği gönderebilir?
Cevap: Tüm kullanıcılar Turnuva oluşturabilir, Oluşturulan Turnuvalara tüm kullanıcılar Eşleşme talebi gönderebilir.
Not: Eşleşmeler sıra ile ya da Turnuva oluşturucusunun özgür iradesi ile değiştirilebilir. Turnuva sahibinin istediği kişi ya da kişileri hiçbir sebep belirtmeksizin turnuvadan çıkarma hakkı vardır.
Soru: Özel Etkinlik Nedir, Kimler Özel Etkinlik Oluşturabilir ve kimler oluşturulan Özel Etkinliğe katıl Talebi gönderebilir?
Cevap: Özel Etkinlik sadece etkinlik sahibin istediği kişilere davet olarak gönderilir bu etkinliği her kullanıcı görebilir fakat katılım isteği göndermez. Tüm kullanıcılar Özel Etkinlik Oluşturabilir, Özel Etkinliklere sadece Etkinlik sahibinin davet ettiği kullanıcılar ya da etkinlik sahibini takip eden kullanıcılar katıl isteği gönderebilir.
Not: Geliştirici Acılan Etkinlik, Turnuva Ya da Özel Etkinlikleri istediği zaman bireysel ya da kurumsal kullanıcıların statüsüne göre yeniden düzenleyebilir. Hali hazırda bulunan Standart, Plus ve Gold üyelik sitemini dilediği zaman aktif hale getirebilir ve hiçbir kullanıcı bu kısıtlamalardan dolayı hiçbir hak talep edemez.
Soru: Onaylı Profil olmak için ne yapmalıyım? (MAVİ TIK)
Cevap: MAVİ TIK talep etmek için iletişim bölümü > Mesaj penceresi > Başlıklar sekmesinden > Mavi Tık Talebi > Anlık selfinizi göndererek başvuruda buluna bilirsiniz. 
Soru: Temsilci kimdir, Ne işe yarar?
Cevap: Etkinlik Kafası uygulamasına ve platforma katkıda bulunan ya da buluna bilecek, uygulamayı temsil eden ya da temsil edebilecek potansiyeli sahip kişilerden seçilmiş üyelerdir. Temsilci temsil ettiği il, ilçe ya da üniversite de Etkinlik Kafası temsilcisi olarak gönüllü etkinlik ve turnuva düzenleyebilir temsilcilerin etkinlikleri ya da turnuvaları diğer etkinlik ya da turnuvalara göre daha prestijli ve katılımcı sayısı yüksektir.
Soru: Birden fazla profil açabilir miyim?
Cevap: Her kullanıcı bir profil açma hakkına sahiptir.


""",



              style: TextStyle(fontSize: 12.0.spByWidth,fontWeight: FontWeight.bold),),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Center(child: Text("",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("""
              



""",



                style: TextStyle(fontSize: 12.0.spByWidth,fontWeight: FontWeight.bold),),
            ),



          ],
        ),
      ),
    );
  }
}
