import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_water_meter/models/payment_model.dart';
import 'package:intl/intl.dart';
import '../components/confirm_pay_bill_widget.dart';

class PayBillsPage extends StatefulWidget {
  const PayBillsPage({Key? key}) : super(key: key);

  @override
  State<PayBillsPage> createState() => _PayBillsPageState();
}

class _PayBillsPageState extends State<PayBillsPage> {
  final double _water_units = 12;
  TextEditingController payment_no_controller = TextEditingController();
  TextEditingController control_no_controller = TextEditingController();
  TextEditingController water_amount_controller = TextEditingController();
  TextEditingController water_units_controller = TextEditingController();
  DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('bills');
  final _auth = FirebaseAuth.instance;
  late String _currency = "TSH";
  late String _amount = '1000';
    String _randomControlNumber = '';

  Map<double, double> water_units_payment = {1000: 1, 2000: 2, 3000: 3};

 void _generateRandomControlNumber() {
    final random = Random();
    setState(() {
      _randomControlNumber = List.generate(11, (_) => random.nextInt(10)).join(); // Generate a six-digit number
    });
    control_no_controller.text=_randomControlNumber;
  }


  

  @override
  void initState() {
    super.initState();
    _generateRandomControlNumber();
    water_amount_controller.text='1000';
  }
  @override
  Widget build(BuildContext context) {
    water_units_controller.text =
                          '${double.parse(water_amount_controller.text) / 1000}'; // assumed 1 unit=Tsh 1000
                      
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bill'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 40),
          const Text(
            "Payment number",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: payment_no_controller,
            decoration: InputDecoration(
                hintText: "enter payment number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey))),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Control number",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: control_no_controller,
            readOnly: true,
            decoration: InputDecoration(
                hintText: "enter control number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey))),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Amounts",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              // First text box taking 3/4th of the width
              Expanded(
                flex: 3,
                child: DropdownButton<String>(
                  value: _amount, // Default currency is TSH
                  onChanged: (String? newValue) {
                    // You can handle currency selection here
                    setState(() {
                      _amount = newValue!;
                     water_amount_controller.text=newValue!;
                      print('water_units_controller.text');
                    });
                  },
                  items: <String>[
                    '1000',
                    '2000',
                    '3000',
                    '4000',
                    '5000',
                    '6000',
                    '7000',
                    '8000',
                    '9000',
                    '10000'
                  ] // Add more currencies as needed
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                  width: 10.0), // Adding some space between the text boxes
              // Second text box taking 1/4th of the width
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    value: _currency, // Default currency is TSH
                    onChanged: (String? newValue) {
                      // You can handle currency selection here
                      setState(() {
                        _currency = newValue!;
                      });
                      print('Selected currency: $newValue');
                    },
                    items: <String>[
                      'TSH',
                      'USD',
                      'EUR',
                      'GBP'
                    ] // Add more currencies as needed
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Units",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: water_units_controller,
            // readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: ()  {
                    // Get the current date and time
                     DateTime now = DateTime.now();
                    // TODO: add the units really
                    final payment = PaymentModel(
                        amount: double.parse(water_amount_controller.text),
                        controlNo: control_no_controller.text,
                        paymentNo: payment_no_controller.text,
                        units: double.parse(water_units_controller.text),
                        date: DateFormat('yyyy-MM-dd HH:mm').format(now)
                        );
                 
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return  ConfirmPayBillWidget(
                          payment: payment,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50), // Increase padding here
                  ),
                  child: const Text("Pay"),
                ),
              ),
            ],
          )
        ]),
      ),
    );

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    control_no_controller.dispose();
    payment_no_controller.dispose();
    water_amount_controller.dispose();
    water_units_controller.dispose();
  }
}
