import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tristapp/widget/indicator.dart';


class DotChartCustom extends StatefulWidget {
  final Function dataFetch;
  final List<ScatterSpot> data;
  final Widget Function(double, TitleMeta)? leftAxis;
  final Widget Function(double, TitleMeta)? bottomAxis;
  final List<Indicator> indicatorList;
  final bool displayChart;
  final String? chartTitle;
  final LineTouchData lineTouchDataCustom;
  
  const DotChartCustom({super.key, required this.dataFetch, required this.data, this.leftAxis, this.bottomAxis, required this.indicatorList, this.displayChart = false, this.chartTitle = "Graphique sans nom", this.lineTouchDataCustom = const LineTouchData()});

  @override
  State<DotChartCustom> createState() => _DotChartCustomState();
}

class _DotChartCustomState extends State<DotChartCustom> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 400,
        width: 550,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            RichText(text: TextSpan(
              text: widget.chartTitle ?? "Graphique sans nom",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            )),
            SizedBox(height: 15),
            widget.displayChart
            ? Row(
                children: [
                  SizedBox( // Nécessaire comme le chart dépasse du container si aucune limite spécifiée
                    width: 400,
                    height: 300,
                    child: ScatterChart(
                      ScatterChartData(
                        titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false
                            )
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false
                            )
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: widget.bottomAxis ?? defaultGetTitle // Ajoute widget.bottomAxis que s'il n'est pas nul
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              //getTitlesWidget: leftTitleWidgets,
                              interval: 1,
                              reservedSize: 36,
                            ),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          checkToShowHorizontalLine: (value) => true,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          drawVerticalLine: true,
                          checkToShowVerticalLine: (value) => true,
                          getDrawingVerticalLine: (value) => FlLine(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        scatterSpots: widget.data,
                        //lineTouchData: widget.lineTouchDataCustom
                      )
                    )
                  ),
                  if (widget.indicatorList.isNotEmpty)
                    Flexible(
                      flex: 0,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.indicatorList,
                        ),
                      ),
                    ),
                ],
            )
            : Center(
                heightFactor: 5,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 6,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}