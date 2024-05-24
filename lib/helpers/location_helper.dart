import 'package:geocoding/geocoding.dart';

class LocationHelper {
  static Future<List<String>> getLatLngFromAddress(String address) async {
    List<Location> location =
        await GeocodingPlatform.instance!.locationFromAddress(address);

    double lat = location.first.latitude;
    double lng = location.first.longitude;

    return ["$lat", "$lng"];
  }
}
