import 'package:parking_app/domain/parking.dart';

class ParkingService {
  ParkingService() {
    _parkings = [Parking.empty()];
  }

  List<Parking> _parkings;

  List<Parking> getParkings() => _parkings;
}
