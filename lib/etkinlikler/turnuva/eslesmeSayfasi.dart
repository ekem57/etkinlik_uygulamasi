import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_kafasi/Firebase/firebase_database.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:etkinlik_kafasi/widgets/AlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EslesmeSayfasi extends StatefulWidget {
  final DocumentSnapshot card;

  EslesmeSayfasi({this.card});
  @override
  _EslesmeSayfasiState createState() => _EslesmeSayfasiState();
}
FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
class _EslesmeSayfasiState extends State<EslesmeSayfasi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("gelen card:"+widget.card.data().toString());
  }
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    bool varmi=false;
    return Scaffold(
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
        title: Text("Eşleşmeler",
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
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("etkinlik").doc(widget.card.id).collection("katilimcilar").orderBy('index', descending: false).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {

                if (!snapshot.hasData) return Container();

                final int cardLength = snapshot.data.docs.length;
                //ikiside tam ise gelen
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cardLength+1,
                  itemBuilder: (_, int index) {

                    print("index:"+index.toString());
                    print("cardlength:"+cardLength.toString());
                    print("max grup sayısı:"+(widget.card['maxkatilimcisayisi'] / 2).floor().toString());
                    if(index != cardLength){
                      if(_userModel.user.userId==snapshot.data.docs[index]['userid1'].toString()){
                        varmi=true;
                      }
                      if(_userModel.user.userId==snapshot.data.docs[index]['userid2'].toString()){
                        varmi=true;
                      }
                    }

                  return index == cardLength ?
                  (widget.card['maxkatilimcisayisi'] / 2).floor()+1 != cardLength ?
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 110.0.h,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: (){
                                var dialog = CustomAlertDialog(
                                    message: "Bu eşleşmeye dahil olmak istediğinize emin misiniz?",
                                    onPostivePressed: () {
                                      if(varmi==false){
                                        _firestoreDBService.eslestirKimseyok(_userModel.user.userId, widget.card['etid'],_userModel.user.avatarImageUrl,_userModel.user.adsoyad,cardLength);

                                      }else{

                                        Fluttertoast.showToast(
                                          msg: "Bu Turnuvada Eşleşmiş Durumdasınız!",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.orange,
                                        );

                                      }

                                      Navigator.pop(context);
                                    },
                                    onNegativePressed: (){},
                                    positiveBtnText: 'Evet',
                                    negativeBtnText: 'İptal');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => dialog);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.w,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ),
                            Container(
                              width: 38.0.w,
                              height: 38.0.w,
                              decoration: new BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,

                              ),
                              child: Center(
                                child: Text(
                                  "VS",
                                  style: const TextStyle(
                                      color:  const Color(0xff343633),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 16.0
                                  ),

                                ),
                              ),
                            ),

                            GestureDetector(
                               onTap: (){
                                var dialog = CustomAlertDialog(
                                    message: "Bu eşleşmeye dahil olmak istediğinize emin misiniz?",
                                     onPostivePressed: () {
                                       if(varmi==false){
                                         _firestoreDBService.eslestirKimseyok(_userModel.user.userId, widget.card['etid'],_userModel.user.avatarImageUrl,_userModel.user.adsoyad,cardLength);

                                       }else{

                                         Fluttertoast.showToast(
                                           msg: "Bu Turnuvada Eşleşmiş Durumdasınız!",
                                           toastLength: Toast.LENGTH_LONG,
                                           gravity: ToastGravity.CENTER,
                                           textColor: Colors.white,
                                           backgroundColor: Colors.orange,
                                         );

                                       }

                                      Navigator.pop(context);
                                    },
                                    onNegativePressed: (){},
                                    positiveBtnText: 'Evet',
                                    negativeBtnText: 'İptal');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => dialog);
                              },
                              child: Container(
                                width: 67.66666666666667.w,
                                height: 68.0.w,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff91c4f2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ) :
                  Container() :
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 110.0.h,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 67.66666666666667.w,
                                      height: 68.0.w,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data.docs[index]['user1foto'].toString()),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(snapshot.data.docs[index]['user1ad'].toString(),
                                        style:  TextStyle(
                                            color:  const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13.3.spByWidth
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 38.0.w,
                                height: 38.0.w,
                                decoration: new BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,

                                ),
                                child: Center(
                                  child: Text(
                                    "VS",
                                    style:  TextStyle(
                                        color:  const Color(0xff343633),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 16.0.spByWidth
                                    ),

                                  ),
                                ),
                              ),
                              snapshot.data.docs[index]['user2foto'] != null ?
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 67.66666666666667.w,
                                      height: 68.0.w,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data.docs[index]['user2foto'].toString()),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(snapshot.data.docs[index]['user2ad'].toString(),
                                        style:  TextStyle(
                                            color:  const Color(0xff343633),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13.3.spByWidth
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : GestureDetector(
                                onTap: (){
                                  var dialog = CustomAlertDialog(
                                      message: "Bu eşleşmeye dahil olmak istediğinize emin misiniz?",
                                      onPostivePressed: () {
                                        if(varmi==false){
                                          _firestoreDBService.eslestirIkinciKisi(_userModel.user.userId, widget.card['etid'],_userModel.user.avatarImageUrl,_userModel.user.adsoyad,snapshot.data.docs[index].id,index);

                                        }else{

                                          Fluttertoast.showToast(
                                            msg: "Bu Turnuvada Eşleşmiş Durumdasınız!",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.orange,
                                          );

                                        }
                                        Navigator.pop(context);
                                      },
                                      onNegativePressed: (){

                                      },
                                      positiveBtnText: 'Evet',
                                      negativeBtnText: 'İptal');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => dialog);
                                },
                                child: Container(
                                  width: 67.66666666666667.w,
                                  height: 68.0.h,
                                  decoration: new BoxDecoration(
                                    color: const Color(0xff91c4f2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.add,size: 32.0.w,color: Colors.black,),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );

              }),

        ],
      ),
    );
  }
}
