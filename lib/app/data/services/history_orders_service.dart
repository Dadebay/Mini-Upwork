import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:maksat_app/app/data/models/history_orders_model.dart';
import 'package:maksat_app/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../constants/constants.dart';

class HistoryOrdersService {
  Future<List<HistoryOrderModel>> getHistoryOrders() async {
    final List<HistoryOrderModel> orderList = [];
    final UserProfilController userProfilController = Get.put(UserProfilController());
    print(userProfilController.list);
    userProfilController.returnList();
    print(userProfilController.list);

    final response = await http.get(
      Uri.parse('$serverURL/api/get-orders').replace(
        queryParameters: {
          'orders': jsonEncode(userProfilController.list),
        },
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['data']['orders'] as List;
      for (final Map product in responseJson) {
        orderList.add(HistoryOrderModel.fromJson(product));
      }
      return orderList;
    } else {
      return [];
    }
  }
}
