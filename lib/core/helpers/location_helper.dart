import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medina_stores/core/navigation/navigator.dart';

class LocationHelper {
  static LatLngBounds calculateBounds(List<LatLng> latLngs) {
    final minLatitude = latLngs.map((e) => e.latitude).reduce((value, element) => value < element ? value : element);
    final maxLatitude = latLngs.map((e) => e.latitude).reduce((value, element) => value > element ? value : element);
    final minLongitude = latLngs.map((e) => e.longitude).reduce((value, element) => value < element ? value : element);
    final maxLongitude = latLngs.map((e) => e.longitude).reduce((value, element) => value > element ? value : element);
    final min = LatLng(minLatitude, minLongitude);
    final max = LatLng(maxLatitude, maxLongitude);
    final bounds = LatLngBounds(southwest: min, northeast: max);
    return bounds;
  }

  static double calculateDistanceInKM(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters / 1000;
  }

  static Future<Position?> getCurrentPosition() async {
    final permissionStatus = await Geolocator.checkPermission();
    if (permissionStatus == LocationPermission.denied) {
      final requestedPermission = await Geolocator.requestPermission();
      if (requestedPermission == LocationPermission.denied) {
        // Handle the case where the user denied the permission
        showPermissionDeniedDialog();
        return null;
      }
    }

    if (permissionStatus == LocationPermission.deniedForever) {
      // Handle the case where the user denied the permission permanently
      showPermissionDeniedForeverDialog();
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  static void showPermissionDeniedDialog() {
    showDialog(
      context: AppNavigator.navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content: const Text('Please enable location permission to use this feature.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showPermissionDeniedForeverDialog() {
    showDialog(
      context: AppNavigator.navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied Forever'),
        content: const Text('Please enable location permission from settings to use this feature.'),
        actions: [
          TextButton(
            onPressed: () async => await Geolocator.openAppSettings(),
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
