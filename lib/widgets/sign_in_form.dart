import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/size.dart';
import 'package:flutter_practice/main_page.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // 유일한 키를 가졌다. 이 키 값으로 유효성 검사나 여러가지 일을 할 수 있다.
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 이 클래스는 사용자가 해당 form의 값을 입력, 수정, 삭제할때마다 컨트롤러가 해당
  // 리스너한테 값이 변경됐다고 알려준다. 리스너는 전달받은 해당 필드가 어떻게 변경됐는지
  // 현재 상태를 인식하고 기억한다.
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  // 해당 메소드는 페이지가 소멸될때 실행되는 메소드다. 때문에 여기서 생성했던 controller를
  // 소멸시켜줘야 한다. 그렇지 않으면 페이지가 끝나고 다른 페이지로 이동해도 메모리에 계속
  // 남아있어서 불필요한 리소스 낭비가 발생한다.
  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드를 열면 화면이 따라서 올라가게 된다. 그러면 화면이 망가지기 때문에 해당 현상을
      // 방지해주는 속성이다.
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
              // 위젯간에 간격을 조정하는 클래스이다. flex속성으로 비율을 정해준다.
              // flex: 2, flex: 1 이면, 2:1 비율로 한다는 뜻이다.
              Spacer(flex: 6),
              Image.asset('assets/insta_text_logo.png'),
              Spacer(flex: 1),
              _emailForm(),
              Spacer(flex: 1),
              _pwForm(),
              Spacer(flex: 1),
              _forgetPw(),
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

  FlatButton _confirmBtn() => FlatButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            final MaterialPageRoute route = MaterialPageRoute(
                builder: (BuildContext context) => MainPage());
            // pushReplacement 메소드는 현재 페이지의 route 정보를 남기지 않고 이동할 때 사용한다.
            Navigator.pushReplacement(context, route);
          }
        },
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        disabledColor: Colors.blue[100],
      );

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

  InputDecoration getTextFieldDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300], width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300], width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      fillColor: Colors.grey[100],
      filled: true,
    );
  }

  TextFormField _emailForm() => TextFormField(
        // 어떤 컨트롤러로 리스너에 알려줄것인지 설정
        controller: _emailController,
        decoration: getTextFieldDeco('Email'),
        // 이 속성을 통해 유효성 검사를 한다.
        validator: (String value) {
          if (value.trim().isEmpty || !value.contains('@')) {
            return '이메일 입력이 잘못되었습니다.';
          }
          return null;
        },
      );

  TextFormField _pwForm() => TextFormField(
        controller: _pwController,
        decoration: getTextFieldDeco('Password'),
        validator: (value) {
          if (value.trim().isEmpty) {
            return '비밀번호 입력이 잘못되었습니다.';
          }
          return null;
        },
      );

  Text _forgetPw() => Text(
        'Forgetten password?',
        textAlign: TextAlign.end,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blue[700],
        ),
      );
}
