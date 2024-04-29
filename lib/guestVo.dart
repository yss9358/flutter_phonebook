class GuestVo {
  // 필드
  int no;
  String name;
  String password;
  String content;
  String regDate;

  // 생성자
  GuestVo({
    required this.no,
    required this.name,
    required this.password,
    required this.content,
    required this.regDate
  });

  factory GuestVo.fromJson(Map<String, dynamic> apiData){
    return GuestVo(
      no : apiData['no'],
      name : apiData['name'],
      password: apiData['password'],
      content: apiData['content'],
      regDate: apiData['regDate']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'no' : no,
      'name' : name,
      'password' : password,
      'content' : content,
      'regDate' : regDate
    };
  }
}