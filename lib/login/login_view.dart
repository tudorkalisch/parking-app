import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/login/login_fragment.dart';
import 'package:parking_app/main/main_view.dart';
import 'package:parking_app/service/login_service.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

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
    return WillPopScope(
        onWillPop: () async {
          enableLogin();
          return true;
        },
        child: Scaffold(
            body: Container(
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
                        LoginFragment(this.validateLogin, this.enableRegister),
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
                                    child: Text("Register"))),
                            SizedBox(
                                height: 35,
                                width: 250,
                                child: FlatButton(
                                    onPressed: () {
                                      registerAsPremium();
                                    },
                                    textColor: Colors.white,
                                    child: Text("Register as premium account")))
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

  void onPremiumRegisterSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return createPremiumRegister().build(context);
        },
        barrierDismissible: false);

    setState(() {
      loginState = true;
    });
  }

  AlertDialog createPremiumRegister() {
    return AlertDialog(
        title: Text("Premium account created"),
        content: Text("Congratulations on creating your premium account!"),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            textColor: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        elevation: 24.0);
  }

  void onRegisterError(Object error) {
    log(error.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return createRegisterErrorDialog().build(context);
        },
        barrierDismissible: false);
  }

  AlertDialog createRegisterErrorDialog() {
    return AlertDialog(
        title: Text("Register unsuccessful"),
        content: Text("There is already a user with that username"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            textColor: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        elevation: 24.0);
  }

  void enableRegister() {
    setState(() {
      loginState = false;
    });
  }

  void enableLogin() {
    setState(() {
      loginState = true;
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

      loginService
          .registerAccount(
              emailTextController.text, passwordTextController.text, false)
          .then(onRegisterSuccess)
          .catchError(onRegisterError);
    }
  }

  void registerAsPremium() {
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

      return;
    }

    loginService
        .registerAccount(
            emailTextController.text, passwordTextController.text, true)
        .then(pay)
        .catchError(onRegisterError);
  }

  void pay(bool success) {
    InAppPayments.setSquareApplicationId(
        "sandbox-sq0idb-tnVEE-Lx-gwCRKgpkPkJIA");
    InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _cardNonceRequestSuccess,
        onCardEntryCancel: _onCardEntryCancel);
  }

  void _onCardEntryCancel() {}

  void _cardNonceRequestSuccess(CardDetails cardDetails) {
    print(cardDetails.nonce);

    InAppPayments.completeCardEntry(
        onCardEntryComplete: onPremiumRegisterSuccess);
  }

  void goToMain() {
    Navigator.pushNamedAndRemoveUntil(
        context, MainView.routeName, ModalRoute.withName(LoginView.routeName));
  }
}
