import 'package:flutter/material.dart';
import 'package:smart_water_meter/pages/pay_bills_page.dart';

class ViewBillsPage extends StatelessWidget {
  const ViewBillsPage({Key? key}) : super(key: key);
  final double totalUnits = 120;
  final double usedUnits = 80;

  @override
  Widget build(BuildContext context) {
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
        Text(
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
            Expanded(
              child: const Column(
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
  final List<Map<String, dynamic>> dataList = [
    {'date': '2024-04-10', 'unitsUsed': 50.0, 'amount': 25.0},
    {'date': '2024-04-11', 'unitsUsed': 60.0, 'amount': 30.0},
    {'date': '2024-04-12', 'unitsUsed': 55.0, 'amount': 27.5},
    {'date': '2024-04-10', 'unitsUsed': 50.0, 'amount': 25.0},
    {'date': '2024-04-11', 'unitsUsed': 60.0, 'amount': 30.0},
    {'date': '2024-04-12', 'unitsUsed': 55.0, 'amount': 27.5},
    {'date': '2024-04-10', 'unitsUsed': 50.0, 'amount': 25.0},
    {'date': '2024-04-11', 'unitsUsed': 60.0, 'amount': 30.0},
    {'date': '2024-04-12', 'unitsUsed': 55.0, 'amount': 27.5},
    {'date': '2024-04-10', 'unitsUsed': 50.0, 'amount': 25.0},
    {'date': '2024-04-11', 'unitsUsed': 60.0, 'amount': 30.0},
    {'date': '2024-04-12', 'unitsUsed': 55.0, 'amount': 27.5},
    {'date': '2024-04-10', 'unitsUsed': 50.0, 'amount': 25.0},
    {'date': '2024-04-11', 'unitsUsed': 60.0, 'amount': 30.0},
    {'date': '2024-04-12', 'unitsUsed': 55.0, 'amount': 27.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> data = dataList[index];
          final String date = data['date'];
          final double unitsUsed = data['unitsUsed'];
          final double amount = data['amount'];

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
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Total Units: $unitsUsed',
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
                        '\$$amount',
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
