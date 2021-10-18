import 'package:etkinlik_kafasi/ChattApp/alluserModel.dart';
import 'package:etkinlik_kafasi/landingPage.dart';
import 'package:etkinlik_kafasi/locator.dart';
import 'package:etkinlik_kafasi/models/users.dart';
import 'package:etkinlik_kafasi/service/user_state_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserModel()),
      ChangeNotifierProvider(create: (_) => Users()),
      ChangeNotifierProvider(create: (_) => AllUserViewModel()),
    ],
    child: MyApp(),
  ));
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etkinlik Kafası',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: const Color(0xff8b1afe),
        accentColor: const Color(0xffffd400),
        backgroundColor: const Color(0xffffffff),
        buttonColor: const Color(0xff3ecf8e),
        canvasColor: const Color(0xffffffff),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        sliderTheme: SliderThemeData(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
          disabledActiveTrackColor: Colors.red[700],
        ),
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 18.0,
            color: const Color(0xff8b1afe),
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
          headline1: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 20.0, fontFamily: "OpenSans"),
          caption: TextStyle(color: const Color(0xff343633), fontSize: 20.0, fontFamily: "OpenSans"),
        ),
        iconTheme: IconThemeData(
          color: const Color(0xff8b1afe),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr', "TR"),
      ],
      locale: const Locale('tr', "TR"),
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: initialSetup(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/logo.jpeg'),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white
                ),
              ));
            }
            return LandingPage();
          }
      ),
    );
  }

  Future<bool> initialSetup() async {
    await Firebase.initializeApp();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return true;
  }
}
