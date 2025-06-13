import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartCustom extends StatefulWidget {
  final Function dataFetch;
  final data;
  final leftAxis;
  final bottomAxis;
  final List<Widget> indicatorList;
  final bool displayChart;
  final String? chartTitle;
  
  const LineChartCustom({super.key, required this.dataFetch, required this.data, required this.leftAxis, required this.bottomAxis, required this.indicatorList, this.displayChart = false, this.chartTitle});

  @override
  State<LineChartCustom> createState() => _LineChartCustomState();
}

class _LineChartCustomState extends State<LineChartCustom> {

  @override
  Widget build(BuildContext context) {
    //widget.displaySections(touchedSection); // Construction des indicator et des sections via le fichier parent traitant les données

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
            widget.displayChart
            ? Row(
                children: [
                  SizedBox( // Nécessaire comme le pie chart dépasse du container si aucune limite spécifiée
                    width: 400,
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              //getTitlesWidget: bottomTitleWidgets,
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
                      )
                    )
                  ),
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