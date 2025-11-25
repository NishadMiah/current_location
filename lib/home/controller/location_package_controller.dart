import 'package:get/get.dart';
import 'package:location/location.dart' as loc;

class LocationPackageController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var locationMessage = "Press the button to get location".obs;

  final loc.Location _location = loc.Location();

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    try {
      // Check if location service is enabled
      serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          locationMessage.value = "Location services are disabled.";
          return;
        }
      }

      // Check permissions
      permissionGranted = await _location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          locationMessage.value = "Location permissions are denied.";
          return;
        }
      }

      // Get current location with timeout
      locationMessage.value = "Getting location...";

      loc.LocationData locationData = await _location.getLocation().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Timeout: Could not get location in 10 seconds');
        },
      );

      latitude.value = locationData.latitude ?? 0.0;
      longitude.value = locationData.longitude ?? 0.0;
      locationMessage.value = "Location retrieved (location package)";
    } catch (e) {
      locationMessage.value = "Failed to get location: $e";
    }
  }
}
