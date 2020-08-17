import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/domain/booking.dart';
import 'package:parking_app/domain/location.dart';
import 'package:parking_app/service/preference_settings.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

class PaymentView extends StatefulWidget {
  final Function onPaymentComplete;
  final Location currentLocation;
  final Booking currentBooking;

  PaymentView(
      this.onPaymentComplete, this.currentLocation, this.currentBooking);

  @override
  PaymentState createState() {
    return new PaymentState(onPaymentComplete);
  }
}

class PaymentState extends State<PaymentView> {
  Function onPaymentComplete;

  String amountLabelByPremium = "Amount: ";
  String amountTextByPremium = "Amount: ";

  PaymentState(this.onPaymentComplete);

  void _pay() {
    InAppPayments.setSquareApplicationId(
        "sandbox-sq0idb-tnVEE-Lx-gwCRKgpkPkJIA");
    InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _cardNonceRequestSuccess,
        onCardEntryCancel: _onCardEntryCancel);
  }

  void _onCardEntryCancel() {}

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

  void setBookingInCalendar(PaymentView widget) async {
    await DeviceCalendarPlugin().retrieveCalendars().then((value) => {
          DeviceCalendarPlugin()
              .createOrUpdateEvent(new Event(value.data.elementAt(0).id,
                  title: "Booking at " + widget.currentBooking.location.name,
                  start: widget.currentBooking.startTime,
                  end: widget.currentBooking.endTime,
                  description: "You have a parking booking at " +
                      widget.currentBooking.location.name))
              .then((value) => print("Success"))
        });
  }

  AlertDialog _createPaymentCofirmationDialog(BuildContext context) {
    return AlertDialog(
        title: Text("Payment Succesful"),
        content: Text("Do you want to save this booking to your calendar?"),
        actions: <Widget>[
          FlatButton(
            child: Text("No"),
            onPressed: () => {Navigator.pop(context), onPaymentComplete()},
            textColor: Colors.blue,
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () => {
              Navigator.pop(context),
              setBookingInCalendar(widget),
              onPaymentComplete()
            },
            textColor: Colors.blue,
          )
        ],
        elevation: 24.0);
  }

  @override
  Widget build(BuildContext context) {
    genereateTextForPremium();
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
                              text: widget.currentBooking.startTime.hour
                                      .toString() +
                                  ":" +
                                  formatMinutes(
                                      widget.currentBooking.startTime.minute),
                              style: TextStyle(fontSize: 20))
                        ]),
                  ),
                ],
              )),
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
                              text: "To: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          TextSpan(
                              text: widget.currentBooking.endTime.hour
                                      .toString() +
                                  ":" +
                                  formatMinutes(
                                      widget.currentBooking.endTime.minute),
                              style: TextStyle(fontSize: 20))
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
                          TextSpan(
                              text: (widget.currentBooking.endTime.hour -
                                      widget.currentBooking.startTime.hour)
                                  .toString(),
                              style: TextStyle(fontSize: 20))
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
                          TextSpan(
                              text: amountTextByPremium,
                              style: TextStyle(fontSize: 20))
                        ]),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  String formatMinutes(int minutes) {
    if (minutes < 10) {
      return "0" + minutes.toString();
    }

    return minutes.toString();
  }

  void genereateTextForPremium() async {
    if (await SharedPrefs.getIsPremium()) {
      setState(() {
        amountTextByPremium = (widget.currentLocation.price *
                        (widget.currentBooking.endTime.hour -
                            widget.currentBooking.startTime.hour) -
                    (widget.currentLocation.price *
                            (widget.currentBooking.endTime.hour -
                                widget.currentBooking.startTime.hour)) *
                        0.15)
                .toString() +
            "\$";
      });
    } else {
      setState(() {
        amountTextByPremium = (widget.currentLocation.price *
                    (widget.currentBooking.endTime.hour -
                        widget.currentBooking.startTime.hour))
                .toString() +
            "\$";
      });
    }
  }
}
