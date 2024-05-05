import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_water_meter/authetication/controllers/login_controller.dart';
import 'package:smart_water_meter/models/user_model.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();


}

class _PersonalDetailsState extends State<PersonalDetails> {

  DatabaseReference _testRef=FirebaseDatabase.instance.ref().child('users');
  final _auth = FirebaseAuth.instance;
  final controller = Get.put(LoginController());
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     fetchUserDetails();

  }

  void fetchUserDetails() async {
    final username=await _testRef.child(_auth.currentUser!.uid).child('firstname').get();
    firstNameController.text=username.value.toString();

    final email=await _testRef.child(_auth.currentUser!.uid).child('email').get();
    emailController.text=email.value.toString();

    final surname=await _testRef.child(_auth.currentUser!.uid).child('surname').get();
    surnameController.text=surname.value.toString();

    final phone=await _testRef.child(_auth.currentUser!.uid).child('phone').get();
    phoneController.text=phone.value.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Account",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      "Firstname",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Surname",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: surnameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "email",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      "Phone number",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    // todo: later add passord field and retrieves its value here
                    final user=UserModel(firstName: firstNameController.text, surname: surnameController.text,
                        email: emailController.text, phone: phoneController.text, password: '12333243');

                  // //   put data to firestore
                  // controller.createUser(user);

                    _testRef.child(_auth.currentUser!.uid).update(user.toJson());

                  },
                  child: Text('Apply'),
                ),
              ),
            ]),
      ),
    );
  }
}
