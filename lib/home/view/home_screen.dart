import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_location/home/controller/location_controller.dart';
import 'package:offline_location/home/controller/location_package_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController geolocatorController =
        Get.find<LocationController>();
    final LocationPackageController locationController =
        Get.find<LocationPackageController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Location Test'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPackageSection(
              title: 'Geolocator Package',
              color: Colors.blue,
              message: geolocatorController.locationMessage,
              latitude: geolocatorController.latitude,
              longitude: geolocatorController.longitude,
              onPressed: () => geolocatorController.getCurrentLocation(),
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 2),
            const SizedBox(height: 24),
            _buildPackageSection(
              title: 'Location Package',
              color: Colors.green,
              message: locationController.locationMessage,
              latitude: locationController.latitude,
              longitude: locationController.longitude,
              onPressed: () => locationController.getCurrentLocation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageSection({
    required String title,
    required Color color,
    required RxString message,
    required RxDouble latitude,
    required RxDouble longitude,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(message.value, style: const TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                "Lat: ${latitude.value.toStringAsFixed(6)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Obx(
              () => Text(
                "Long: ${longitude.value.toStringAsFixed(6)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text("Get Location"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
