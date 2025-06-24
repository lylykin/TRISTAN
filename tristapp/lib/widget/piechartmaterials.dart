import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tristapp/widget/indicator.dart';
import 'package:tristapp/widget/piechartcustom.dart';

class PieChartMaterials extends StatefulWidget {
  final List<Map<String, dynamic>> itemsHistory;
  final String? chartTitle;
  const PieChartMaterials({super.key, required this.itemsHistory, this.chartTitle});

  @override
  State<PieChartMaterials> createState() => _PieChartMaterialsState();
}

class _PieChartMaterialsState extends State<PieChartMaterials> {
  final colorSet = [Color.fromARGB(255, 134, 139, 240),Color.fromARGB(255, 139, 247, 180),Color.fromARGB(255, 248, 197, 138),Color.fromARGB(255, 250, 137, 128),Color.fromARGB(255, 128, 238, 250),Color.fromARGB(255, 250, 128, 228),Color.fromARGB(255, 128, 250, 209),Color.fromARGB(255, 240, 107, 98),Color.fromARGB(255, 74, 225, 107),Color.fromARGB(255, 249, 97, 254)];
  final Map<String, int> materialOccurences = {};
  bool displayChart = false;
  
  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sectionsListMaterials = [];
    final List<Widget> indicatorList = [];
    List<Map<String, dynamic>> itemsNonNullHistory = [];
    for (var item in widget.itemsHistory) {
      if (item['materiau'] != null) {
        itemsNonNullHistory.add(item);
      }
    }
    double totalWeight = itemsNonNullHistory.length.toDouble(); // Poid total équivalent à la quantité d'objets dans la liste

    void displaySections(touchedSection) {
      displayChart = (itemsNonNullHistory.isNotEmpty) ? true : false; // Avoid displaying widget if no items or all null materials

      materialOccurences.clear();
      for (int objetPosition = 0; objetPosition < itemsNonNullHistory.length; objetPosition++) { // Fills the data Map for the chart
        String? materialName = itemsNonNullHistory[objetPosition]['materiau'];
        if (materialOccurences.containsKey(materialName)) {
          materialOccurences[materialName!] = materialOccurences[materialName]! + 1;
        } else {
          if (materialName != null) {
            materialOccurences[materialName] = 1;
          }
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

    return PieChartCustom(displaySections: displaySections, sectionsListMaterials: sectionsListMaterials, indicatorList: indicatorList, displayChart: displayChart, chartTitle: widget.chartTitle);
  }
}