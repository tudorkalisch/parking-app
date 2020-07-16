import 'package:parking_app/service/booking_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(BookingService());
}
