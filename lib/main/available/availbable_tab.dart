import 'package:flutter/material.dart';
import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/domain/location.dart';
import 'package:parking_app/main/available/location_card.dart';
import 'package:parking_app/service/location_service.dart';

// ignore: must_be_immutable
class AvailableTab extends StatefulWidget {
  LocationService locationService;
  Function goToSchedule;

  AvailableTab(BuildContext context, Function goToSchedule) {
    locationService = locator<LocationService>();
    this.goToSchedule = goToSchedule;
  }

  @override
  _AvailableTabState createState() =>
      _AvailableTabState(goToSchedule, locationService);
}

class _AvailableTabState extends State<AvailableTab>
    with WidgetsBindingObserver {
  LocationService locationService;
  Function goToSchedule;
  List<Location> _locations = List.empty();

  _AvailableTabState(this.goToSchedule, this.locationService);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationService.getLocations().then((locations) => setState(() {
            _locations = locations;
          }));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      locationService.getLocations().then((locations) => setState(() {
            _locations = locations;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _locations
          .map((element) => LocationCard(element, goToSchedule))
          .toList(),
    );
  }
}
