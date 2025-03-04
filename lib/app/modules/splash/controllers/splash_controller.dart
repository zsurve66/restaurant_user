import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:restaurant_user/app/routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  Future<void> onInit() async {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.forward();
    await initFunction();
  }

  Future<void> initFunction() async {
    await Future.delayed(const Duration(seconds: 3));
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
