import 'package:app/ui/features/reservations/navigation/reservations_controller.dart';
import 'package:get/get.dart';

class ReservationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReservationsController>(ReservationsController());
  }
}
