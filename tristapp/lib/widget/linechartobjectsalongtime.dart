import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tristapp/widget/indicator.dart';
import 'package:tristapp/widget/linechartcustom.dart';

class LineChartBorneUsage extends StatefulWidget {
  final List<Map<String, dynamic>> itemsHistory;
  final String? chartTitle;
  const LineChartBorneUsage({super.key, required this.itemsHistory, this.chartTitle});

  @override
  State<LineChartBorneUsage> createState() => _LineChartBorneUsageState();
}

class _LineChartBorneUsageState extends State<LineChartBorneUsage> {
  final colorSet = [Color.fromARGB(255, 134, 139, 240),Color.fromARGB(255, 139, 247, 180),Color.fromARGB(255, 248, 197, 138),Color.fromARGB(255, 250, 137, 128),Color.fromARGB(255, 128, 238, 250),Color.fromARGB(255, 250, 128, 228),Color.fromARGB(255, 128, 250, 209),Color.fromARGB(255, 240, 107, 98),Color.fromARGB(255, 74, 225, 107),Color.fromARGB(255, 249, 97, 254)];
  final Map<String, int> borneUsageOccurences = {};
  bool displayChart = false;
  
  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sectionsListMaterials = [];
    final List<Widget> indicatorList = [];
    
    void dataFetch() {

    }
    /*
    void displaySections(touchedSection) {
      (widget.itemsHistory.isNotEmpty) ? displayChart = true : displayChart = false; // Avoid displaying widget if no items
      materialOccurences.clear();
      for (int objetPosition = 0; objetPosition < widget.itemsHistory.length; objetPosition++) { // Fills the data Map for the chart
        String materialName = widget.itemsHistory[objetPosition]['materiau'];
        if (materialOccurences.containsKey(materialName)) {
          materialOccurences[materialName] = materialOccurences[materialName]! + 1;
        } else {
          materialOccurences[materialName] = 1;
        }  
      }
      sectionsListMaterials.clear();
      indicatorList.clear();
      int materialSectionPosition = 0;

      materialOccurences.forEach((materialName, materialWeight) {
        Color materialColor = colorSet[materialSectionPosition % colorSet.length]; // La position modulo la longueur de la liste pour réutiliser les couleurs
        final bool isTouched = (materialSectionPosition == touchedSection); // Si jamais la section à la position est la section touchée par l'user, définition d'un radius différent
        final double radius = isTouched ? 60.0 : 50.0;
        final double percentage = materialWeight/totalWeight*100;

        sectionsListMaterials.add(
          PieChartSectionData(
            value: materialWeight.toDouble(),
            color: materialColor,
            radius: radius,
            showTitle: true,
            title: isTouched
              ? '$materialName\n$materialWeight objet${(materialWeight == 1) ? '' : 's'}\n${percentage.toStringAsPrecision(3)}%'
              : materialName, // Arrondi à trois chiffres significatifs
            titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            )
          ),
        );

        indicatorList.add(
          Indicator(
            color: materialColor,
            text: materialName,
          )
        );
        indicatorList.add(
          SizedBox(
            height: 4,
          ),
        );

        materialSectionPosition++; // Augmente d'un la valeur de position pour la prochaine itération
      });
    }
    */
  
    return LineChartCustom(dataFetch: dataFetch, data: null, leftAxis: null, bottomAxis: null, indicatorList: indicatorList, displayChart: true, chartTitle: widget.chartTitle);
  }
}