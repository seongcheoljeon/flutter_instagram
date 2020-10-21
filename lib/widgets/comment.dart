import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/size.dart';
import 'package:flutter_practice/utils/profile_image_parser.dart';
import 'package:intl/intl.dart';

class Comment extends StatelessWidget {
  final String userName;
  final bool showProfile;
  final DateTime dateTime;
  final String caption;

  Comment({
    @required this.userName,
    this.showProfile = false,
    this.dateTime,
    @required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Visibility 위젯은 자식들을 보여줄지 말지를 정해줄 수 있는 위젯이다. (visible 속성으로 결정)
        Visibility(
          child: CircleAvatar(
            backgroundImage: NetworkImage(getProfileImgPath(userName)),
            radius: profile_radius,
          ),
        ),
        Visibility(
          visible: showProfile,
          child: SizedBox(
            width: common_xs_gap,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '  '),
                    TextSpan(
                        text:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                            'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an '
                            'unknown printer took a galley of type and scrambled it to make a type apecimen book.'),
                  ],
                ),
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              Visibility(
                child: dateTime == null
                    ? SizedBox()
                    : Text(
                        // DateFormat은 intl 패키지를 다운받고 사용할 수 있는 포매터이다.
                        new DateFormat('yyyy-MM-dd').format(dateTime),
                        style: TextStyle(color: Colors.grey[700], fontSize: 11),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
