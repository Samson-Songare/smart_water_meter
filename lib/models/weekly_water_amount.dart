import 'package:smart_water_meter/models/water_amount.dart';

class WeeklyWaterAmount {
  List<WaterAmount> weeklyWater;
  DateTime fromDate;
  DateTime toDate;

  WeeklyWaterAmount({
    required this.weeklyWater,
    required this.fromDate,
    required this.toDate,
  });
}
