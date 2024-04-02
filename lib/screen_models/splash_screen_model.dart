import 'package:get/get.dart';
import 'package:noisie/screens/nav_screen.dart';

class SplashScreenModel extends GetxController {
  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(() => const NavScreen());
  }
}
