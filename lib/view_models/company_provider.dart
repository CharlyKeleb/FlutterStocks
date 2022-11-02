// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stocks/models/company_model.dart';
import 'package:flutter_stocks/utils/api/endpoints.dart';
import 'package:http/http.dart' as http;

class CompanyProvider extends ChangeNotifier {
  final List<CompanyData> companies = <CompanyData>[];

  List<CompanyData> get companyItems {
    return [...companies];
  }

  Future<void> fetchAndSetCompanyItems() async {
    //fetch companies
    final url = Endpoints.companyURL;
    final response = await http.get(Uri.parse(url));
    final responseData = jsonDecode(response.body);
    companies.clear();
    for (var compItem in responseData["data"]) {
      companies.add(CompanyData.fromJson(compItem));
    }

    for (var compItem in companies) {}
    notifyListeners();
  }

  removeFromList(index) {
    companyItems.removeAt(index);
    notifyListeners();
  }
}
