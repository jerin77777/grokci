// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'types.dart';

class LineChart2 extends StatelessWidget {
  const LineChart2({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          ),
        ),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: leftTitleWidgets,
              showTitles: true,
              interval: 1,
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: Colors.black, width: 1),
            left: BorderSide(color: Colors.black, width: 1),

            // left: BorderSide(color: Colors.transparent),
            right: BorderSide(color: Colors.transparent),
            top: BorderSide(color: Colors.transparent),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            curveSmoothness: 0,
            color: Pallet.primary,
            belowBarData: BarAreaData(
              show: true,
              color: Pallet.primary.withOpacity(0.2),
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            // belowBarData: BarAreaData(show: false),
            spots: const [
              FlSpot(0, 1),
              FlSpot(3, 4),
              FlSpot(5, 1.8),
              FlSpot(7, 5),
              FlSpot(10, 2),
              FlSpot(12, 2.2),
              // FlSpot(15, 1.8),
            ],
          )
        ],
        minX: 0,
        maxX: 12,
        maxY: 6,
        minY: 0,
      ),
    );
  }
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    case 1:
      text = '1k';
      break;
    case 2:
      text = '2k';
      break;
    case 3:
      text = '3k';
      break;
    case 4:
      text = '5k';
      break;
    case 5:
      text = '6k';
      break;
    default:
      return Container();
  }

  return Text(text,
      // style: TextStyle(
      // fontSize: 14
      // ),
      textAlign: TextAlign.center);
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: Text(
      value.toInt().toString(),
      // style: TextStyle(
      //   // fontWeight: FontWeight.bold,
      //   fontSize: 16,
      // )
    ),
  );
}
