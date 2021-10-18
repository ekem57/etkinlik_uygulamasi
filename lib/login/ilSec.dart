import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';
import '../extensions/color_data.dart';
class CitySearch extends SearchDelegate<String>{

  @override
  String get searchFieldLabel => "Şehir Ara";

  final List<String> cities;
  String result;

  CitySearch(this.cities);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Theme.of(context).primaryColor),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).primaryColor),
      onPressed: () {
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = cities.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.pop(context,suggestions.elementAt(index));
              },
              title: Text(suggestions.elementAt(index)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = cities.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.pop(context,suggestions.elementAt(index));
              },
              title: Text(suggestions.elementAt(index),),
            ),
          ),
        );
      },
    );
  }
}



class IlSec extends StatefulWidget {
  @override
  IlSecState createState() => new IlSecState();
}
class UserBloc extends Bloc {
  final userController = StreamController<List>.broadcast();


  @override
  void dispose() {
    // TODO: implement dispose
    userController.close();
  }
}
abstract class Bloc {
  void dispose();
}

UserBloc userBloc = UserBloc();
class IlSecState extends State<IlSec> {
  List totalUsers = [];
  List data;
  String secilenbolum;

  void _searchUser(String searchQuery) {
    List searchResult = [];
    userBloc.userController.sink.add(null);
    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(totalUsers);
      return;
    }
    totalUsers.forEach((user) {
      if (user.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(user);
      }
    });
    print('searched users length = ${searchResult.length}'); //
    userBloc.userController.sink.add(searchResult);
  }

  Widget usersWidget() {

    return StreamBuilder(

        stream: userBloc.userController.stream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List> snapshot) {
          if (snapshot.data == null) {
            print("geldi");
            return Container(
              child: Center(
                child: FutureBuilder(
                  future:
                  DefaultAssetBundle.of(context).loadString('datalar/il.json'),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    var myData = json.decode(snapshot.data);
                    totalUsers.clear();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {

                        totalUsers.add(myData[0]['Iller'][index]);
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                          margin:  EdgeInsets.only(bottom:8.0.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11.0),
                              ),
                              primary: Renkler.appbarTextColor,
                              minimumSize: Size.fromHeight(45.0.h),
                            ),
                            onPressed: (){
                              secilenbolum = myData[0]['Iller'][index].toString();
                              Navigator.pop(context, secilenbolum);
                              setState(() {

                              });
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                myData[0]['Iller'][index].toString(),
                                style: TextStyle(
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0.spByWidth,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        );

                      },
                      itemCount: myData == null ? 0 : myData[0]['Iller'].length,
                    );
                  },
                ),
              ),
            );
          }
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : _randomUsers(snapshot: snapshot);
        });
  }

  Widget _randomUsers({AsyncSnapshot<List> snapshot}) {
    return    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          margin:  EdgeInsets.only(bottom:8.0.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              primary: Renkler.appbarTextColor,
              minimumSize: Size.fromHeight(45.0.h),
            ),
            onPressed: (){
              secilenbolum =  snapshot.data[index].toString();

              Navigator.pop(context, secilenbolum);
              setState(() {

              });
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                snapshot.data[index].toString(),
                style: TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0.spByWidth
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        );

      },
      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text("İller",
            style: TextStyle(
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 20.0.spByWidth),
            textAlign: TextAlign.center),
        brightness: Brightness.light,
        leading: IconButton(
          icon: Icon(Icons.close,size: 30),
          onPressed: (){
            Navigator.pop(context, "İl");
          },
        ),
      ),

      body: ListView(

        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(top: 20.0.h),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Theme(
                data: new ThemeData(
                  primaryColor: Colors.black,
                  primaryColorDark: Colors.black,
                ),
                child: TextField(

                  onChanged: (text) => _searchUser(text),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'İller',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.h),
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ),
          ),
          usersWidget(),

        ],
      ),
    );
  }
}