import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

class PaymentView extends StatefulWidget {
  final Function onPaymentComplete;

  PaymentView(this.onPaymentComplete);

  @override
  PaymentState createState() {
    return new PaymentState(onPaymentComplete);
  }
}

class PaymentState extends State<PaymentView> {
  Function onPaymentComplete;

  PaymentState(this.onPaymentComplete);

  void _pay() {
    InAppPayments.setSquareApplicationId(
        "sandbox-sq0idb-tnVEE-Lx-gwCRKgpkPkJIA");
    InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _cardNonceRequestSuccess,
        onCardEntryCancel: _onCardEntryCancel);
  }

  void _onCardEntryCancel() {
    //TODO Cancel card entry
  }

  void _cardNonceRequestSuccess(CardDetails cardDetails) {
    print(cardDetails.nonce);

    InAppPayments.completeCardEntry(onCardEntryComplete: _cardEntryComplete);
  }

  void _cardEntryComplete() {
    _showPaymentSuccesfulDialog();
    print("Card payment complete");
  }

  void _showPaymentSuccesfulDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _createPaymentCofirmationDialog(context).build(context);
        },
        barrierDismissible: false);
  }

  AlertDialog _createPaymentCofirmationDialog(BuildContext context) {
    return AlertDialog(
        title: Text("Payment Succesful"),
        content: Text("Your payment was successful"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: onPaymentComplete,
            textColor: Colors.blue,
          )
        ],
        elevation: 24.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.lightBlue),
              child:
                  IconButton(icon: Icon(Icons.credit_card), onPressed: _pay)),
          Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: "From: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          TextSpan(
                              text: "10:30", style: TextStyle(fontSize: 20))
                        ]),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Hours: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          TextSpan(text: "3", style: TextStyle(fontSize: 20))
                        ]),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Amount: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          TextSpan(text: "10\$", style: TextStyle(fontSize: 20))
                        ]),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
