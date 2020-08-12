import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/main/main_view.dart';
import 'package:parking_app/service/login_service.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  static const String routeName = '/login';

  LoginService loginService;

  LoginView() {
    this.loginService = locator<LoginService>();
  }
  @override
  LoginState createState() => LoginState(loginService);
}

class LoginState extends State<LoginView> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final LoginService loginService;
  bool loginState = true;
  String confirmErrorText;

  LoginState(this.loginService);

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
                      Container(
                          child: Flex(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              direction: Axis.horizontal,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                            Text(
                              "Parker",
                              style: TextStyle(
                                  fontFamily: "Staatliches",
                                  color: Colors.white,
                                  fontSize: 50),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Image(
                                  height: 60,
                                  image: AssetImage(
                                      "assets/ic_launcher_round.png")),
                            )
                          ])),
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
                      if (loginState)
                        Column(
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
                        ),
                      if (!loginState)
                        Column(
                          children: [
                            SizedBox(
                                height: 80,
                                width: 300,
                                child: TextFormField(
                                  controller: confirmPasswordTextController,
                                  textAlign: TextAlign.start,
                                  obscureText: true,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    errorText: confirmErrorText,
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    labelStyle: TextStyle(color: Colors.white),
                                    labelText: "Confirm password",
                                  ),
                                )),
                            SizedBox(
                                height: 35,
                                width: 125,
                                child: FlatButton(
                                    onPressed: () {
                                      register();
                                    },
                                    textColor: Colors.white,
                                    child: Text("Register")))
                          ],
                        ),
                    ]))));
  }

  void validateLogin() {
    loginService
        .login(emailTextController.text, passwordTextController.text)
        .then(onLoginSuccess)
        .catchError(onLoginError);
  }

  void onLoginSuccess(bool success) {
    if (success) {
      goToMain();
    }
  }

  void onLoginError(var exception) {
    log(exception.toString());
  }

  void onRegisterSuccess(bool success) {
    if (!success) {
      return;
    }

    setState(() {
      loginState = true;
    });
  }

  void onRegisterError(Object error) {
    log(error.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return createRegisterErrorDialog(context).build(context);
        },
        barrierDismissible: false);
  }

  AlertDialog createRegisterErrorDialog(BuildContext context) {
    return AlertDialog(
        title: Text("Register unsuccessful"),
        content: Text("There is already a user with that username"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            textColor: Colors.blue,
            onPressed: () {},
          )
        ],
        elevation: 24.0);
  }

  void enableRegister() {
    setState(() {
      loginState = false;
    });
  }

  void register() {
    String password = passwordTextController.text;
    String confirmPassword = confirmPasswordTextController.text;
    String username = emailTextController.text;

    if (password == null || confirmPassword == null || username == null) {
      return;
    }

    if (password.isEmpty || confirmPassword.isEmpty || username.isEmpty) {
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        confirmErrorText = "Passwords do not match";
      });
      // confirmPasswordTextController.addListener(() {
      //   setState(() {
      //     confirmErrorText = null;
      //   });
      //   confirmPasswordTextController.removeListener(() {});
      // });
      return;
    }

    loginService
        .registerAccount(emailTextController.text, passwordTextController.text)
        .then(onRegisterSuccess)
        .catchError(onRegisterError);
  }

  void goToMain() {
    Navigator.pushNamedAndRemoveUntil(
        context, MainView.routeName, ModalRoute.withName(LoginView.routeName));
  }
}
