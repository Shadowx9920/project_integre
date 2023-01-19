import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              FutureBuilder(
                future: null,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 0.7,
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 5,
                          maxX: 16,
                          minX: 1,
                          lineBarsData: [
                            LineChartBarData(spots: []),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
