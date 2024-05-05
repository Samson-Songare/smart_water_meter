import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/confirm_pay_bill_widget.dart';

class PayBillsPage extends StatefulWidget {
  const PayBillsPage({Key? key}) : super(key: key);



  @override
  State<PayBillsPage> createState() => _PayBillsPageState();
}

class _PayBillsPageState extends State<PayBillsPage> {
  final double _water_units = 12;
  TextEditingController payment_no_controller=TextEditingController();
  TextEditingController control_no_controller=TextEditingController();
  TextEditingController water_amount_controller=TextEditingController();

  late String _currency = "TSH";

  Map<double,double> water_units_payment={
    1000:1,
    2000:2,
    3000:3
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bill'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView( children: [
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
                  value: _currency, // Default currency is TSH
                  onChanged: (String? newValue) {
                    // You can handle currency selection here
                    setState(() {
                      _currency = newValue!;
                    });

                  },
                  items: <String>[
                    '1000',
                    '2000',
                    '3000',
                    '4000'
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
            controller: water_amount_controller,
            readOnly: true,
            initialValue: "$_water_units",
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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const ConfirmPayBillWidget();
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
}
