import 'package:flutter/material.dart';
import 'package:flutter_practice/main_page.dart';
import 'package:flutter_practice/constants/size.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _pwConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Spacer(flex: 6),
              Image.asset('assets/insta_text_logo.png'),
              Spacer(flex: 1),
              _emailForm(),
              Spacer(flex: 1),
              _pwForm(),
              Spacer(flex: 1),
              _pwConfirmForm(),
              Spacer(flex: 2),
              _confirmBtn(),
              Spacer(flex: 2),
              _orLine(),
              Spacer(flex: 2),
              _loginFacebook(),
              Spacer(flex: 2),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _emailForm() {
    return TextFormField(
      controller: _emailController,
      decoration: _getTextFieldDeco('Email'),
      validator: (String value) {
        if (value.trim().isEmpty || !value.contains('@')) {
          return '이메일을 정확히 입력하세요.';
        }
        return null;
      },
    );
  }

  TextFormField _pwForm() {
    return TextFormField(
      controller: _pwController,
      decoration: _getTextFieldDeco('Password'),
      validator: (String value) {
        if (value.trim().isEmpty) {
          return '비밀번호를 입력하세요.';
        }
        return null;
      },
    );
  }

  TextFormField _pwConfirmForm() {
    return TextFormField(
      controller: _pwConfirmController,
      decoration: _getTextFieldDeco('Confirm Password'),
      validator: (String value) {
        if (value.trim().isEmpty) {
          return '비밀번호를 입력하세요.';
        } else if (value != _pwController.value.toString()) {
          return '비밀번호가 다릅니다.';
        }
        return null;
      },
    );
  }

  InputDecoration _getTextFieldDeco(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey[300],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey[300],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  FlatButton _confirmBtn() {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          final MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => MainPage(),
          );
          Navigator.pushReplacement(context, route);
        }
      },
      child: Text(
        'Join',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      disabledColor: Colors.blue[100],
    );
  }

  Stack _orLine() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          child: Container(
            color: Colors.grey[300],
            height: 3,
          ),
          left: 0,
          right: 0,
          height: 1,
        ),
        Container(
          height: 3,
          width: 50,
          color: Colors.grey[50],
        ),
        Text(
          'OR',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]),
        )
      ],
    );
  }

  FlatButton _loginFacebook() {
    return FlatButton.icon(
      onPressed: () {
        simpleSnackBar(context, 'facebook pressed');
      },
      textColor: Colors.blue,
      icon: ImageIcon(
        AssetImage('assets/icon/facebook.png'),
      ),
      label: Text('Login with Facebook'),
    );
  }

  void simpleSnackBar(BuildContext context, String text) {
    // 화면 하단 알림창 위젯
    final SnackBar snackBar = SnackBar(content: Text(text));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
