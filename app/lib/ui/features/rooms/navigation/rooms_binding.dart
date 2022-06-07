import 'package:app/ui/features/rooms/navigation/rooms_controller.dart';
import 'package:get/get.dart';

class RoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RoomsController>(RoomsController());
  }
}
