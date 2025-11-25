import 'package:get/get.dart';
import 'package:offline_location/home/view/home_screen.dart';

class AppRoutes {
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
