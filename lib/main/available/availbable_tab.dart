import 'package:flutter/material.dart';
import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/domain/parking.dart';
import 'package:parking_app/service/parking_service.dart';

// ignore: must_be_immutable
class AvailableTab extends StatefulWidget {
  ParkingService parkingService;

  AvailableTab() {
    parkingService = locator<ParkingService>();
  }

  @override
  _AvailableTabState createState() => _AvailableTabState(parkingService);
}

class _AvailableTabState extends State<AvailableTab>
    with WidgetsBindingObserver {
  ParkingService parkingService;
  List<Parking> _parkings;

  _AvailableTabState(this.parkingService);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _parkings = parkingService.getParkings();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _parkings = parkingService.getParkings();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _parkings
          .map((element) => Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              element.location,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 16.0),
                            )),
                          ],
                        )),
                  ],
                ),
              )))
          .toList(),
    );
  }
}
