import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_water_meter/authetication/AutheticationRepository.dart';
import 'package:smart_water_meter/authetication/user_repository.dart';
import 'package:smart_water_meter/models/user_model.dart';
import 'package:smart_water_meter/pages/home_page.dart';
import 'package:smart_water_meter/pages/verification_page.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();



  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> login(BuildContext context) async {
  String? error = await AuthenticationRepository.instance.loginWithEmailAndPassword(
    'samsloyshock@gmail.com',
    '12345678',
    context,
  );

  // Clear the text fields
  email.text = '';
  password.text = '';

  if (error != null) {
    Get.snackbar(
      'Error',
      'Something went wrong, try again',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red,
    );
  } else {
    Get.offAll(() => const HomePage());
  }
}


  void createUser(UserModel user) async {
   await UserReposiroty.instance.createUser(user);

  }

}