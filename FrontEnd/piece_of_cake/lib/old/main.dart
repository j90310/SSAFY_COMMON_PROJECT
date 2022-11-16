import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Flexible(flex: 3, child: Image.asset('assets/images/harry.png', width: 150)),
          Flexible(flex: 7,child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('강아지 자랑해요',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  Text('거제1동', style: TextStyle(fontSize: 15),),
                  Text('개예쁜 말티즈예요', style: TextStyle(fontSize: 20)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite),
                        Text('4'),
                      ]
                  )
                ],
              )
          ),
          )
        ],
      ),
    );
  }
}


class MeApp extends StatelessWidget {
  const MeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar( title: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    label: Icon(Icons.search)
                )
            ), actions: [Icon(Icons.menu), Icon(Icons.notifications) ]),
            body: ListView(
              children: [
                Item(),
                Item(),
                Item(),
              ],

            )
        )
    );
  }
}
// return MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('앱임')),
//       body: Text('해위'),
//       bottomNavigationBar: BottomAppBar(
//         child: SizedBox(
//           height: 70,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Icon(Icons.phone),
//               Icon(Icons.message),
//               Icon(Icons.contact_page),
//             ],
//           ),
//         ),
//       ),
//     )
// );
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar( title: Text('앱임')),
//         body: Container(
//           width: 150, height: 50,
//           margin: EdgeInsets.fromLTRB(40, 30, 50, 60),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//         ),
//       )
//     );
//

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'CongNamul',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size:30),
      Icon(Icons.celebration, size:30),
      Icon(Icons.add, size:30),
      Icon(Icons.question_answer, size:30),
      Icon(Icons.person, size:30),

    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: const Text('Piece Of Cake'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: const Center(
                  child: TextField(
                      decoration: InputDecoration(
                        hintText: '파티검색',
                        prefixIcon: Icon(Icons.search),)
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Item(),
              Item(),
              Item(),
              Item(),
              Item(),
            ]),
          ),
        ],

      ),
      // bottomNavigationBar: BottomAppBar(
      //
      //   color: Colors.amber,
      //   shape: const CircularNotchedRectangle(),
      //   child: Container(height: 60),
      // ),
      //
      //
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //   }),
      //   tooltip: 'Increment Counter',
      //   child: const Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.amber,
        // onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}




