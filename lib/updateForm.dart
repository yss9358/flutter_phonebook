import 'package:flutter/material.dart';

class UpdateForm extends StatelessWidget {
  const UpdateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('수정폼페이지'),),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: _UpdateForm(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(
            context, '/read',
            arguments: {'personId' : 3}
          );
        },
        child: Text('돌아가기'),
      ),

    );
  }
}

class _UpdateForm extends StatefulWidget {
  const _UpdateForm({super.key});

  @override
  State<_UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<_UpdateForm> {

  // 변수
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  // 초기화
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final personVo = args['personVo'];
    print(personVo);
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
                child: Text('123',style: TextStyle(fontSize: 20,),))
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
                child: Text('이름',style: TextStyle(fontSize: 20,),))
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
                child: Text('핸드폰',style: TextStyle(fontSize: 20,),))
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
                child: Text('회사',style: TextStyle(fontSize: 20,),))
          ],
        ),

      ],
    );
  }


}

