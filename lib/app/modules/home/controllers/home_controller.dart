import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxInt selectedCategoryID = 0.obs;
  RxInt selectedPageIndex = 0.obs;
  RxList selectedList = [].obs;

  dicrementPageIndex() {
    selectedPageIndex.value--;
  }

  incrementPageIndex() {
    selectedPageIndex.value++;
  }
}
