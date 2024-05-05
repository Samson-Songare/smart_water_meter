

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_water_meter/models/user_model.dart';

class UserReposiroty extends GetxController{
  static UserReposiroty get instance =>Get.find();

  final _db=FirebaseFirestore.instance;

  createUser(UserModel user) async {

    await _db.collection('users').add(user.toJson())
    .whenComplete(() => Get.snackbar('Success', 'Successfully updated user information',
    snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green
    ))
    .catchError((error,stackTrace){
      Get.snackbar('Error', 'Something went Wrong try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red
      );
      print(error);
    });
  }
}