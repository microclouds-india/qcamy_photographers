// import 'package:flutter/services.dart';
// import 'package:geocode/geocode.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getLocation() async {
    try {
      Position position = await determinePosition();
      return position;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future getAddress() async {
  //   try {
  //     Position position = await getLocation();
  //     GeoCode geoCode = GeoCode();
  //     Address address = await geoCode.reverseGeocoding(
  //         latitude: position.latitude, longitude: position.longitude);

  //     return "${address.streetAddress},${address.city}";
  //   } catch (e) {
  //     print("location error: $e");
  //     if (!(await Geolocator.isLocationServiceEnabled())) {
  //       return "Get your location";
  //     }
  //     return "...";
  //   }
  // }

  Future getLocationAddress() async {
    try {
      Position position = await getLocation();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks[0].locality;
      // final state = placemarks[0].administrativeArea;
      final district = placemarks[0].subAdministrativeArea;

      return "$place,$district";
    } on PlatformException {
      return "...";
    } catch (e) {
      // print(e);
      return Future.error(e);
    }
  }
}
