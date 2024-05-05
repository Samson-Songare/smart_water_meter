import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_water_meter/constants/colors.dart';
import 'package:smart_water_meter/pages/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // navigating to welcome screen after three seconds
    Timer(
      const Duration(seconds: 5),
      () {
        Get.to(const WelcomePage());

      },
    );
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: const Center(
        child: Text(
          "WaterTrack App",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
