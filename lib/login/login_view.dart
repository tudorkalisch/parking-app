import 'package:flutter/material.dart';
import 'package:berting_app/main/main_view.dart';

class LoginView extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginView> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.lightBlue, Colors.deepPurple])),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                        width: 300,
                        child: TextFormField(
                          controller: emailTextController,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: "Email",
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 80,
                          width: 300,
                          child: TextFormField(
                            controller: passwordTextController,
                            textAlign: TextAlign.start,
                            obscureText: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: "Password",
                            ),
                          )),
                      SizedBox(
                        height: 35,
                        width: 125,
                        child: RaisedButton(
                          onPressed: () {
                            validateLogin();
                          },
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                        ),
                      ),
                    ]))));
  }

  void validateLogin() {
    // if (emailTextController.text == "admin" &&
    //     passwordTextController.text == "admin") {
    goToLogin();
    // }
  }

  void goToLogin() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/main', ModalRoute.withName('/login'));
  }
}
