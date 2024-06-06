import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_water_meter/pages/home_page.dart';
import 'package:smart_water_meter/pages/verification_page.dart';

import '../pages/welcome_page.dart';



class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  DatabaseReference _testRef=FirebaseDatabase.instance.ref().child('users');


  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId=''.obs;


  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }


  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomePage()) : Get.offAll(() => const HomePage());
  }



  Future<String?> loginWithEmailAndPassword(String email, String password,BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // Display snackbar if email or password is incorrect
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email or password is incorrect'),
          ),
        );
      }
    } catch (_) {
    }
    return null;
  }

  Future<void> phoneAuthetication() async {
  final phoneData=await  _testRef.child(_auth.currentUser!.uid).child('0784901461').get();
  String phone=phoneData.value.toString();
  await  _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId,resentToken){
          this.verificationId.value=verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value=verificationId;
        },
        verificationFailed: (e){
          Get.snackbar('Error', 'Something went wrong try again');
        },
    );
  }

  Future<bool> verifyOTP(String otp) async{
    var credentials=await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
        verificationId: this.verificationId.value,
        smsCode: otp
    ));

    return credentials.user != null? true :false;
  }

  Future<void> logout() async => await _auth.signOut();
}