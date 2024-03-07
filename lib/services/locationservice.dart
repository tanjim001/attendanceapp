import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  late LocationData _locData;
  Future<Map<String, double?>?> initializeandGetLocation(context) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    //checking location enabled or not
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    //if sevice enabled then ask permission for location
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    _locData = await location.getLocation();
    return {'latitude': _locData.latitude, 'longitude': _locData.longitude};
  }
}
