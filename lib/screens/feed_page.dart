import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_practice/utils/profile_image_parser.dart';
import 'package:flutter_practice/constants/size.dart';
import 'package:flutter_practice/widgets/comment.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _iconButton(
          null,
          'assets/actionbar_camera.png',
          Colors.black,
        ),
        title: Image.asset(
          'assets/insta_text_logo.png',
          height: 26,
        ),
        actions: <Widget>[
          _iconButton(
            null,
            'assets/actionbar_igtv.png',
            Colors.black,
          ),
          _iconButton(
            null,
            'assets/direct_message.png',
            Colors.black,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _feedHeader(index),
              _feedImage(index),
              _feedAction(index),
              _feedLikes(index),
              Comment(
                userName: 'UserName$index',
                caption: 'hahaha',
                dateTime: DateTime.now(),
                showProfile: true,
              ),
            ],
          );
        },
      ),
    );
  }
}

///
/// 좋아요 row 위젯
Widget _feedLikes(int index) {
  return Padding(
    padding: const EdgeInsets.only(left: common_gap),
    child: Text(
      '1800 likes',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

///
/// 게시글 이미지 아래 해당 게시글의 액션버튼 영역
Widget _feedAction(int index) {
  return Row(
    children: <Widget>[
      _iconButton(null, 'assets/heart_selected.png', Colors.red),
      _iconButton(null, 'assets/comment.png', Colors.black87),
      _iconButton(null, 'assets/direct_message.png', Colors.black87),
      Spacer(),
      _iconButton(null, 'assets/bookmark.png', Colors.black87),
    ],
  );
}

///
/// 이미지 위에 사용자의 정보를 나타내주는 영역
Widget _feedHeader(int index) {
  return Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(14.0),
        child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            // 'https://picsum.photos/id/$index/50/50',
            getProfileImgPath('UserName$index'),
          ),
          radius: 16,
        ),
      ),
      // 위젯들이 들어가고 남는 영역을 전부 채운다. (유저명은 길이가 얼마나될지 모르기 때문)
      Expanded(
        child: Text('UserName$index'),
      ),
      IconButton(
        icon: Icon(
          Icons.more_horiz,
          color: Colors.black87,
        ),
        onPressed: null,
      ),
    ],
  );
}

///
/// Image.Network()를 사용하면 다른곳 갔다가 다시금 돌아오게 되면, 그때마다 이미지를
/// 다시 다운받고 그리기때문에 비효율적이다. 때문에 CachedNetworkImage를 사용한다.
CachedNetworkImage _feedImage(int index) {
  return CachedNetworkImage(
    imageUrl: 'https://picsum.photos/id/$index/200/200',
    // 이미지 별도 설정
    imageBuilder: (BuildContext context, ImageProvider imageProvider) {
      return AspectRatio(
        // 이미지 비율 (1은 가로세로 1:1 의미)
        aspectRatio: 1,
        child: Container(
          // BoxDecoration으로 Container 테두리 설정
          decoration: BoxDecoration(
            // BoxDecoration안에 어떤 이미지를 적용할 것인지
            image: DecorationImage(
              // imageProvider에 해당 이미지가 저장되어 있다.
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}

Widget _iconButton(onPressed, imageUrl, color) {
  return IconButton(
    onPressed: onPressed,
    icon: ImageIcon(
      AssetImage(imageUrl),
      color: color,
    ),
  );
}
