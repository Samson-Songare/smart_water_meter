import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:smart_water_meter/authetication/AutheticationRepository.dart';
import 'package:smart_water_meter/authetication/controllers/otp_controller.dart';
import 'package:smart_water_meter/pages/home_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
// variable to hold entered code
final controller=Get.put(OTPController());
final autheticationRepo=Get.put(AuthenticationRepository());

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateOTP();
  }

void generateOTP() async {
 await autheticationRepo.phoneAuthetication();
}
  @override
  Widget build(BuildContext context) {
    var otp;
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the desired image size based on the screen width
    double imageSize = screenWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [

          Image.asset(
            'images/verify_code.png',
            height: imageSize,
            width: imageSize,
          ),
          const Text(
            "Verify Your Phone",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Please enter the 4 digit code sent to your registered phone number",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        // pin_code field
          PinCodeTextField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            autofocus: true,
            hideCharacter: false,
            pinBoxRadius: 12,
            highlight: true,
            highlightColor: Colors.blue,
            defaultBorderColor: Colors.black,
            hasTextBorderColor: Colors.green,
            pinBoxWidth: 55,
            pinBoxHeight: 55,
            onTextChanged: (code) {
             otp=code;
             controller.verifyOTP(otp);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the radius as needed
            ),
            width: 327,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              onPressed: () {
                // verify entered digit codes
                controller.verifyOTP(otp);
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ]),
      ),
    );


  }
}
