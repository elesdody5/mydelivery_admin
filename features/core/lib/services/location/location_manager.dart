import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

abstract class LocationManager {
  Future<LocationData?> getLocation();

  Future<String?> getUserAddress();
}

class LocationManagerImp implements LocationManager {
  final Location _location;

  LocationManagerImp({Location? location}) : _location = location ?? Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  Future<bool> _checkServiceEnable() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  @override
  Future<LocationData?> getLocation() async {
    var enabled = await _checkServiceEnable();
    if (enabled) {
      _location.changeSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 50);
      _locationData = await _location.getLocation();
      return _locationData;
    }
    return null;
  }

  @override
  Future<String?> getUserAddress() async {
    if (_checkHasLocationData()) {
      List<geo.Placemark> placeMarks = await geo.placemarkFromCoordinates(
          _locationData!.latitude!, _locationData!.longitude!,
          localeIdentifier: "ar");
      geo.Placemark placeMark = placeMarks.first;
      String address = "${placeMark.locality} , ${placeMark.thoroughfare}";
      return address;
    }
    return null;
  }

  bool _checkHasLocationData() =>
      _locationData != null &&
      _locationData?.latitude != null &&
      _locationData?.longitude != null;
}
