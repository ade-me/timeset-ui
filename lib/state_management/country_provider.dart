// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountryProvider with ChangeNotifier {
  final List<Country> _countries = [];
  List<Country> get countries => _countries;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loading() {
    _isLoading = true;

    notifyListeners();
  }

  void loaded() {
    _isLoading = false;

    notifyListeners();
  }

  Future<dynamic> getCountryWithCodes() async {
    try {
      loading();
      Uri uri = Uri.parse('https://country-code-au6g.vercel.app/Country.json');

      http.Response response = await http.get(uri);

      dynamic body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (dynamic i in body) {
          Country country = Country.fromJSon(json: i);

          _countries.add(country);
        }

        loaded();

        notifyListeners();
      } else {
        print(body);
        loaded();
      }
    } catch (e) {
      print('Get country error: $e');
      loaded();
    }
  }
}
