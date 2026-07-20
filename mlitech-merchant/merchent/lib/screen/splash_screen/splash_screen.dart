import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constant/app_color/app_color.dart';
import '../common_widget/dev_logo_text.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.put(SplashController());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return AnnotatedRegion(
          value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
          child: Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: Image.asset(
              "assets/images/merchant-loader.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      },
    );
  }
}
