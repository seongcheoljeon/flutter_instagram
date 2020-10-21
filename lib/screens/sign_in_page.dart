import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/sign_in_form.dart';
import 'package:flutter_practice/screens/sign_up_page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                SignInForm(),
                _gotoSignUpPageBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _gotoSignUpPageBtn(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 40,
      child: FlatButton(
        shape: Border(
          top: BorderSide(
            color: Colors.grey[300],
          ),
        ),
        onPressed: () {
          final MaterialPageRoute _route = MaterialPageRoute(
            builder: (context) => SignUp(),
          );
          Navigator.pushReplacement(context, _route);
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(),
            children: <TextSpan>[
              TextSpan(
                text: 'Don\'t have an account?',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                ),
              ),
              TextSpan(
                  text: '  Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
