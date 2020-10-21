import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/size.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchData = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _searchInput(),
          _scrollImage(),
        ],
      ),
    );
  }

  SizedBox _searchInput() {
    return SizedBox(
      height: 40,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: common_xs_gap),
          child: TextFormField(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            decoration: InputDecoration(hintText: '검색어를 입력하세요.'),
            // 검색했을 때 실행되는 속성
            onFieldSubmitted: (String data) {
              setState(() {
                _searchData = data;
              });
            },
          ),
        ),
      ),
    );
  }

  Expanded _scrollImage() {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: GridView.count(
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio: 1,
              children: List.generate(30, (int index) => _gridImgItem(index)),
            ),
          ),
        ],
      ),
    );
  }

  CachedNetworkImage _gridImgItem(int index) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: 'https://picsum.photos/id/$index/100/100',
    );
  }
}
