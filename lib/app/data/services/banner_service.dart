import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../models/banner_model.dart';

class BannerService {
  Future<List<BannerModel>> getBanners() async {
    final List<BannerModel> bannerList = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/get-banners/1',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map product in responseJson) {
        bannerList.add(BannerModel.fromJson(product));
      }
      return bannerList;
    } else {
      return [];
    }
  }

  Future<BannerModel> getBannersByID(int id) async {
    final response = await http.get(
      Uri.parse(
        '$serverURL/api/get-banner/$id',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['data'];
      return BannerModel.fromJson(responseJson);
    } else {
      return BannerModel();
    }
  }

  Future<List<BannerModel>> getWorks() async {
    final List<BannerModel> bannerList = [];

    final response = await http.get(
      Uri.parse(
        '$serverURL/api/get-banners/2',
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['rows'] as List;
      for (final Map product in responseJson) {
        bannerList.add(BannerModel.fromJson(product));
      }
      return bannerList;
    } else {
      return [];
    }
  }
}
