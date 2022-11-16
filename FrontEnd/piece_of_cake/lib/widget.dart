// import 'package:flutter/material.dart';
// import 'package:like_button/like_button.dart';
//
// import 'package:piece_of_cake/party/pie/pie_detail_guest.dart';
// import 'package:piece_of_cake/party/buy/buy_detail_guest.dart';
// import 'package:piece_of_cake/party/buy/buy_detail_host.dart';
// import 'package:piece_of_cake/party/dlv/dlv_detail_guest.dart';
//
// class Item extends StatelessWidget {
//   const Item({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final partyCode = '001';
//     return InkWell(
//         splashColor: Colors.amber,
//         hoverColor: Colors.lightGreenAccent,
//         highlightColor: Colors.amber,
//         child: Container(
//             height: 150,
//             margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(20)
//             ),
//             child: Row(
//                 children: [
//                   Flexible(flex: 4, child:
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.asset(
//                       'assets/images/harry.png',
//                       fit: BoxFit.fill,
//                     ), // Text(key['title']),
//                   ),
//                   ),
//                   Flexible(flex: 6,child: Container(
//                       margin: EdgeInsets.all(5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('강아지 자랑해요',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),overflow: TextOverflow.ellipsis,),
//                           Text('거제1동', style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
//                           Text('개예쁜 말티즈예요', style: TextStyle(fontSize: 18),overflow: TextOverflow.ellipsis,),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 LikeButton(),
//                                 Text('4'),
//                               ]
//                           )
//                         ],
//                       )
//                   ),
//                   )
//                 ]
//             )
//         ),
//         onTap: () {
//           switch (partyCode) {
//             case '001':
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PieDetailGuest()),
//               );
//               break;
//             case '002':
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => BuyDetailGuest()),
//               );
//               break;
//             case '003':
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => DlvDetailGuest()),
//               );
//               break;
//           }
//         }
//     );
//   }
// }
//
