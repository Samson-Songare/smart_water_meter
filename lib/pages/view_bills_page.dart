import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_water_meter/pages/pay_bills_page.dart';

class ViewBillsPage extends StatelessWidget {
   ViewBillsPage({Key? key}) : super(key: key);
  final double totalUnits = 120;
  final double usedUnits = 80;
     final _auth = FirebaseAuth.instance;
   DatabaseReference _testRef=FirebaseDatabase.instance.ref().child('bills');

void fetchBills() async{
    DataSnapshot snapshot = await _testRef.child(_auth.currentUser!.uid).get();
  //  print(snapshot.value);
}   

  @override
  Widget build(BuildContext context) {
    // print(_testRef.child(_auth.currentUser!.uid).get());
    fetchBills();
    final double remainingUnits = totalUnits - usedUnits;
    final double percentageUsed = (usedUnits / totalUnits) * 100;
    double screeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "View Bills",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          ViewBillsFirstContainer(
            screeWidth: screeWidth,
            totalUnits: totalUnits,
            usedUnits: usedUnits,
            remainingUnits: remainingUnits,
            percentageUsed: percentageUsed,
          ),
          const SizedBox(
            height: 20.0,
          ),
          BillsList()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the floating action button here
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PayBillsPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ViewBillsFirstContainer extends StatelessWidget {
  const ViewBillsFirstContainer({
    super.key,
    required this.screeWidth,
    required this.totalUnits,
    required this.usedUnits,
    required this.remainingUnits,
    required this.percentageUsed,
  });

  final double screeWidth;
  final double totalUnits;
  final double usedUnits;
  final double remainingUnits;
  final double percentageUsed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: screeWidth,
      height: screeWidth * 0.5,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(children: [
        const Text(
          "YOUR  CURRENT BILL",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "USED",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "REMAINING",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$totalUnits Units',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    '$usedUnits Units',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    '$remainingUnits Units',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 20.0,
            child: LinearProgressIndicator(
              value: percentageUsed / 100, // Percentage of water used
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ),
      ]),
    );
  }
}

class BillsList extends StatelessWidget {
  // Sample data
  final List<Map<dynamic, dynamic>> dataList = [
  
  ];

   final _auth = FirebaseAuth.instance;
 final   DatabaseReference _testRef=FirebaseDatabase.instance.ref().child('bills');
     DateTime now = DateTime.now();

Future<DataSnapshot> fetchBills() async{
  // TODO: add the REALLY DATES
    return _testRef.child(_auth.currentUser!.uid).child('2024-06-08').get();
  //  Map<Object?, Object?> rawMap = snapshot.value as Map<Object?, Object?>;

  //  dataList.add(snapshot.value as Map<dynamic, dynamic>);

}   

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
   future:fetchBills() ,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }else if(snapshot.hasData){
          Map<Object?, Object?> rawMap = snapshot.data!.value as Map<Object?, Object?>;
          dataList.add(rawMap);
        //  print('${dataList[0]} are these');
          return  Expanded(
            child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final item = dataList[index];
                    return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['date'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Total Units: ${item['units']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Tsh. ${item['amount']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text('DONE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
                  },
                ),
          );
        } else {
              return Text('No data available');
            }
        
      },
    );
  }
}
