import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/feed_page.dart';
import 'package:flutter_practice/screens/profile.dart';
import 'package:flutter_practice/screens/follow.dart';
import 'package:flutter_practice/screens/camera.dart';
import 'package:flutter_practice/screens/search.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // 현재 선택된 인덱스에 따른 body에 표현할 화면 정보 변수
  static List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    Search(),
    Container(),
    Follow(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack 위젯은 5개의 자식이 있으면 5개의 자식이 한번만 생성되고 stack처럼
      // 겹쳐져 있다가 사용자가 보고자 하는 화면을 맨 위로 올려서 보여준다. PyQt의 stackedWidget와 동일
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => _onItemTapped(value),
          // 선택 됐을 때 label 표현 여부
          showSelectedLabels: false,
          // 선택 안됐을 때 label 표현 여부
          showUnselectedLabels: false,
          // 선택 됐을 때 아이템 색상
          selectedItemColor: Colors.black,
          // 선택 안됐을 때 아이템 색상
          unselectedItemColor: Colors.grey[900],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(249, 249, 249, 1),
          items: <BottomNavigationBarItem>[
            _buildBottomNavigationBarItem(
                activeIconPath: 'assets/home_selected.png',
                iconPath: 'assets/home.png'),
            _buildBottomNavigationBarItem(
                activeIconPath: 'assets/search_selected.png',
                iconPath: 'assets/search.png'),
            _buildBottomNavigationBarItem(iconPath: 'assets/add.png'),
            _buildBottomNavigationBarItem(
                activeIconPath: 'assets/heart_selected.png',
                iconPath: 'assets/heart.png'),
            _buildBottomNavigationBarItem(
                activeIconPath: 'assets/profile_selected.png',
                iconPath: 'assets/profile.png'),
          ]),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String activeIconPath, String iconPath}) {
    return BottomNavigationBarItem(
      activeIcon:
          activeIconPath == null ? null : ImageIcon(AssetImage(activeIconPath)),
      icon: ImageIcon(AssetImage(iconPath)),
      title: Text(''),
    );
  }

  void _onItemTapped(int index) {
    // 하단 3번째 아이콘을 클릭시, openCamera메소드 호출. 카메라는 별도의 화면전환이
    // 필요하기 때문에 Navigator를 사용해야 한다.
    if (index == 2) {
      openCamera(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void openCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Camera()),
    );
  }
}
