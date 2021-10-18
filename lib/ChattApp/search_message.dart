import 'package:etkinlik_kafasi/ChattApp/sohbetPage.dart';
import 'package:etkinlik_kafasi/models/konusma.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_view_model.dart';

class SearchMessage extends SearchDelegate<String>{
  @override
  String get searchFieldLabel => "Mesajlarda Ara";

  SearchMessage(this.konusmalar,this.otherUsers);

  final List<Konusma> konusmalar;
  List<Users> otherUsers = [];
  String result;

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
    final suggestions = konusmalar.where((konusma) {
      return konusma.name.toLowerCase().contains(query.toLowerCase());
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
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => ChatViewModel(currentUser: context.read<UserModel>().user, sohbetEdilenUser: otherUsers[index]),
                    child: SohbetPage(
                      fotourl: otherUsers[index].avatarImageUrl,
                      userad: otherUsers[index].adsoyad,
                      userid: otherUsers[index].userId,
                    ),
                  ),
                ));
              },
              title: Text(suggestions.elementAt(index).name),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = konusmalar.where((konusma) {
      return konusma.name.toLowerCase().contains(query.toLowerCase());
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
                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => ChatViewModel(currentUser: context.read<UserModel>().user, sohbetEdilenUser: otherUsers[index]),
                    child: SohbetPage(
                      fotourl: otherUsers[index].avatarImageUrl,
                      userad: otherUsers[index].adsoyad,
                      userid: otherUsers[index].userId,
                    ),
                  ),
                ));
              },
              title: Text(suggestions.elementAt(index).name,),
            ),
          ),
        );
      },
    );
  }

}