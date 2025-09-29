import 'package:get/get.dart';
import 'package:lawyer_consultant/src/models/get_carousel_banner_model.dart';

class GetAllCarouselBannerController extends GetxController {
  GetAllCarouselBannerModel getAllCarouselBannerModel =
      GetAllCarouselBannerModel();

  bool getAllCarouselBannerLoader = false;
  updateAllCarouselBannerLoader(bool newValue) {
    getAllCarouselBannerLoader = newValue;
    update();
  }
}
