import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smart_water_meter/models/water_amount.dart';

class WaterUsageChart extends StatelessWidget {
  final List<WaterAmount> data;

  const WaterUsageChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<WaterAmount, String>> series = [
      charts.Series(
        data: data,
        id: "DataConsumption",
        domainFn: (WaterAmount series, _) => series.day,
        measureFn: (WaterAmount series, _) => series.amount,
      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text(
              "Broadband Data Consumption By month",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
