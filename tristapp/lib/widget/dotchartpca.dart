import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tristapp/widget/dotchartcustom.dart';

final sparkfun = {'data':[[4, 0, 8, 7, 6, 6, 4, 8, 7, 8, 9, 0, 7, 7, 5, 4, 3, 2],
                    [60, 70, 78, 69, 50, 59, 37, 59, 50, 39, 47, 59, 70, 28, 49, 0, 40, 59],
                    [456, 86, 234, 123, 123, 5, 8, 9, 0, 9, 8, 7, 6, 5, 6, 8, 8, 8],
                    [4, 0, 8, 9, 6, 6, 4, 8, 7, 8, 9, 0, 7, 7, 5, 4, 3, 10]],
            'target':[0, 1, 2, 0],
            'target_names':['alu', 'carton', 'papier']};

class DotChartPca extends StatefulWidget {
  final List<Map<String, dynamic>> itemsHistory;
  final String? chartTitle;
  const DotChartPca({super.key, required this.itemsHistory, this.chartTitle});

  @override
  State<DotChartPca> createState() => _DotChartPcaState();
}

class _DotChartPcaState extends State<DotChartPca> {
  final colorSet = [Color.fromARGB(255, 134, 139, 240),Color.fromARGB(255, 139, 247, 180),Color.fromARGB(255, 248, 197, 138),Color.fromARGB(255, 250, 137, 128),Color.fromARGB(255, 128, 238, 250),Color.fromARGB(255, 250, 128, 228),Color.fromARGB(255, 128, 250, 209),Color.fromARGB(255, 240, 107, 98),Color.fromARGB(255, 74, 225, 107),Color.fromARGB(255, 249, 97, 254)];
  final Map<String, int> borneUsageOccurences = {};
  bool displayChart = false;
  
  @override
  Widget build(BuildContext context) {
    List<ScatterSpot> spotsList = [ScatterSpot(
      4,
      7,
      dotPainter: FlDotCirclePainter(
        color: colorSet[0],
        radius: 2,
      )
    )];

    //final LineTouchData lineTouchDataCustom = LineTouchData(
    //  touchTooltipData: LineTouchTooltipData(
    //    getTooltipItems: (touchedSpots) {
    //      // Affichage de la valeur x dans l'overlay (tooltip)
    //      DateTime dateToDisplay = last30Days[touchedSpots[0].x.toInt()];
    //      return [LineTooltipItem(
    //        'Date : ${(dateToDisplay.day < 10) ? '0${dateToDisplay.day}' : dateToDisplay.day}/${(dateToDisplay.month < 10) ? '0${dateToDisplay.month}' : dateToDisplay.month}',
    //        TextStyle(color: Theme.of(context).colorScheme.onSecondary)
    //      )];
    //    }
    //  )
    //);

    void dataFetch() {
      (widget.itemsHistory.isNotEmpty) ? displayChart = true : displayChart = false; // Avoid displaying widget if no items
      
      for (var item in widget.itemsHistory) {
        DateTime date = DateTime.parse(item['updated']).toLocal(); // for String format : DateFormat('dd/MM/yyyy HH:mm').format()

        bool alreadyContainedInList = false;
        borneUsageOccurences.forEach((String dateUsage, int occurences) {
          if (
            !alreadyContainedInList &&
            dateUsage == '${date.year}-${date.month}-${date.day}'
          ) {
            occurences += 1;
            alreadyContainedInList = true;
          }
        });

        if (!alreadyContainedInList) {
          borneUsageOccurences['${date.year}-${(date.month < 10) ? '0${date.month}' : date.month}-${(date.day < 10) ? '0${date.day}' : date.day}'] = 1; // Ajoute une occurence
        }
      }
    }
    return DotChartCustom(dataFetch: dataFetch, data: spotsList, leftAxis: null, bottomAxis: null, indicatorList: [], displayChart: displayChart, chartTitle: widget.chartTitle); // indicatorList non nécessaire pour de la simple utilisation car couleur unique
  }
}