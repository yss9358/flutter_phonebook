import 'package:flutter/material.dart';
import 'guestVo.dart';
import 'package:dio/dio.dart';

class Guestbook extends StatelessWidget {
  const Guestbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('방명록'),),
        body: _Guestbook()
    );
  }
}

class _Guestbook extends StatefulWidget {
  const _Guestbook({super.key});

  @override
  State<_Guestbook> createState() => _GuestbookState();
}

class _GuestbookState extends State<_Guestbook> {

  late Future<GuestVo> guestVoFuture;


  @override
  void initState() {
    super.initState();
    guestVoFuture = getGuestVo();
  }

  Future<GuestVo> getGuestVo() async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
        'http://3.34.5.82:9000/api/guests/9',
      );

      if (response.statusCode == 200) {
        print(response.data['apiData']);
        return GuestVo.fromJson(response.data['apiData']);
      } else {
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      throw Exception('Failed to load person: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: guestVoFuture, //Future<> 함수명, 으로 받은 데이타
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('데이터를 불러오는데 실패했습니다.'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('데이터가 없습니다.'));
        } else { //데이터가 있으면

          return Container(
            width: 600,
            height: 150,
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                border: Border.all(width: 1)
            ),
            child: Column(
              children: [
                Container(
                  width: 550,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(width: 1)
                  ),
                  child: Container(
                    width: 450,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1)
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1)
                            ),
                            child: Text('[${snapshot.data!.no}]')
                        ),
                        Container(
                            width: 100,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1)
                            ),
                            child: Text('${snapshot.data!.name}')
                        ),
                        Container(
                            width: 280,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1)
                            ),
                            child: Text('${snapshot.data!.regDate}')
                        ),
                        Container(
                            width: 90,
                            height: 30,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Colors.black)
                            ),
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/read');
                                },
                                child: Text(
                                  '삭제', style: TextStyle(fontSize: 15),)
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 550,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1)
                  ),
                  child: Container(
                      width: 200,
                      height: 40,
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          // border: Border.all(width: 1)
                      ),
                      child: Text(
                        '${snapshot.data!.content}', style: TextStyle(fontSize: 15),)
                  ),
                )
              ],
            ),
          );
        } // 데이터가있으면
      },
    );
  }

}