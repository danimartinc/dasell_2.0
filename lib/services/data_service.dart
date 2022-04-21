import 'dart:convert';

import 'package:DaSell/commons.dart';
import 'package:DaSell/data/categories.dart';
import 'package:flutter/services.dart';

class DataService {

  static DataService get() => locator.get();

  late List<CategoryVo> categories;

  Future<void> init() async {
    final stringData =
        await rootBundle.loadString('assets/json/categories.json');
    final jsonData = jsonDecode(stringData);
    categories = List.of(jsonData).map((e) => CategoryVo.fromJson(e)).toList();
  }
}
