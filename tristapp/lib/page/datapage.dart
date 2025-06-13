import 'package:flutter/material.dart';
import 'package:tristapp/page/chartspage.dart';
import 'package:tristapp/page/datalistpage.dart';

final ValueNotifier<bool> acessToChartsNotifier = ValueNotifier(true);

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: acessToChartsNotifier,
      builder: (context, acessToCharts, child) {
        return acessToCharts
          ? ChartsPage()
          : DataListPage();
      },
    );
  }
}
