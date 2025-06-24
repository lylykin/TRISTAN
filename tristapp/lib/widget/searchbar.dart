import 'package:flutter/material.dart';

class DataSearchBar extends StatefulWidget {
  final List<Map<String, dynamic>?> itemsList;
  final ValueChanged<List<Map<String, dynamic>>> onSearchResult;
  final VoidCallback onCancelModifyers;

  const DataSearchBar({super.key, required this.itemsList, required this.onSearchResult, required this.onCancelModifyers});

  @override
  State<DataSearchBar> createState() => _DataSearchBarState();
}

class _DataSearchBarState extends State<DataSearchBar> {
  final SearchController searchQueryController = SearchController();

  void modifyDataList(String entry) {
    List<Map<String, dynamic>> sortedItemsList = [];
    for (Map<String, dynamic>? item in widget.itemsList) {
      if (item != null && item['nom_objet'].toString().toLowerCase().contains(entry.toLowerCase())) {
        sortedItemsList.add(item);
      }
    }
    widget.onSearchResult(sortedItemsList);
  }

  void clearDataList() {
    searchQueryController.text = '';
    widget.onCancelModifyers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        controller: searchQueryController,
        hintText: "Rechercher un objet",
        leading: Icon(Icons.search),
        autoFocus: true,
        onSubmitted: modifyDataList,
      trailing: [ElevatedButton(
        onPressed: clearDataList,
        child: Icon(Icons.cancel)
      )],
      )
    );
  }
}