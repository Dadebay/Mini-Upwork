import 'package:get/get.dart';

import '../controllers/add_order_page_controller.dart';

class AddOrderPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrderPageController>(
      () => AddOrderPageController(),
    );
  }
}
