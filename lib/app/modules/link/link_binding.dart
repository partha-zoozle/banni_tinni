import 'package:get/get.dart';
import 'package:banni_tinni/app/modules/link/link_controller.dart';

class LinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LinkController>(() => LinkController());
  }
}
