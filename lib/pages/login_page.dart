import 'package:flutter/material.dart';
import 'package:smart_water_meter/authetication/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePassword = true;
  bool _savePassword = false;

  @override
  Widget build(BuildContext context){
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.email,
                  decoration: InputDecoration(
                      hintText: "0********",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.password,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                      hintText: "Atleast 8 characters",
                      suffixIcon: IconButton(
                        icon: Icon(_hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _savePassword,
                          onChanged: (value) {
                            setState(() {
                              _savePassword = !_savePassword;
                            });
                          },
                        ),
                        const Text("Save Password")
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        //todo: implement Forgot password here
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                       controller.login(context);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Text(
                          "Login",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
