import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/helpers.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/etkinlik_model.dart';
import 'package:etkinlik_kafasi/models/profil_kafalar.dart';
import 'package:etkinlik_kafasi/profilSayfalari/profilgalerigrid.dart';
import 'package:etkinlik_kafasi/profilim/about.dart';
import 'package:etkinlik_kafasi/profilim/kafalar.dart';
import 'package:etkinlik_kafasi/profilim/profil_listTitle.dart';
import 'package:etkinlik_kafasi/profilim/profildetay/userprofilimCard.dart';
import 'package:etkinlik_kafasi/profilim/profile_top_container.dart';
import 'package:etkinlik_kafasi/profilim/profilfotofull.dart';
import 'package:etkinlik_kafasi/profilim/tab_bar_row.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/album_ekleme_alert.dart';
import 'package:etkinlik_kafasi/widgets/photoviewgallery.dart';
import 'package:etkinlik_kafasi/widgets/radial_painter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

class Profilim extends StatefulWidget {
  final Map<String, dynamic> card;

  Profilim({this.card});

  @override
  _ProfilimState createState() => _ProfilimState();
}

FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
List<Profil_kafalar> kafalar_list = [];
List<String> kafalar_profil_iconlar = [];
List<String> albumlist = [];
bool albumilsLoading = false;

class _ProfilimState extends State<Profilim> with SingleTickerProviderStateMixin {
  final picker = ImagePicker();
  File _profilFoto;
  TabController _tabController;
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  int toplamEtkinlikSayim = 0;
  firebase_storage.FirebaseStorage storage;
  double leftmargin = 120.0.w;
  double topmargin = 40.0.w;
  List<String> kafalar_profil_icon_sayilari = [];
  List<Map<String, String>> kafalar_map_list = [];
  static int toplamkatilma = 1;

