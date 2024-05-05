import 'package:get/get.dart';
import 'package:smart_water_meter/authetication/AutheticationRepository.dart';
import 'package:smart_water_meter/pages/home_page.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomePage()) : Get.back();
  }


}