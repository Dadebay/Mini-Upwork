import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxInt selectedPageBottomIndex = 0.obs;
  RxInt selectedPageIndex = 0.obs;
  RxString documentID = ''.obs;
  RxList myArray = [].obs;
  dicrementPageIndex() {
    selectedPageIndex.value--;
  }

  incrementPageIndex() {
    selectedPageIndex.value++;
  }
}
