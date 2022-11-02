// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_stocks/components/loading_indicator.dart';
import 'package:flutter_stocks/components/stock_card.dart';
import 'package:flutter_stocks/models/company_model.dart';

class StockSearch extends SearchDelegate {
  final List all;

  StockSearch({required this.all});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.keyboard_backspace),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Must be Longer than two characters",
            ),
          ),
        ],
      );
    }

    var query1;
    var query2 = " ";
    if (query.isNotEmpty) {
      query1 = query.toLowerCase();
      query2 = query1[0].toUpperCase() + query1.substring(1);
    }

    //Search in the json for the query entered
    var search = all.where((stock) => stock['name'].contains(query2)).toList();

    return search.isEmpty
        ? loadingIndicator(context)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: GridView.builder(
              itemCount: search.isEmpty ? 0 : search.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
              ),
              itemBuilder: (BuildContext context, int position) {
                CompanyData company = CompanyData.fromJson(search[position]);
                return StockCard(company: company, index: position);
              },
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var query1;
    var query2 = " ";
    if (query.isNotEmpty) {
      query1 = query.toLowerCase();
      query2 = query1[0].toUpperCase() + query1.substring(1);
    }

    var search = all.where((stock) => stock['name'].contains(query2)).toList();

    return search.isEmpty
        ? loadingIndicator(context)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: GridView.builder(
              itemCount: search.isEmpty ? 0 : search.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.8 / 2.3,
              ),
              itemBuilder: (BuildContext context, int position) {
                CompanyData company = CompanyData.fromJson(search[position]);
                return StockCard(company: company, index: position);
              },
            ),
          );
  }
}
