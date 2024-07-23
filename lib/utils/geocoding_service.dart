import 'package:geocoding/geocoding.dart';

class GeocodingService{
  static Future<String> getAddressFromCoordinates(double lat, double lng) async{
    List<Placemark>placemarks = await placemarkFromCoordinates(lat, lng);
    if(placemarks.isNotEmpty){
      Placemark place = placemarks.first;
      return '${place.locality}, ${place.country}';
    }

    return 'Unkown location';
  }
}