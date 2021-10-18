import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/adminKarsiAbout.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminKullaniciProfil/adminkullanicicontainer.dart';
import 'package:etkinlik_kafasi/AdminPanel/adminYetkilendirme.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/extensions/color_data.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/models/profil_kafalar.dart';
import 'package:etkinlik_kafasi/profilSayfalari/karsiuserkafalartab.dart';
import 'package:etkinlik_kafasi/profilSayfalari/profilgalerigrid.dart';
import 'package:etkinlik_kafasi/profilim/profil_listTitle.dart';
import 'package:etkinlik_kafasi/profilim/profiletkinlikcard.dart';
import 'package:etkinlik_kafasi/profilim/profilfotofull.dart';
import 'package:etkinlik_kafasi/profilim/tab_bar_row.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/imageviewGalleryKarsiKullanici.dart';
import 'package:etkinlik_kafasi/widgets/radial_painter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:etkinlik_kafasi/models/meta_data.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

class AdminUyeKullaniciProfili extends StatefulWidget {
  final Map<String, dynamic> card;

  AdminUyeKullaniciProfili({this.card});

  @override
  _AdminUyeKullaniciProfiliState createState() => _AdminUyeKullaniciProfiliState();
}

FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

class _AdminUyeKullaniciProfiliState extends State<AdminUyeKullaniciProfili> with SingleTickerProviderStateMixin {
  final picker = ImagePicker();
  File _profilFoto;
  TabController _tabController;

  int toplamEtkinlikSayim = 0;
  firebase_storage.FirebaseStorage storage;
  double leftmargin = 120.0.w;
  double topmargin = 40.0.w;
  List<String> kafalar_profil_icon_sayilari = [];
  List<String> kafalar_profil_iconlar = [];
  List<Map<String,String>> kafalar_map_list = [];
  List<Profil_kafalar> kafalar_list = [];
  List<String> kafalarim;
  static int toplamkatilma=1;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
    toplamkatilma =(widget.card['etkinlikKatildi']+widget.card['etkinlikKatilmadi']) == 0 ? 1 :(widget.card['etkinlikKatildi']+widget.card['etkinlikKatilmadi']) ;

