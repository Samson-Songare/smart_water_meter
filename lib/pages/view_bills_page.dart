import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_water_meter/pages/pay_bills_page.dart';

class ViewBillsPage extends StatefulWidget {
  ViewBillsPage({Key? key}) : super(key: key);

  @override
  State<ViewBillsPage> createState() => _ViewBillsPageState();
}

class _ViewBillsPageState extends State<ViewBillsPage> {
  double totalUnits = 40;
  double remainingUnits = 20;
  double usedUnits = 20;
  Map<Object?, Object?> rawMap = {};

  List<Map<Object?, Object?>> filteredEntries = [];
  final _auth = FirebaseAuth.instance;

  DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('bills');
  DatabaseReference _usersData =
      FirebaseDatabase.instance.ref().child('users').child('mtui');

  DateTime now = DateTime.now();

  void fetchBills() async {
    DataSnapshot snapshot = await _testRef.child('mtui').get();
    rawMap = snapshot.value as Map<Object?, Object?>;

    if (rawMap != null) {
      rawMap.forEach((key, value) {
        if (key.toString().startsWith('2024')) {
          Map<Object?, Object?> entry = value as Map<Object?, Object?>;
          setState(() {
            filteredEntries.add(entry);
          });
        }
      });

      // getting the total units bought from the begenning
      setState(
        (){
         totalUnits=double.parse(rawMap['total_units_bought'].toString());
        }
      );
    }

  }

  @override
  void initState() {
    super.initState();

    fetchBills();
  }

  @override
  Widget build(BuildContext context) {
    // final double remainingUnits = totalUnits - usedUnits;
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
          BillsList(
            dataList: filteredEntries,
          )
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

class ViewBillsFirstContainer extends StatefulWidget {
  ViewBillsFirstContainer({
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
  State<ViewBillsFirstContainer> createState() =>
      _ViewBillsFirstContainerState();
}

class _ViewBillsFirstContainerState extends State<ViewBillsFirstContainer> {
  DatabaseReference _usersData =
      FirebaseDatabase.instance.ref().child('users').child('mtui');
  double remainingUnit = 0;
  Map<Object?, Object?> userData = {};
  void fetchUserInfo() async {
    DataSnapshot snapshot1 = await _usersData.get();
    userData = snapshot1.value as Map<Object?, Object?>;

    setState(() {
      remainingUnit = double.parse(userData['Units'].toString()!);
    });

    print(remainingUnit);
  }


  @override
  void initState() {
    super.initState();

    fetchUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: widget.screeWidth,
      height: widget.screeWidth * 0.5,
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
                    '${widget.totalUnits} Units',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    '${widget.totalUnits- remainingUnit} Units',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    '${remainingUnit} Units',
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
              value: (widget.totalUnits-remainingUnit)/widget.totalUnits, // Percentage of water used
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
  BillsList({super.key, required this.dataList});

  final List<Map<dynamic, dynamic>> dataList;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print('dataList.length: ${dataList.length}');
    return Expanded(
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
  }
}
