import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tristapp/widget/indicator.dart';
import 'package:tristapp/widget/piechartcustom.dart';

class PieChartRecyclability extends StatefulWidget {
  final List<Map<String, dynamic>> itemsHistory;
  final String? chartTitle;
  const PieChartRecyclability({super.key, required this.itemsHistory, this.chartTitle});

  @override
  State<PieChartRecyclability> createState() => _PieChartRecyclabilityState();
}

class _PieChartRecyclabilityState extends State<PieChartRecyclability> {
  final colorSet = [Color.fromARGB(255, 134, 240, 134),Color.fromARGB(255, 247, 155, 139)];
  Map<String, int> recyclableMaterialOccurences = {"Recyclable" : 0, "Non recyclable" : 0};
  bool displayChart = false;
  
  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sectionsListMaterials = [];
    final List<Widget> indicatorList = [];
    double totalWeight = widget.itemsHistory.length.toDouble(); // Poid total équivalent à la quantité d'objets dans la liste

    void displaySections(touchedSection) {
      (widget.itemsHistory.isNotEmpty) ? displayChart = true : displayChart = false; // Avoid displaying widget if no items
      recyclableMaterialOccurences = {"Recyclable" : 0, "Non recyclable" : 0};
      for (int objetPosition = 0; objetPosition < widget.itemsHistory.length; objetPosition++) { // Fills the data Map for the chart
        bool? recyclable = widget.itemsHistory[objetPosition]['recyclability']; // null par défaut en cas de matériau non formaté
        if (recyclable != null) {
          if (recyclable) {
            recyclableMaterialOccurences["Recyclable"] = recyclableMaterialOccurences["Recyclable"]! + 1;
          } else {
            recyclableMaterialOccurences["Non recyclable"] = recyclableMaterialOccurences["Non recyclable"]! + 1;
          }
        } else {
          totalWeight -= 1;
        }
      }
      sectionsListMaterials.clear();
      indicatorList.clear();
      int materialSectionPosition = 0;

      recyclableMaterialOccurences.forEach((recyclabilty, occurences) {
        Color materialColor = colorSet[materialSectionPosition]; // La position modulo la longueur de la liste pour réutiliser les couleurs
        final bool isTouched = (materialSectionPosition == touchedSection); // Si jamais la section à la position est la section touchée par l'user, définition d'un radius différent
        final double radius = isTouched ? 60.0 : 50.0;
        final double percentage = occurences/totalWeight*100;

        sectionsListMaterials.add(
          PieChartSectionData(
            value: occurences.toDouble(),
            color: materialColor,
            radius: radius,
            showTitle: true,
            title: isTouched
              ? '${percentage.toStringAsPrecision(3)} %\n$occurences objet${(occurences == 1) ? '' : 's'}'
              : '${percentage.toStringAsPrecision(3)} %', // Arrondi à trois chiffres significatifs
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
            text: recyclabilty,
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
