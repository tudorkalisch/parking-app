import 'package:parking_app/service/booking_service.dart';
import 'package:get_it/get_it.dart';
import 'package:parking_app/service/parking_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(BookingService());
  locator.registerSingleton(ParkingService());
}
