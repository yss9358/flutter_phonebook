import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'personVo.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  // 기본레이아웃
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('리스트페이지'),),
      body: Container(
        width: 800,
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: _ListPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/write');
        },
        child: Text('등록고고'),
      ),
    );
  }
}

//  등록용
class _ListPage extends StatefulWidget {
  const _ListPage({super.key});

  @override
  State<_ListPage> createState() => _ListPageState();
}

  // 리스트 가져오기 - dio 통신

  Future< List<PersonVo> > getList() async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
        'http://3.34.5.82:9002/api/phonebooks',
      );

      if (response.statusCode == 200) {
        // print(response.data['apiData']);
        List<PersonVo> list = [];
        for(int i=0; i<response.data['apiData'].length; i++){
          PersonVo vo = PersonVo.fromJson(response.data['apiData'][i]);
          list.add(vo);
        }
        return list;

      } else {
        throw Exception('api 서버 문제');
      }

    } catch (e) {
      throw Exception('Failed to load person: $e');
    }
  }
// 할일
class _ListPageState extends State<_ListPage> {

  // 변수
  late Future< List<PersonVo> > futureList ;

  // 생애주기별 hook

  // 초기화 할 때
  @override
  void initState() {
    super.initState();
    futureList = getList();
  }

  // 그림 그릴때
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('데이터가 없습니다.'));
        } else { //데이터가 있으면
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
               return Row(
                 children: [
                   Container(
                       width: 70,
                       height: 50,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           color: Colors.pinkAccent,
                           border: Border.all(width: 1)
                       ),
                       child: Text('${snapshot.data![index].personId}',style: TextStyle(fontSize: 24,),)
                   ),
                   Container(
                       width: 80,
                       height: 50,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           color: Colors.greenAccent,
                           border: Border.all(width: 1)
                       ),
                       child: Text('${snapshot.data![index].name}',style: TextStyle(fontSize: 24),)),
                   Container(
                       width: 200,
                       height: 50,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           border: Border.all(width: 1),
                           color: Colors.blueAccent
                       ),
                       child: Text('${snapshot.data![index].hp}',style: TextStyle(fontSize: 24),)),
                   Container(
                       width: 200,
                       height: 50,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           border: Border.all(width: 1),
                           color: Colors.pinkAccent
                       ),
                       child: Text('${snapshot.data![index].company}',style: TextStyle(fontSize: 24),)),
                   Container(
                     width: 50,
                     height: 50,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                       color: Colors.greenAccent,
                       border: Border.all(width: 1)
                     ),
                     child: IconButton(
                         onPressed: (){
                           Navigator.pushNamed(
                               context,
                               '/read',
                               arguments: {
                                'personId' : snapshot.data![index].personId,
                               }
                           );
                         },
                         icon: Icon(Icons.arrow_forward_ios)
                     ),
                   ),
                 ],
               );;
              }
          );
        } // 데이터가있으면
      },
    );
   }

}
