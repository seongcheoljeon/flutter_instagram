import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/size.dart';
import 'package:flutter_practice/utils/profile_image_parser.dart';

class Follow extends StatelessWidget {
  final List<String> users = List.generate(10, (index) => 'user $index');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // List를 만들어주는 위젯이다. 뒤에 separated는 각각 List에 구분자를 주기 위해 사용한다.
      child: ListView.separated(
        // 각각의 아이템들을 빌드할때 어떤식으로 빌드할것인지 설정
        itemBuilder: (BuildContext context, int index) => _item(users[index]),
        // separatorBuilder는 구분자를 어떤식으로 줄것인지 설정. 위젯을 반환한다.
        // Divider는 구분자를 나타내주기 위한 위젯이고 List 사이에 실선을 넣어줄 때 사용한다.
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          color: Colors.grey[300],
        ),
        // 아이템 개수
        itemCount: 10,
      ),
    );
  }

  ListTile _item(String user) {
    return ListTile(
      leading: CircleAvatar(
        radius: profile_radius,
        backgroundImage: NetworkImage(
          getProfileImgPath(user),
        ),
      ),
      title: Text(user),
      subtitle: Text('follow & unfollow page 작업중'),
      trailing: Container(
        height: 30,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red[50],
          border: Border.all(color: Colors.black87, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'following',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
        ),
      ),
    );
  }
}
