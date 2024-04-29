import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'personVo.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('읽기 페이지'),),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: _ReadPage(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/list');
        },
        child: Text('돌아가기'),
      ),
    );
  }
}

class _ReadPage extends StatefulWidget {
  const _ReadPage({super.key});

  @override
  State<_ReadPage> createState() => _ReadPageState();
}

// 할일 정의 클래스 (통신, 데이터 적용)
class _ReadPageState extends State<_ReadPage> {
  // 변수
  late Future<PersonVo> personVoFuture;
  // 라우터로 온 데이터 받기

  // 초기화 함수 ( 1번만 실행 )
  @override
  void initState() {
    super.initState();
  }

  // 화면 그리기
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final personId = args['personId'];
    personVoFuture = getPersonByNo(personId);
    return FutureBuilder(
      future: personVoFuture, //Future<> 함수명, 으로 받은 데이타
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('데이터가 없습니다.'));
        } else { //데이터가 있으면

            return Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.redAccent
                        ),
                        child: Text('번호',style: TextStyle(fontSize: 20,),)),
                    Container(
                        width: 450,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent
                        ),
                        child: Text('${snapshot.data!.personId}',style: TextStyle(fontSize: 20,),))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.redAccent
                        ),
                        child: Text('이름',style: TextStyle(fontSize: 20,),)),
                    Container(
                        width: 450,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent
                        ),
                        child: Text('${snapshot.data!.name}',style: TextStyle(fontSize: 20,),))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.redAccent
                        ),
                        child: Text('핸드폰',style: TextStyle(fontSize: 20,),)),
                    Container(
                        width: 450,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent
                        ),
                        child: Text('${snapshot.data!.hp}',style: TextStyle(fontSize: 20,),))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.redAccent
                        ),
                        child: Text('회사',style: TextStyle(fontSize: 20,),)),
                    Container(
                        width: 450,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent
                        ),
                        child: Text('${snapshot.data!.company}',style: TextStyle(fontSize: 20,),))
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: (){
                          print('수정');
                          Navigator.pushNamed(
                            context, '/update',
                            arguments: {'personVo' : personVoFuture}
                          );
                        },
                        child: Text('수정')
                      )
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: (){
                          deleteByNo(snapshot.data!.personId);
                        },
                        child: Text('삭제')
                      )
                    )
                  ],
                )
              ],
            );
        } // 데이터가있으면
      },
    );
  }



  // 삭제
  Future<void> deleteByNo(int no) async{
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.delete(
        'http://3.34.5.82:9002/api/phonebooks/${no}'
      );
      if(response.statusCode == 200){
        Navigator.pushNamed(context, '/list');
      } else {
        throw Exception('api 서버문제');
      }
    } catch(e){
      throw Exception('Failed to load person: $e');
    }
  }

  // 한명정보 가져오기
  Future<PersonVo> getPersonByNo(int no) async{
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
        'http://3.34.5.82:9002/api/phonebooks/${no}',
      );

      if (response.statusCode == 200) {
        return PersonVo.fromJson(response.data['apiData']);
      } else {
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      throw Exception('Failed to load person: $e');
    }
  }

}
