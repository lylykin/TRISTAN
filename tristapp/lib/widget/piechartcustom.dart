import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartCustom extends StatefulWidget {
  final Function displaySections;
  final List<PieChartSectionData> sectionsListMaterials;
  final List<Widget> indicatorList;
  final bool displayChart;
  final String? chartTitle;
  
  const PieChartCustom({super.key, required this.displaySections, required this.sectionsListMaterials, required this.indicatorList, this.displayChart = false, this.chartTitle});

  @override
  State<PieChartCustom> createState() => _PieChartCustomState();
}

class _PieChartCustomState extends State<PieChartCustom> {
  int touchedSection = -1;

  @override
  Widget build(BuildContext context) {
    widget.displaySections(touchedSection); // Construction des indicator et des sections via le fichier parent traitant les données

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
            Row(
                children: [
                  SizedBox( // Nécessaire comme le pie chart dépasse du container si aucune limite spécifiée
                    width: 400,
                    height: 300,
                    child: widget.displayChart
                      ? PieChart(
                          PieChartData( // Construction du graphe selon les données en paramètres pré-traitées
                            sections: widget.sectionsListMaterials,
                            centerSpaceRadius: 40,
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, touchResponse) {
                                if (event is FlTapUpEvent) {
                                  if (touchResponse == null ||
                                    touchResponse.touchedSection == null
                                  ) { // Si pas d'interaction ou pas de section particulière touchée, réinitialiser touchedSection
                                    touchedSection = -1;
                                    return;
                                  }
                                  setState(() {
                                    touchedSection = touchResponse.touchedSection!.touchedSectionIndex;
                                  });
                                }
                              }
                            )
                          )
                        )
                      : Text('Aucune donnée'),
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
              ),
          ],
        ),
      ),
    );
  }
}