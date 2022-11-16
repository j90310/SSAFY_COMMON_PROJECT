import 'package:flutter/material.dart';

class NoticeItem extends StatelessWidget {
  const NoticeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.amber,
        hoverColor: Colors.lightGreenAccent,
        highlightColor: Colors.amber,
        child: Container(
            height: 120,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
                children: [
                  Flexible(flex: 2, child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/harry.png',
                        fit: BoxFit.fill,
                      ), // Text(key['title']),
                    ),
                  ),
                  Flexible(flex: 8,child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('투덜이스머프쟝님이 파티에 참가했어요!',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            overflow: TextOverflow.visible,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('4시간 전'),
                              ]
                          )
                        ],
                      )
                  ),
                  )
                ]
            )
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => BuyDetail()),
          // );
        }
    );
  }
}




class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Notice')
      ),
      body: ListView(
        children: [
          NoticeItem(),
          NoticeItem(),
          NoticeItem(),
          NoticeItem(),
          NoticeItem(),
          NoticeItem(),
          Container(
            margin: EdgeInsets.only(bottom: 50),
          )
        ],
      )
    );
  }
}
