import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maksat_app/app/data/models/category_model.dart';

import '../../constants/constants.dart';

class CategoryServices {
  Future<List<CategoryModel>> getCategories() async {
    final List<CategoryModel> categorylist = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/categories',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map product in responseJson) {
        categorylist.add(CategoryModel.fromJson(product));
      }
      return categorylist;
    } else {
      return [];
    }
  }

  Future<List<GetCategorySpec>> getCateSpecById({required int id}) async {
    final List<GetCategorySpec> getCatSpecList = [];
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/get-spec-for-cat/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map<String, dynamic> product in responseJson) {
        getCatSpecList.add(GetCategorySpec.fromJson(product));
      }
      return getCatSpecList;
    } else {
      return [];
    }
  }
}
