import 'package:get/get.dart';

import '../controllers/genre_details_controller.dart';

class GenreDetailsBidings extends Bindings {
  @override
  void dependencies() {
    Get.put(GenreDetailsController());
  }
}
