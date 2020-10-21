import 'dart:convert';

String getProfileImgPath(String userName) {
  // AsciiEncoder : 문자를 아스키코드로 변경해주는 함수
  final AsciiEncoder encoder = AsciiEncoder();
  List<int> codes = encoder.convert(userName);
  int sum = 0;
  codes.forEach((code) => sum += code);
  final int imgNum = sum % 850;
  return 'https://picsum.photos/id/$imgNum/30/30';
}
