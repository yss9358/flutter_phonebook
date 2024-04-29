import 'package:flutter/material.dart';
import 'personVo.dart';
import 'package:dio/dio.dart';

class WriteForm extends StatelessWidget {
  const WriteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('등록폼'),),
      body: Container(
        width: 800,
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: _WriteForm(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/list');
        },
        child: Text('돌아가기'),
      )
    );
  }
}

class _WriteForm extends StatefulWidget {
  const _WriteForm({super.key});

  @override
  State<_WriteForm> createState() => _WriteFormState();

}

class _WriteFormState extends State<_WriteForm> {

  // 변수
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  // 초기화
  @override
  void initState(){
    super.initState();
  }

  // 통신하기
  Future< void > join() async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.post(
          'http://3.34.5.82:9002/api/phonebooks',
          data: {
            'name' : _nameController.text,
            'hp' : _hpController.text,
            'company' : _companyController.text
          }
      );
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/list');
      } else {
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      throw Exception('Failed to load person: $e');
    }
  }


  // 화면 그리기
  @override
  Widget build(BuildContext context) {
        return Container(
          color: Colors.white,
          child: Form(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: '이름',
                        hintText: '이름을 입력하세요',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _hpController,
                    decoration: InputDecoration(
                        labelText: '핸드폰',
                        hintText: '핸드폰 번호를 입력하세요',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _companyController,
                    decoration: InputDecoration(
                        labelText: '회사',
                        hintText: '회사번호를 입력하세요',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(
                    width: 450,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          print('전송하고싶다');
                          join();
                        },
                        child: Text('등록')
                    )
                )
              ],
            ),
          ),
        );
      }
}



