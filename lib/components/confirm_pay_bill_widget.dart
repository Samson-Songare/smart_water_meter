import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_water_meter/models/payment_model.dart';

import 'mobile_money_password_bottom_sheet.dart';

class ConfirmPayBillWidget extends StatefulWidget {
   ConfirmPayBillWidget({
    super.key,
    required this.payment
  });

  PaymentModel payment;

  @override
  State<ConfirmPayBillWidget> createState() => _ConfirmPayBillWidgetState();
}

class _ConfirmPayBillWidgetState extends State<ConfirmPayBillWidget> {
  DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('bills');

  final _auth = FirebaseAuth.instance;

 DatabaseReference _usersData =
      FirebaseDatabase.instance.ref().child('users').child('mtui');

  double remainingUnit = 0;
  double total_units_bought=0;

  Map<Object?, Object?> userData = {};
  Map<Object?, Object?> billlsData = {};

  void fetchUserInfo() async {
    DataSnapshot snapshot1 = await _usersData.get();
    userData = snapshot1.value as Map<Object?, Object?>;

      remainingUnit = double.parse(userData['Units'].toString()!);
   
    print(remainingUnit);

    // fetching the total_units_bought
    DataSnapshot snapshot = await _testRef.child('mtui').get();
    billlsData = snapshot.value as Map<Object?, Object?>;
    setState(() {
      total_units_bought=double.parse(billlsData['total_units_bought'].toString());
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3571129684.
    });
    print(total_units_bought);
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }


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
                        .child('mtui')
                        .child(DateFormat('yyyy-MM-dd HH:mm').format(now))
                        .update(widget.payment.toJson());
                    double amount=widget.payment.units!;
                    // adding the amount of water units billed to the remaining
                    // units
                    remainingUnit+=amount;
                    // updating the total units bought when adding another bill
                    total_units_bought+=amount;
                    _usersData.update({'Units':remainingUnit});
                    _testRef.child('mtui').update({'total_units_bought':total_units_bought});
                    // closing the bottom sheet
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
