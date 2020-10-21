import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/size.dart';

class ProfileSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // BoxDecoration은 사이드 메뉴가 열렸을 때, 바닥 프로필 페이지와 경제를 지어주기
      // 위해 사이드 메뉴 왼쪽만 회색 실선을 그려주는 역할을 한다.
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.grey[300]),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            height: 3,
          ),
          // 버튼에 아이콘을 적용해서 보여주는 위젯이다.
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app),
            label: Text(
              'Log out',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
