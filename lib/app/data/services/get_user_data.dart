import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maksat_app/app/data/models/aboust_us_model.dart';

import '../../constants/constants.dart';

class GetUserData {
  Future<List<FaqModel>> getFAQ() async {
    final List<FaqModel> faqList = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/faq',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'];
      for (final Map product in responseJson) {
        faqList.add(FaqModel.fromJson(product));
      }
      return faqList;
    } else {
      return [];
    }
  }

  Future<AboutUsModel> getAboutUs() async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/get-shop-data',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'];
      return AboutUsModel.fromJson(responseJson);
    } else {
      return AboutUsModel();
    }
  }
}
