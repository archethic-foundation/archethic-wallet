import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/styles.dart';

class LineChartWidget extends StatefulWidget {
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundDark,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: StateContainer.of(context).curTheme.backgroundDarkest,
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(context),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5.0),
            child: Text(
              'UCO (1h)',
              style: AppStyles.textStyleTransactionUnit(context),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 100.0),
            child: Row(
              children: [
                Text(
                  '+0,2\$ (0,10%)',
                  style: AppStyles.textStyleChartGreen(context),
                ),
                Icon(Entypo.up_dir,
                    color: StateContainer.of(context).curTheme.positiveValue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(BuildContext context) {
    List<Color> gradientColors = [
      StateContainer.of(context).curTheme.backgroundDark,
      StateContainer.of(context).curTheme.backgroundDarkest,
    ];
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: StateContainer.of(context).curTheme.backgroundDarkest,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: StateContainer.of(context).curTheme.backgroundDarkest,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 10,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
          reservedSize: 10,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0.210,
      maxY: 0.229,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 0.223),
            FlSpot(1, 0.221),
            FlSpot(2, 0.228),
            FlSpot(3, 0.218),
            FlSpot(4, 0.217),
            FlSpot(5, 0.221),
            FlSpot(6, 0.222),
            FlSpot(7, 0.223),
            FlSpot(8, 0.229),
            FlSpot(9, 0.210),
            FlSpot(10, 0.219),
            FlSpot(11, 0.219),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
