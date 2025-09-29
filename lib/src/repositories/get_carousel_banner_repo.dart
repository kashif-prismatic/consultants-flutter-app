import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/models/get_carousel_banner_model.dart';

import '../controllers/get_carousel_banner_controller.dart';

getAllCarouselBannerRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GetAllCarouselBannerController>().getAllCarouselBannerModel =
        GetAllCarouselBannerModel.fromJson(response);

    Get.find<GetAllCarouselBannerController>()
        .updateAllCarouselBannerLoader(true);
    log("${response["data"]} All Carousel Banner Length");

    if (Get.find<GetAllCarouselBannerController>()
            .getAllCarouselBannerModel
            .success ==
        true) {}
  } else if (!responseCheck) {
    Get.find<GetAllCarouselBannerController>()
        .updateAllCarouselBannerLoader(false);
  }
}
