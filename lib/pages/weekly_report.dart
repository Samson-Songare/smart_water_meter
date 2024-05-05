
import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/water_usage_chart.dart';
import 'package:smart_water_meter/models/water_amount.dart';


class WeeklyReports extends StatefulWidget {
  const WeeklyReports({Key? key}) : super(key: key);

  @override
  State<WeeklyReports> createState() => _WeeklyReportsState();
}

class _WeeklyReportsState extends State<WeeklyReports> {




  //TODO: this is only template delete it later
  final List<WaterAmount> waterAmountList = [
    WaterAmount(day: "MON", amount: 25),
    WaterAmount(day: "TUE", amount: 30),
    WaterAmount(day: "WED", amount: 28),
    WaterAmount(day: "THU", amount: 20),
    WaterAmount(day: "FRI", amount: 32),
    WaterAmount(day: "SAT", amount: 27),
    WaterAmount(day: "SUN", amount: 29),
  ];

  List<WaterAmount> topThree = getTopThreeWaterAmounts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weekly Report'),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 8),
            const Text(
              "22 January - 28 January",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Icon(
                    Icons.water_drop_sharp,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "20 Units",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Daily Average Units",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "2 Units less than last week",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 440,
              width: 200,
              child: WaterUsageChart(waterAmountList),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Top 3 days this week",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // TODO: later use algorithm to determine the three most upper
          ],
        ));
  }

}


// function that return the top three water usage days in the week

List<WaterAmount> getTopThreeWaterAmounts() {
  final List<WaterAmount> waterAmountList = [
    WaterAmount(day: "MON", amount: 25),
    WaterAmount(day: "TUE", amount: 30),
    WaterAmount(day: "WED", amount: 28),
    WaterAmount(day: "THU", amount: 20),
    WaterAmount(day: "FRI", amount: 32),
    WaterAmount(day: "SAT", amount: 27),
    WaterAmount(day: "SUN", amount: 29),
  ];
  // Sort the list in descending order based on water amount
  waterAmountList.sort((a, b) => b.amount.compareTo(a.amount));

  // Take the top three elements
  List<WaterAmount> topThree = waterAmountList.take(3).toList();

  return topThree;
}
