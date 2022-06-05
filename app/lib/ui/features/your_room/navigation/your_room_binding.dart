import 'package:app/ui/features/your_room/navigation/your_room_controller.dart';
import 'package:get/get.dart';

class YourRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<YourRoomController>(YourRoomController());
  }
}
