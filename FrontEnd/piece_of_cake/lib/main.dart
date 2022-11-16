import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:piece_of_cake/kakao_login_page.dart';
import 'package:provider/provider.dart';
import 'chat/chatroom_my_route.dart';
import 'models/kakao_login_model.dart';
import 'models/party_model.dart';
import 'models/palette.dart';
import 'user/my.dart';
import 'party/pie/pie_create.dart';
import './home.dart';
import 'party/dlv/dlv_create.dart';
import 'party/buy/buy_create.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:piece_of_cake/party/bookmark/bookmark_list.dart';
import 'party/bookmark/bookmark_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  KakaoSdk.init(nativeAppKey: '2157d1da3704b84b219793633746ca5c');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => KakaoLoginModel()),
          ChangeNotifierProvider(create: (_) => PartyModel()),
          ChangeNotifierProvider(create: (_) => Palette()),
        ],
        child: MyApp(),
      )
  );}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var palette = Provider.of<Palette>(context);
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Piece Of Cake',
        theme: ThemeData(
          // fontFamily: 'Noto_Sans_KR',
          primarySwatch: palette.createMaterialColor(Color(0xffffffff)),
          // primarySwatch: palette.createMaterialColor(Color(0xffC4DCBF)),
          // canvasColor: palette.createMaterialColor(Color(0xffFFFBE4)),
        ),
        home: const KakaoLoginPage()
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 0;
  final screens = [
    HomePage(),
    BookmarkList(),
    ChatRoomListMy(),
    My(),
  ];

  @override
  Widget build(BuildContext context) {
    var palette = Provider.of<Palette>(context);
    final items = <Widget>[
      const Icon(
        Icons.home,
        size:24,
        color: Colors.white,
      ),
      const Icon(
        Icons.celebration,
        size:24,
        color: Colors.white,
      ),
      const Icon(
        Icons.question_answer,
        size:24,
        color: Colors.white,
      ),
      const Icon(
        Icons.person,
        size:24,
        color: Colors.white,
      ),

    ];

    return Scaffold(
      body: screens[index],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        key: navigationKey,
        backgroundColor: Colors.transparent,
        // color: Colors.amber,
        color: palette.createMaterialColor(Color(0xff8581E1)),
        height: 50,
        onTap: (index) => setState(() => this.index = index),
      ),
      floatingActionButton: SpeedDial(
        buttonSize: Size(40.0, 40.0),
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 10,
        overlayOpacity: 0.7,
        curve: Curves.bounceIn,
        // backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        backgroundColor: palette.createMaterialColor(Color(0xffD1ADE6)),
        // activeBackgroundColor: Colors.redAccent,
        activeForegroundColor: Colors.white,
        activeBackgroundColor: palette.createMaterialColor(Color(0xffFF9EB1)),
        elevation: 6.0,
        children: [
          SpeedDialChild(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DlvCreate()),
              );
            },
            child: Icon(Icons.delivery_dining, size: 25,),
            label: '배달',
            labelStyle: TextStyle(fontSize: 15),
            backgroundColor: palette.createMaterialColor(Color(0xffCCF5FC)),
          ),
          SpeedDialChild(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyCreate()),
                );
              },
            child: Icon(Icons.shopping_bag, size: 25,),
            label: '공구',
            labelStyle: TextStyle(fontSize: 15),
            backgroundColor: palette.createMaterialColor(Color(0xffEAF6BD)),
          ),
          SpeedDialChild(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PieCreate()),
                );
              },
            child: Icon(Icons.safety_divider, size: 25,),
            label: '소분',
            labelStyle: TextStyle(fontSize: 15),
            backgroundColor: palette.createMaterialColor(Color(0xffFFF3DA)),
          ),
        ],
      ),

    );
  }
}




