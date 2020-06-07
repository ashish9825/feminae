import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Position _currentPosition;
  String currentAddress;

  var geolocator = Geolocator();

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = _currentPosition.latitude;
      longitude = _currentPosition.longitude;
    } catch (e) {
      print(e);
    }
  }

  getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, lng);

      Placemark place = p[0];
      currentAddress =
          "${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
    } catch (e) {
      print(e);
    }
  }

  Future<String> getLastKnownLocation() async {
    try {
      _currentPosition = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      currentAddress =
          "${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
    } catch (e) {
      print(e);
    }
    return currentAddress;
  }
}
