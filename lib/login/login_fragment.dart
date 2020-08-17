import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginFragment extends StatelessWidget {
  final Function enableRegister;
  final Function validateLogin;

  const LoginFragment(this.validateLogin, this.enableRegister);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            child: SizedBox(
              height: 35,
              width: 140,
              child: FlatButton(
                onPressed: () {
                  validateLogin();
                },
                textColor: Colors.white,
                child: Text('Login'),
              ),
            )),
        SizedBox(
            height: 35,
            width: 140,
            child: FlatButton(
                onPressed: () {
                  enableRegister();
                },
                textColor: Colors.white,
                child: Text("Create account")))
      ],
    );
  }
}
