import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/sign_in_page.dart';
import 'package:flutter_practice/widgets/sign_up_form.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                SignUpForm(),
                _gotoSignInPageBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _gotoSignInPageBtn(BuildContext context) {
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
            builder: (context) => SignIn(),
          );
          Navigator.pushReplacement(context, _route);
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(),
            children: <TextSpan>[
              TextSpan(
                text: 'Already have an account?',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                ),
              ),
              TextSpan(
                  text: '  Sign In',
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
