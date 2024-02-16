// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../types.dart';

class LineChart2 extends StatelessWidget {
  const LineChart2({super.key, required this.data, required this.maxY, required this.maxX, required this.page});
  final List data;
  final double maxY;
  final int page;
  final double maxX;

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
            spots: [
              for (var i = 0; i < data.length; i++) FlSpot(i * 1.0, data[i]),
            ],
          )
        ],
        minX: 0,
        maxX: 12,
        maxY: maxY,
        minY: 0,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    int inc = 50;
    text = "";
    if (inc * 1 == value.toInt()) {
      text = (inc * 1).toString();
    } else if (inc * 2 == value.toInt()) {
      text = (inc * 2).toString();
    } else if (inc * 3 == value.toInt()) {
      text = (inc * 3).toString();
    } else if (inc * 4 == value.toInt()) {
      text = (inc * 4).toString();
    } else if (inc * 5 == value.toInt()) {
      text = (inc * 5).toString();
    } else {
      return Container();
    }
    return Text(text, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    value = (value + ((page - 1) * 12));
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        (value > maxX) ? "" : (value).toInt().toString(),
      ),
    );
  }
}