  Stream<QuerySnapshot> photoStream;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);

    storage = firebase_storage.FirebaseStorage.instance;
    profil_iconlari_getir();
    takipvetakipcigetir();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    photoStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_userModel.user.userId)
        .collection('albumlerim')
        .orderBy('tarih', descending: true)
        .snapshots();
  }

  Future<void> takipvetakipcigetir() async {
    print("takipci sayısı çalıştı");
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await FirebaseFirestore.instance.collection("users").doc(_userModel.user.userId).get().then((value) {
      _userModel.user.takip = value['takip'];
      _userModel.user.takipci = value['takipci'];
    });
    print("takipci sayısı:" + _userModel.user.takipci.toString());
  }

  Future<void> profil_iconlari_getir() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_userModel.user.userId)
        .collection("profil_iconlar")
        .get()
        .then((value) {
      for (QueryDocumentSnapshot item in value.docs) {
        Map<String, String> Profil_icon_sayilari = Map();

        if (item.id == "lider") {
          Profil_icon_sayilari['title'] = "Lider";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Lider", icon: "assets/profil_icon/lider.png", sayi: item['sayi']));
        } else if (item.id == "cilgin") {
          Profil_icon_sayilari['title'] = "Çılgın";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Çılgın", icon: "assets/profil_icon/cilgin.png", sayi: item['sayi']));
        } else if (item.id == "adaletli") {
          Profil_icon_sayilari['title'] = "Adaletli";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Adaletli", icon: "assets/profil_icon/adalet.png", sayi: item['sayi']));
        } else if (item.id == "saygili") {
          Profil_icon_sayilari['title'] = "Saygılı";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Saygılı", icon: "assets/profil_icon/saygili.png", sayi: item['sayi']));
        } else if (item.id == "guvenilir") {
          Profil_icon_sayilari['title'] = "Güvenilir";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list
              .add(Profil_kafalar(name: "Güvenilir", icon: "assets/profil_icon/guvenilir.png", sayi: item['sayi']));
        } else if (item.id == "romantik") {
          Profil_icon_sayilari['title'] = "Romantik";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list
              .add(Profil_kafalar(name: "Romantik", icon: "assets/profil_icon/romantik.png", sayi: item['sayi']));
        } else if (item.id == "comert") {
          Profil_icon_sayilari['title'] = "Cömert";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "Cömert", icon: "assets/profil_icon/comert.png", sayi: item['sayi']));
        } else if (item.id == "ek") {
          Profil_icon_sayilari['title'] = "EK";
          Profil_icon_sayilari['sayi'] = item['sayi'].toString();
          kafalar_map_list.add(Profil_icon_sayilari);

          kafalar_list.add(Profil_kafalar(name: "EK", icon: "assets/profil_icon/istekli.png", sayi: item['sayi']));
        }
        kafalar_profil_icon_sayilari.add(item['sayi'].toString());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    toplamkatilma = (_userModel.user.etkinlikKatilma + _userModel.user.etkinlikKatilmama) == 0
        ? 1
        : (_userModel.user.etkinlikKatilma + _userModel.user.etkinlikKatilmama);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Profilim",
            style: TextStyle(
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 20.0.spByWidth),
            textAlign: TextAlign.center),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            ProfilInfoContainer(),
            ProfilTabItems(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  About(
                    kafalar_sayilar: kafalar_profil_icon_sayilari,
                    kafalarlar: kafalar_profil_iconlar,
                    kafalar_map_list_icon: kafalar_map_list,
                    kafalar_profil: kafalar_list,
                  ),
                  KafalarTab(onTap: () {
                    _firestoreDBService.usersKafaEkle(_userModel.user.kafalar, _userModel.user.userId).then((value) {
                      setState(() {});
                    });
                  }),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(_userModel.user.userId)
                        .collection('etkinliklerim')
                        .orderBy('tarih', descending: true)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      print("Etkinliklerim");

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
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

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
                                                  if (_card.exists)
                                                    UserProfilimEtkinlikCard(
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
                      _buildYorumlar(),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: ProfilListTile(
                          title: "Etkinlik Katılım Oranı:",
                          icon: Icon(
                            Icons.supervisor_account,
                            size: 24.0.h,
                            color: Theme.of(context).accentColor,
                          ),
                          trailingTitle: "% " +
                                  ((_userModel.user.etkinlikKatilma / toplamkatilma.toDouble()) * 100)
                                      .toStringAsFixed(2) ??
                              "",
                        ),
                      ),
                      SizedBox(
                        height: 110.0.h,
                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: photoStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("Data");
                          print("itemCout ${snapshot.data.docs.length}");
                          var photoCollectionCount = snapshot.data.docs.length;
                          return GridView.builder(
                              itemCount: photoCollectionCount + 1,
                              padding: EdgeInsets.all(16.0.w),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 14.30.w,
                                mainAxisSpacing: 13.0.h,
                              ),
                              itemBuilder: (context, index) {
                                if (index > 0) {
                                  return GestureDetector(
                                    onTap: () async {
                                      List<dynamic> imagelist = await snapshot.data.docs[index - 1]['imgarray'];
                                      String imagelistId = await snapshot.data.docs[index - 1].id;
                                      print(imagelist);

                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) => GaleriGrid(
                                                imageList: imagelist,
                                                galeriBaslik: snapshot.data.docs[index - 1]['galeribaslik'],
                                                userid: _userModel.user.userId,
                                                imageListId: imagelistId,
                                                card: snapshot.data.docs[index - 1],
                                                benimmi: true,
                                              )));
                                    },
                                    child: Stack(
                                      children: [
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
                                                      image: CachedNetworkImageProvider(
                                                          snapshot.data.docs[index - 1]['imgarray'][0].toString()),
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
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(6.70)),
                                                                    color: Theme.of(context).backgroundColor),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 3),
                                                              child: Container(
                                                                width: 75.0.w,
                                                                height: 50.0.h,
                                                                child: Center(
                                                                  child: Text(
                                                                    snapshot.data.docs[index - 1]['galeribaslik'],
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
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () async {
                                    // loadAssets();
                                    var dialog = AlbumEkleTextField(
                                      title: "Albüm Ekle",
                                    );
                                    await showDialog(context: context, builder: (BuildContext context) => dialog);
                                  },
                                  child: Container(
                                    color: Theme.of(context).primaryColor,
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 40.0.w,
                                      color: Colors.white,
                                    )),
                                  ),
                                );
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      })
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
    String userId = _userModel.user.userId;
    String fileName = "${userId}-${DateTime.now()}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$fileName').putFile(file);
      String downloadURL =
          await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  Future<String> uploadAlbumImageFile(File pickedImage, String index) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    String filePath = pickedImage.path;
    String userId = _userModel.user.userId;
    String fileName = "${userId}-${DateTime.now()}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(userId + '/usersAlbum/etkinlik_adi/$index').putFile(file);
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(userId + '/usersAlbum/etkinlik_adi/$index')
          .getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "albüm"),
        materialOptions: MaterialOptions(
          allViewTitle: "Bütün Fotoğraflar",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    int index = 0;
    for (var snap in resultList) {
      File resim = await getImageFileFromAssets(snap);
      String resimyolu = await uploadAlbumImageFile(resim, index.toString());
      albumlist.add(resimyolu);
      index++;
    }
    final _userModel = Provider.of<UserModel>(context, listen: false);
    Map<String, dynamic> album = Map();
    album['imgarray'] = albumlist;
    album['galeribaslik'] = "deneme";
    FirebaseFirestore.instance
        .collection("users")
        .doc(_userModel.user.userId)
        .collection("albumlerim")
        .doc()
        .set(album);
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile = File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
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
      stream: FirebaseFirestore.instance.collection("users").doc(_userModel.user.userId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
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

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  Container(
                    width: 50.0.w,
                    height: 50.0.h,
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
                                      max: toplam.toDouble(),
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
                                      max: toplam.toDouble(),
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
                                      max: toplam.toDouble(),
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
                        )
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
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel.user.userId)
          .collection("yorumlar")
          // .where("userid", whereNotIn: _userModel.user.blockedUsers.map((e) => e.userId).toList())
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final int cardLength = snapshot.data.docs.length;
        var blockIds = _userModel.user.blockedUsers.map((e) => e.userId).toList();
        var list = snapshot.data.docs
            .where((e) => !blockIds.contains(e.get("userid"))).toList();
        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (_, int index) {
            final DocumentSnapshot _cardYonetici = list[index];
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(_cardYonetici['userid']).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
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
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.45,
                      child: Container(
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
                              style: TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      secondaryActions: <Widget>[
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20.70)),
                          ),
                          child: IconSlideAction(
                              caption: 'Sil',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                print("object:" + _cardYonetici.reference.path);
                                _cardYonetici.reference.delete();
                              }),
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
    );
  }

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
