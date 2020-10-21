import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/size.dart';
import 'package:flutter_practice/utils/profile_image_parser.dart';
import 'package:flutter_practice/widgets/profile_side_menu.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
// 상단 메뉴 버튼 클릭시, 사이트 메뉴 오픈할지 여부
  bool _menuOpenState = false;
// size 변수
  Size _size;
// 메뉴 가로 길이
  double _menuWidth;
// 사이드 메뉴가 열리고 닫히는 시간
  int _duration = 200;
  // tab
  AlignmentGeometry tabAlign = Alignment.centerLeft;
  //
  double _gridMargin = 0;
  //
  double _myImgGridMargine;

  @override
  Widget build(BuildContext context) {
    // 현재 디스플레이 화면 사이즈 정보
    _size = MediaQuery.of(context).size;
    _myImgGridMargine = _size.width;
    // 현재 디스플레이 사이즈의 75%정도 크기 설정
    _menuWidth = _size.width / 1.5;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _rightSideMenu(),
          _profile(),
        ],
      ),
    );
  }

  ///
  /// 메뉴 버튼 클릭시, 오른쪽에서 나오는 메뉴 영역
  Widget _rightSideMenu() {
    return AnimatedContainer(
      duration: Duration(milliseconds: _duration),
      // 해당 애니메이션을 적용할 가로크기 지정
      width: _menuWidth,
      // 애니메이션을 적용할 그래프 방식
      curve: Curves.linear,
      // 적용할 위젯 색상 지정
      color: Colors.grey[200],
      // 애니메이션을 어느 형식으로 재생할지(xyz값을 지정한다. 오른쪽에서 왼쪽으로, 아래서 위로 등)
      transform: Matrix4.translationValues(
          _menuOpenState ? _size.width - _menuWidth : _size.width, 0, 0),
      // 보통 디스플레이에서 맨 위에 시간, 배터리 정보 등등이랑 겹쳐 보이는데, SafeArea는
      // 그런 정보 바로 아래서부터 보여지게끔하는 위젯이다.
      child: SafeArea(
        child: SizedBox(
          width: _menuWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProfileSideMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profile() {
    return AnimatedContainer(
      duration: Duration(milliseconds: _duration),
      curve: Curves.linear,
      color: Colors.transparent,
      transform:
          Matrix4.translationValues(_menuOpenState ? -_menuWidth : 0, 0, 0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _appBar(),
            _profileHeader(),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: common_gap),
            child: Text(
              'UserName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
              _menuOpenState = !_menuOpenState;
            });
          },
        ),
      ],
    );
  }

  Widget _getStatusValue(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          // FittedBox는 부모 범위 안에서 자식 위젯의 범위를 맞추는 위젯이다.
          // 자식의 데이터가 길어도 부모 영역의 UI를 벗어나지 않게 해준다.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  Widget _getStatusLabel(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        ),
      );

  Widget _header() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_gap),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(getProfileImgPath('UserName')),
          ),
        ),
        Expanded(
          child: Table(
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  _getStatusValue('555'),
                  _getStatusValue('8k'),
                  _getStatusValue('45k'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _getStatusLabel('Posts'),
                  _getStatusLabel('Followers'),
                  _getStatusLabel('Following'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userName() => Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text(
          'UserName',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  Widget _profileComment() => Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text(
          '플러터 인스타그램 클론',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      );

  Widget _editProfile() => Padding(
        padding: const EdgeInsets.all(common_gap),
        child: SizedBox(
          height: 24.0,
          child: Container(
            color: Colors.white,
            // border가 자동으로 잡혀있는 보튼이다.
            child: OutlineButton(
              onPressed: () {},
              borderSide: BorderSide(color: Colors.black45),
              // border 모양 변경
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                'Edit profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );

  ///
  /// tab 역할을 하는 icon 표현
  Widget _tabIcons() => Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: ImageIcon(AssetImage('assets/grid.png')),
              onPressed: () => _setTab(true),
              color: this.tabAlign == Alignment.centerRight
                  ? Colors.grey[400]
                  : Colors.black87,
            ),
          ),
          Expanded(
            child: IconButton(
              icon: ImageIcon(AssetImage('assets/saved.png')),
              onPressed: () => _setTab(false),
              color: this.tabAlign == Alignment.centerLeft
                  ? Colors.grey[400]
                  : Colors.black87,
            ),
          ),
        ],
      );

  void _setTab(bool tableLeft) {
    setState(() {
      if (tableLeft) {
        this.tabAlign = Alignment.centerLeft;
      } else {
        this.tabAlign = Alignment.centerRight;
      }
    });
  }

  ///
  /// _tabIcons에서 선택한 아이콘 밑에 선택 효과주는 메소드
  Widget _animatedBar() => AnimatedContainer(
        duration: Duration(microseconds: _duration),
        alignment: tabAlign,
        curve: Curves.easeInOut,
        color: Colors.transparent,
        height: 1,
        width: this._size.width,
        child: Container(
          height: 3,
          width: this._size.width / 2,
          color: Colors.black87,
        ),
      );

  Widget _imageGrid() => GridView.count(
        crossAxisCount: 3,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: 1,
        children: List.generate(30, (index) => _gridImgItem(index)),
      );

  CachedNetworkImage _gridImgItem(int index) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: 'https://picsum.photos/id/$index/100/100',
    );
  }

  ///
  /// SliverToBoxAdapter는 sliver가 아닌 것들을 sliver로 바꿔주는 역할을 하는 위젯이다.
  /// 여기서 Sliver는 스크롤이 가능한 위젯이나 리스트를 말한다. 위에서 만든 2개의 탭을
  /// 누를때마다 각각의 해당하는 영역이 보여지게 만드는 메소드다.
  Widget _getImageGrid(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: this._duration),
            transform: Matrix4.translationValues(_gridMargin, 0, 0),
            curve: Curves.linear,
            child: _imageGrid(),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: this._duration),
            transform: Matrix4.translationValues(_myImgGridMargine, 0, 0),
            curve: Curves.linear,
            child: _imageGrid(),
          ),
        ],
      ),
    );
  }

  Widget _profileHeader() {
    return Expanded(
      // 자식들을 넣어 스크롤 가능하게 만든다.
      child: CustomScrollView(
        slivers: <Widget>[
          // ListView와 비슷하게 동작하며 sliver 하위 위젯으로 사용하고 하위로 delegate 속성을 사용한다.
          SliverList(
            // SliverChildListDelegate는 delegate속성에 사용하는 위젯이다.
            delegate: SliverChildListDelegate(
              <Widget>[
                _header(),
                _userName(),
                _profileComment(),
                _editProfile(),
                _tabIcons(),
                _animatedBar(),
              ],
            ),
          ),
          _getImageGrid(context),
        ],
      ),
    );
  }
}
