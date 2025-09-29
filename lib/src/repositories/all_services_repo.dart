import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/all_services_controller.dart';
import '../controllers/general_controller.dart';
import '../models/all_services_model.dart';

getAllServicesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AllServicesController>().getAllServicesModel =
        GetAllServicesModel.fromJson(response);

    Get.find<AllServicesController>().updateServicesLoader(true);
    log("${Get.find<AllServicesController>().getAllServicesModel.data!.data!.length.toString()} Total Services Length");

    for (var element
        in Get.find<AllServicesController>().getAllServicesModel.data!.data!) {
      Get.find<AllServicesController>()
          .updateServicesListForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllLawyersCategoriesController>().getAllLawyerCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<AllServicesController>().updateServicesLoader(true);
  }
}
