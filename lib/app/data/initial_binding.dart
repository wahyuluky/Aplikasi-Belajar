import 'package:get/get.dart';
import 'package:flutter_application_1/app/data/auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
  }
}