    storage = firebase_storage.FirebaseStorage.instance;
    profil_iconlari_getir();
    kafalarim= widget.card["kafalar"] != null ? List<String>.from(widget.card["kafalar"]) : null;
  }

  Future<void> profil_iconlari_getir() async  {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).collection("profil_iconlar").get().then((value){
      for(QueryDocumentSnapshot item in value.docs){

        Map<String, String> Profil_icon_sayilari = Map();



        if(item.id=="lider"){

          Profil_icon_sayilari['title'] = "Lider";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Lider",icon: "assets/profil_icon/lider.png",sayi: item['sayi']));

        }else if(item.id=="cilgin"){

          Profil_icon_sayilari['title'] = "Çılgın";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Çılgın",icon: "assets/profil_icon/cilgin.png",sayi: item['sayi']));

        }else if(item.id=="adaletli"){

          Profil_icon_sayilari['title'] = "Adaletli";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Adaletli",icon: "assets/profil_icon/adalet.png",sayi: item['sayi']));

        }else if(item.id=="saygili"){

          Profil_icon_sayilari['title'] = "Saygılı";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Saygılı",icon: "assets/profil_icon/saygili.png",sayi: item['sayi']));


        }else if(item.id=="guvenilir"){
          Profil_icon_sayilari['title'] = "Güvenilir";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Güvenilir",icon: "assets/profil_icon/guvenilir.png",sayi: item['sayi']));

        }else if(item.id=="romantik"){
          Profil_icon_sayilari['title'] = "Romantik";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Romantik",icon: "assets/profil_icon/romantik.png",sayi: item['sayi']));

        }else if(item.id=="comert"){
          Profil_icon_sayilari['title'] = "Cömert";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Cömert",icon: "assets/profil_icon/comert.png",sayi: item['sayi']));

        }else if(item.id=="ek") {
          Profil_icon_sayilari['title'] = "EK";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "EK",icon: "assets/profil_icon/istekli.png" ,sayi: item['sayi']));

        }
        kafalar_profil_icon_sayilari.add(item['sayi'].toString());

      }
      setState(() {

      });

    });

    await FirebaseFirestore.instance.collection("users").doc(_userModel.user.userId).collection("profil_oy_attiklarim").doc(widget.card['userId']).get().then((value){
      print("value deger:"+value.data().toString());
      if(value.data() != null) {
        for (String item in value['kafalar']) {
          kafalar_profil_iconlar.add(item);
        }
      }

      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    bool albumilsLoading=false;

    final _userModel = Provider.of<UserModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Column(
          children: [
            AdminKarsiKullaniciInfoContainer(card: widget.card,),
            ProfilTabItems(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                  AdminKarsiProfilAbout(userid: _userModel.user.userId,kafalar_sayilar: kafalar_profil_icon_sayilari,kafalarlar: kafalar_profil_iconlar,kafalar_map_list_icon: kafalar_map_list,kafalar_profil: kafalar_list,card: widget.card,),


                  KarsiUserKafalarTab(kafalarim: kafalarim,),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.card['userId'])
                        .collection('etkinliklerim')
                        .orderBy('tarih', descending: true)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        print(snapshot.error);
                        return Center(
                            child: Text(
                              "Herhangi bir etkinlik yok!",
                              style: Theme.of(context).textTheme.caption,
                            ));
                      }
                      final int cardLength = snapshot.data.docs.length;
                      return cardLength == 0
                          ? Center(child: Text("Herhangi bir etkinlik yok!"))
                          : ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: cardLength,
                        itemBuilder: (_, int index) {
                          final DocumentSnapshot _cardetkinlikler = snapshot.data.docs[index];
                          return StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('etkinlik')
                                .doc(_cardetkinlikler['etid'].toString())
                                .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              print("data:" + cardLength.toString());

                              return cardLength == 0
                                  ? Text("Herhangi bir etkinlik yok!")
                                  : ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (_, int index) {
                                  final DocumentSnapshot _card = snapshot.data;
                                  return Column(
                                    children: [
                                      ProfilEtkinlikCard(
                                        etkinlikBilgileri: EtkinlikModel.fromMap(_card.data()),
                                        card: _card,
                                      ),
                                      SizedBox(
                                        height: 40.0.h,
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  ListView(
                    padding: EdgeInsets.all(0),
                    children: [

                      _buildYorumlarGrafikleri(),

                      SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProfilListTile(
                          title: "Etkinlik Katılım Oranı:",
                          icon: Icon(
                            Icons.supervisor_account,
                            size: 24.0.h,
                            color: Theme.of(context).accentColor,
                          ),
                          trailingTitle:"% "+( (widget.card['etkinlikKatildi']/toplamkatilma.toDouble())*100).toStringAsFixed(2) ?? "",
                        ),
                      ),
                      _buildYorumlar(),

                      SizedBox(height: 110,),
                    ],
                  ),

                  albumilsLoading ? Center(child: CircularProgressIndicator(),) :
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.card['userId'])
                            .collection('albumlerim')
                            .orderBy('tarih', descending: true)
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                                child: Text(
                                  "Herhangi bir albüm yok!",
                                  style: Theme.of(context).textTheme.caption,
                                ));
                          }

                          final int cardLength = snapshot.data.docs.length;

                          return GridView.builder(
                            padding: EdgeInsets.all(16.0.w),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cardLength,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 14.30.w,
                              mainAxisSpacing: 13.0.h,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              print("index :"+index.toString());
                              print("İMAGE GELEN 0 DEGERİ  :"+snapshot.data.docs[index]['imgarray'].toString());
                              return
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      albumilsLoading=true;
                                    });
                                    List<dynamic> imagelist = await snapshot.data.docs[index]['imgarray'];
                                    String imagelistId = await snapshot.data.docs[index].id;


                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => GaleriGrid(
                                      imageList: imagelist,
                                      galeriBaslik: snapshot.data.docs[index]['galeribaslik'],
                                      userid: _userModel.user.userId,
                                      imageListId: imagelistId,
                                      card: snapshot.data.docs[index],
                                      benimmi: false,
                                    )));


                                    setState(() {
                                      albumilsLoading=false;
                                    });


                                  },
                                  child:  snapshot.data.docs[index]['imgarray'].toString() == "[]" ? SizedBox(height: 100, width: 100) :
                                  Stack(children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: 150.0.h,
                                            width: 150.0.w,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage( snapshot.data.docs[index]['imgarray'][0].toString()),
                                                  alignment: Alignment.topCenter),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    child: Stack(
                                                      children: [
                                                        Opacity(
                                                          opacity: 0.65,
                                                          child: Container(
                                                            width: 75.0.w,
                                                            height: 60.0.h,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(6.70)),
                                                                color: Theme.of(context).backgroundColor),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 3),
                                                          child: Container(
                                                            width: 75.0.w,
                                                            height: 50.0.h,
                                                            child: Center(
                                                              child: Text(snapshot.data.docs[index]['galeribaslik'],
                                                                maxLines: 3,
                                                                style: TextStyle(
                                                                    color: const Color(0xff343633),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontFamily: "OpenSans",
                                                                    fontStyle: FontStyle.normal,
                                                                    fontSize: 12.7.spByWidth),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      alignment: Alignment.centerLeft,
                                                    ),
                                                    top: 12.30.h,
                                                    left: 13.30.w),
                                              ],
                                            ),

                                          ),),
                                      ],
                                    ),
                                  ],
                                  ),
                                );



                            },
                          );
                        },
                      ),
                      SizedBox(height: 100,),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> uploadAlbumImage(PickedFile pickedImage) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    String filePath = pickedImage.path;
    String userId = widget.card['userId'];
    String fileName = "${userId}-${DateTime.now()}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(userId+'/usersAlbum/$fileName').putFile(file);
      String downloadURL = await firebase_storage.FirebaseStorage.instance.ref(userId+'/usersAlbum/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () async {
                        var pickedImage = await imgFromGallery(picker);
                        Navigator.pop(context);
                        var downloadUrl = await uploadAlbumImage(pickedImage);
                        var uid = FirebaseAuth.instance.currentUser.uid;
                        var userAlbumPath = "users/$uid/albumlerim";
                        await FirebaseFirestore.instance.collection(userAlbumPath).add({"img": downloadUrl});


                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () async {
                      var pickedImage = await imgFromCamera(picker);
                      Navigator.pop(context);
                      var downloadUrl = await uploadAlbumImage(pickedImage);
                      var uid = FirebaseAuth.instance.currentUser.uid;
                      var userAlbumPath = "users/$uid/albumlerim";
                      await FirebaseFirestore.instance.collection(userAlbumPath).add({"img": downloadUrl});

                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildYorumlarGrafikleri() {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final int cardLength = 1;

        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cardLength,
          itemBuilder: (_, int index) {
            final DocumentSnapshot _card = snapshot.data;
            int iyi = _card['yorumiyi'].toInt();
            int orta = _card['yorumorta'].toInt();
            int kotu = _card['yorumkotu'].toInt();
            int toplam = (iyi + orta + kotu) == 0 ? 0 : (iyi + orta + kotu);

            double iyiort = (iyi / toplam);

            print("toplam:" + toplam.toString());
            print("iyi:" + iyi.toString());
            print("orta:" + orta.toString());
            print("kotu:" + kotu.toString());
            print("iyiort:" + iyiort.toString());

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
                          percent: iyiort.isNaN ? 0 : iyiort,
                          width: 5.0),
                      child: Center(
                        child: Text(
                          toplam != 0 ? '%' + (iyiort * 100).ceil().toString() : "%0",
                          style: TextStyle(
                            fontSize: 13.70.h,
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
                          height: 20.0.h,
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
                                        fontSize: 11.7.h),
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                child: SliderTheme(
                                    data: SliderThemeData(
                                      disabledActiveTrackColor: Color(0xff00af54),
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                                      trackHeight: 7.0.h,
                                      trackShape: CustomTrackShape(),
                                    ),
                                    child: Slider(
                                      value: toplam != 0 ? iyi.toDouble() : 0,
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
                                        fontSize: 11.7.h),
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                child: SliderTheme(
                                    data: SliderThemeData(
                                      disabledActiveTrackColor: Color(0xfff7cb15),
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                                      trackShape: CustomTrackShape(),
                                      trackHeight: 7.0.h,
                                    ),
                                    child: Slider(
                                      value: orta.toDouble(),
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
                                        fontSize: 11.7.h),
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                child: SliderTheme(
                                    data: SliderThemeData(
                                      disabledActiveTrackColor: Color(0xfff21b3f),
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                                      trackShape: CustomTrackShape(),
                                      trackHeight: 7.0.h,
                                    ),
                                    child: Slider(
                                      value: kotu.toDouble(),
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
                          child: Text(toplam.toString() + " Oy",
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0.spByWidth),
                              textAlign: TextAlign.right),
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("İyi:    ",style: TextStyle(fontSize: 16),),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // background
                                onPrimary: Colors.white, //// foreground
                              ),
                              onPressed: () {

                                FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).update({'yorumiyi':FieldValue.increment(1)});
                              },
                              child: Text('+'),
                            ),
                            SizedBox(width: 30.0.w,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // background
                                onPrimary: Colors.white, //// foreground
                              ),
                              onPressed: () {

                                _card['yorumiyi'].toInt() < 1 ?

                                Fluttertoast.showToast(
                                  msg: "Oy eksiye düşemez!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                ) :
                                FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).update({'yorumiyi':FieldValue.increment(-1)});

                              },
                              child: Text('-'),
                            ),
                          ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Orta:",style: TextStyle(fontSize: 16),),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // background
                                onPrimary: Colors.white, //// foreground
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).update({'yorumorta':FieldValue.increment(1)});

                              },
                              child: Text('+'),
                            ),
                            SizedBox(width: 30.0.w,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // background
                                onPrimary: Colors.white, //// foreground
                              ),
                              onPressed: () {

                                _card['yorumorta'].toInt() < 1 ?

                                Fluttertoast.showToast(
                                  msg: "Oy eksiye düşemez!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                ) :
                                FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).update({'yorumorta':FieldValue.increment(-1)});

                              },
                              child: Text('-'),
                            ),
                          ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Kötü:",style: TextStyle(fontSize: 16),),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // background
                                onPrimary: Colors.white, //// foreground
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).update({'yorumkotu':FieldValue.increment(1)});

                              },
                              child: Text('+'),
                            ),
                            SizedBox(width: 30.0.w,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // background
                                onPrimary: Colors.white, //// foreground
                              ),
                              onPressed: () {


                                _card['yorumkotu'].toInt() < 1 ?

                                Fluttertoast.showToast(
                                  msg: "Oy eksiye düşemez!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                ) :
                                FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).update({'yorumkotu':FieldValue.increment(-1)});

                              },
                              child: Text('-'),
                            ),
                          ],),




                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildYorumlar() {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream:
      FirebaseFirestore.instance.collection("users").doc(widget.card['userId']).collection("yorumlar").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final int cardLength = snapshot.data.docs.length;

        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cardLength,
          itemBuilder: (_, int index) {
            final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid']).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                String assets = "";
                final String notrActive = "assets/notr_active.png";
                final String olumluActive = "assets/olumlu_active.png";
                final String olumsuzActive = "assets/olumsuz_active.png";

                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot _card = snapshot.data;

                    if (_cardYonetici['yorumdeger'].toString() == 'olumsuz') {
                      assets = olumsuzActive;
                    } else if (_cardYonetici['yorumdeger'].toString() == 'notr') {
                      assets = notrActive;
                    } else {
                      assets = olumluActive;
                    }
                    final gun = _cardYonetici['tarih'].toDate();
                    final bugun = DateTime.now();
                    final difference = bugun.difference(gun).inDays;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0.w),
                            title: Text(_card['ad'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.3.spByWidth),
                                textAlign: TextAlign.left),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(_card['avatarImageUrl'].toString()),
                              radius: 20.0.h,
                            ),

                            trailing: Text(difference.toString() + " gün önce",
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.0.spByWidth),
                                textAlign: TextAlign.right),
                          ),
                          Text(
                            _cardYonetici['yorum'] != null ? _cardYonetici['yorum'].toString() : "",
                            style: const TextStyle(
                                color: const Color(0xff343633),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 13.3),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _kafalarTab() {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      padding: EdgeInsets.fromLTRB(23.0.w, 23.0.h, 23.0.w, 100.0.h),
      mainAxisSpacing: 8.0.h,
      crossAxisSpacing: 18.0.w,
      children: List.generate(35, (index) {
        var seletectedColor = _userModel.user.kafalar.contains(kafalar[index]["title"].replaceAll("\n", " "))
            ? Renkler.onayButonColor
            : Colors.white;

        return GestureDetector(
          onTap: () {
            var kafaTitle = kafalar[index]["title"].replaceAll("\n", " ");
            if (_userModel.user.kafalar.contains(kafaTitle)) {
              _userModel.user.kafalar.remove(kafaTitle);
            } else {
              _userModel.user.kafalar.add(kafaTitle);
            }

            _firestoreDBService.usersKafaEkle(_userModel.user.kafalar, _userModel.user.userId).then((value) {
              setState(() {
                print("seçilen kafa eklendi");
              });
            });
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
                    width: 50.0.w,
                    height: 50.0.w,
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
                        fontSize: 11.3.spByWidth),
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
/*
  void _kameradanFotoCek() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
    var downloadUrl = await uploadEtkinlikImage();
    _firestoreDBService.updateProfilFoto(_userModel.user.userId, downloadUrl);
    _userModel.user.avatarImageUrl = downloadUrl;
  }

  void _galeridenResimSec() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
    var downloadUrl = await uploadEtkinlikImage();
    _firestoreDBService.updateProfilFoto(_userModel.user.userId, downloadUrl);
    _userModel.user.avatarImageUrl = downloadUrl;
  }

 */

  Future<String> uploadEtkinlikImage() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_profilFoto == null) return "";
    String filePath = _profilFoto.path;
    String userId = _userModel.user.userId;
    String fileName = "${userId}-profil.text-${DateTime.now()}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('etkinlikfotolari/$fileName').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('etkinlikfotolari/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
