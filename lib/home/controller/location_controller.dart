import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var locationMessage = "Press the button to get location".obs;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationMessage.value = "Location services are disabled.";
      return;
    }

    // Check permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationMessage.value = "Location permissions are denied.";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationMessage.value = "Location permissions are permanently denied.";
      return;
    }

    // Try to get the last known position first (faster, works offline if cached)
    Position? lastPosition = await Geolocator.getLastKnownPosition();
    if (lastPosition != null) {
      latitude.value = lastPosition.latitude;
      longitude.value = lastPosition.longitude;
      locationMessage.value = "Location retrieved (Last Known)";
    }

    try {
      // Get current position with a timeout using LocationSettings
      // In geolocator 14.x, timeLimit is configured via LocationSettings
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;
      locationMessage.value = "Location retrieved (Current)";
    } catch (e) {
      if (lastPosition != null) {
        // We already showed last known, just update message
        locationMessage.value =
            "Using last known location. Error getting current: $e";
      } else {
        locationMessage.value = "Failed to get location: $e";
      }
    }
  }
}
