import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
  bool displayChart = false;
  
  @override
  Widget build(BuildContext context) {
    final Map<String, int> borneUsageOccurences = {};
    final List<FlSpot> spotsList = [];
    final DateTime today = DateTime.now();
    final List<DateTime> last30Days = List.generate(30, (i) => DateTime(today.year, today.month, today.day).subtract(Duration(days: 29 - i)));
    // DateTime earlierUsage = today;
    final Widget bottomAxisNameWidget = Text("${(last30Days[0].month < 10) ? '0${last30Days[0].month}' :last30Days[0].month}-${(last30Days[29].month < 10) ? '0${last30Days[29].month}' :last30Days[29].month} / ${last30Days[29].year}");

    final LineTouchData lineTouchDataCustom = LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          // Affichage de la valeur x dans l'overlay (tooltip)
          DateTime dateToDisplay = last30Days[touchedSpots[0].x.toInt()];
          String utilisations = (touchedSpots[0].y.toInt() == 0) ? '' : (touchedSpots[0].y.toInt() == 1) ?'\n1 objet' :'\n${touchedSpots[0].y.toInt()} objets';
          return [LineTooltipItem(
            'Date : ${(dateToDisplay.day < 10) ? '0${dateToDisplay.day}' : dateToDisplay.day}/${(dateToDisplay.month < 10) ? '0${dateToDisplay.month}' : dateToDisplay.month}$utilisations',
            TextStyle(color: Theme.of(context).colorScheme.onSecondary)
          )];
        }
      )
    );

    Widget bottomTitleWidgets(double value, TitleMeta meta) { // Made using imaNNeo's code
      final style = TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      );

      if (value < 0 || value > last30Days.length) {
        return SizedBox.shrink();
      }
      DateTime dateToDisplay = last30Days[value.toInt()];
      return SideTitleWidget(
        space: 4,
        meta: meta,
        fitInside: SideTitleFitInsideData.disable(),
        child: Text(
          '${(dateToDisplay.day < 10) ? '0${dateToDisplay.day}' : dateToDisplay.day}',
          style: style,
        ),
      );
    }

    void dataFetch() {
      (widget.itemsHistory.isNotEmpty) ? displayChart = true : displayChart = false; // Avoid displaying widget if no items
      for (var item in widget.itemsHistory) {
        DateTime date = DateTime.parse(item['updated']).toLocal(); // for String format : DateFormat('dd/MM/yyyy HH:mm').format()

        bool alreadyContainedInList = false;
        borneUsageOccurences.forEach((String dateUsage, int occurences) {
          print(borneUsageOccurences);
          if (
            !alreadyContainedInList &&
            dateUsage == '${date.year}-${(date.month < 10) ? '0${date.month}' : date.month}-${(date.day < 10) ? '0${date.day}' : date.day}'
          ) {
            borneUsageOccurences[dateUsage] = borneUsageOccurences[dateUsage]! + 1;
            alreadyContainedInList = true;
          }
        });

        if (!alreadyContainedInList) {
          borneUsageOccurences['${date.year}-${(date.month < 10) ? '0${date.month}' : date.month}-${(date.day < 10) ? '0${date.day}' : date.day}'] = 1; // Ajoute une occurence
        }
      }

      for (int i = 0; i < last30Days.length; i++) {
        final DateTime date = last30Days[i];
        final int? occurences = borneUsageOccurences['${date.year}-${(date.month < 10) ? '0${date.month}' : date.month}-${(date.day < 10) ? '0${date.day}' : date.day}'];
          spotsList.add(FlSpot(i.toDouble(), (occurences ?? 0).toDouble()));
      }
    }

    dataFetch();
  
    return LineChartCustom(dataFetch: dataFetch, data: spotsList, leftAxis: null, bottomAxis: bottomTitleWidgets, indicatorList: [], displayChart: displayChart, chartTitle: widget.chartTitle, lineTouchDataCustom: lineTouchDataCustom, bottomAxisNameWidget: bottomAxisNameWidget,); // indicatorList non nécessaire pour de la simple utilisation car couleur unique
  }
}