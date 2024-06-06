import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_water_meter/authetication/AutheticationRepository.dart';
import 'package:smart_water_meter/authetication/user_repository.dart';
import 'package:smart_water_meter/models/user_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();



  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> login(BuildContext context) async {
    String? error = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim(),context);
    email.text='';
    password.text='';

    if(error != null) {
      Get.snackbar('Error', 'Something went Wrong try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red
      );

    }

  }

  void createUser(UserModel user) async {
   await UserReposiroty.instance.createUser(user);

  }

}