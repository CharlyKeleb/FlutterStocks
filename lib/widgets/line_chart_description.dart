import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stocks/components/loading_indicator.dart';
import 'dart:math';

import 'package:flutter_stocks/utils/constants.dart';

class LineChartDescriptionWidget extends StatelessWidget {
  final List<double> data;
  final Color color;
  final bool loading;
  final bool error;

  const LineChartDescriptionWidget(
      {Key? key,
      this.data = const [],
      this.color = const Color(0xff02d39a),
      this.loading = false,
      this.error = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Opacity(
        opacity: data.isNotEmpty && !loading & !error ? 1 : 0.3,
        child: SizedBox(
          width: double.infinity,
          child: LineChart(
            mainData(data.isNotEmpty && !loading & !error
                ? data
                : Constants().demoGraphData),
            swapAnimationDuration: const Duration(seconds: 0),
          ),
        ),
      ),
      if (loading)
      loadingIndicator(context)
      else if (error || data.isEmpty)
        Center(
          child: Text('No Data',
              style: Theme.of(context).textTheme.headline3),
        )
    ]);
  }

  LineChartData mainData(List<double> data) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 4,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color:  Colors.grey.withOpacity(0.1),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color:  Colors.grey.withOpacity(0.2),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: data.length.toDouble() - 1,
      minY: data.reduce(min).toDouble(),
      maxY: data.reduce(max).toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: listData(data),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.grey.withOpacity(0.2),
            
          ),
        ),
      ],
    );
  }

  List<FlSpot> listData(List<double> data) {
    return data
        .mapIndexed((e, i) => FlSpot(i.toDouble(), e.toDouble()))
        .toList();
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
