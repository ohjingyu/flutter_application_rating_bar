import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_rating_bar/meal_api.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LineChart(LineChartData()),
          ElevatedButton(
              onPressed: () async {
                var mealApi = await MealApi();
                var evalDate = DateTime.now().toString().split(' ')[0];
                var result = await mealApi.getList(evalDate: evalDate);
              },
              child: Text('확인')),
        ],
      ),
    );
  }
}
