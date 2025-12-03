import 'package:get/get.dart';

import '../controllers/music_collection_controller.dart';

class MusicCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicCollectionController>(
      () => MusicCollectionController(),
    );
  }
}
