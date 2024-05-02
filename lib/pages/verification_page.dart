import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:smart_water_meter/pages/home_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
// variable to hold entered code
  String _enteredCode = "";
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the desired image size based on the screen width
    double imageSize = screenWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
      ),
      body: Column(children: [
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
          "Please enter the 4 digit code sent to 505-287-8051",
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
            setState(() {
              _enteredCode = code;
            });
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
              //TODO: change this latter to verify entered digit codes
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
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
    );
  }
}
