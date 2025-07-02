import 'package:get/get.dart';
import 'package:banni_tinni/app/modules/place/place_controller.dart';

class PlaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceController>(() => PlaceController());
  }
}
