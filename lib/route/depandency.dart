import 'package:get/get.dart';
import 'package:offline_location/home/controller/location_controller.dart';
import 'package:offline_location/home/controller/location_package_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController(), fenix: true);
    Get.lazyPut(() => LocationPackageController(), fenix: true);
  }
}
