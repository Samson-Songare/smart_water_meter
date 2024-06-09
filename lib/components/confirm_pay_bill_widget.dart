import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_water_meter/models/payment_model.dart';

import 'mobile_money_password_bottom_sheet.dart';

class ConfirmPayBillWidget extends StatelessWidget {
   ConfirmPayBillWidget({
    super.key,
    required this.payment
  });

  PaymentModel payment;

  DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('bills');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Are you sure?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('No'),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                     DateTime now = DateTime.now();
                        _testRef
                        .child(_auth.currentUser!.uid)
                        .child(DateFormat('yyyy-MM-dd').format(now))
                        .update(payment.toJson());
                    Navigator.of(context).pop();
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return MobileMoneyPasswordBottomSheet();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Yes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
