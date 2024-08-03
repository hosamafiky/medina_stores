// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medina_stores/core/navigation/navigator.dart';

import '../../config/resources/locale_keys.g.dart';

class LocationException implements Exception {
  final String message;

  const LocationException(this.message);

  @override
  String toString() => message;
}

class LocationHelper {
  static Future<bool> askForLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    }
    return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  }

  static Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check for permissions
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('${LocaleKeys.location_services_disabled.tr()}\n${LocaleKeys.please_enable_location_services_in_settings.tr()}');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return false;
    return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  }

  static Future<Position> getCurrentPosition() async => await Geolocator.getCurrentPosition();

  static Future<Placemark> getPlacemarkFromCoordinates(double latitude, double longitude) async {
    setLocaleIdentifier(AppNavigator.rootContext.locale.languageCode);
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first;
  }

  static LatLng getCenter(LatLngBounds bounds) {
    LatLng center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    return center;
  }

  static LatLngBounds getBoundsFromList(List<LatLng> latLngs) {
    final minLatitude = latLngs.map((e) => e.latitude).reduce((value, element) => value < element ? value : element);
    final maxLatitude = latLngs.map((e) => e.latitude).reduce((value, element) => value > element ? value : element);
    final minLongitude = latLngs.map((e) => e.longitude).reduce((value, element) => value < element ? value : element);
    final maxLongitude = latLngs.map((e) => e.longitude).reduce((value, element) => value > element ? value : element);
    final min = LatLng(minLatitude, minLongitude);
    final max = LatLng(maxLatitude, maxLongitude);
    final bounds = LatLngBounds(southwest: min, northeast: max);
    return bounds;
  }
}
