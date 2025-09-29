import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customer_booked_services_controller.dart';
import '../controllers/general_controller.dart';
import '../models/customer_booked_services_model.dart';

getAllCustomerBookedServicesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CustomerBookedServicesController>()
            .getCustomerBookedServicesModel =
        GetCustomerBookedServicesModel.fromJson(response);

    Get.find<CustomerBookedServicesController>()
        .updateCustomerBookedServicesLoader(true);
    log("${Get.find<CustomerBookedServicesController>().getCustomerBookedServicesModel.data!.data!.length.toString()} Total Customer Booked Services Length");
    log("${Get.find<CustomerBookedServicesController>().getCustomerBookedServicesModel.data!.data!.where((i) => i.serviceStatusName == "Completed").toList().length.toString()} Total Completed Customer Booked Services Length");

    for (var element in Get.find<CustomerBookedServicesController>()
        .getCustomerBookedServicesModel
        .data!
        .data!) {
      Get.find<CustomerBookedServicesController>()
          .updateLawyerListForPagination(element);
    }

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);

    // if (Get.find<AllLawyersCategoriesController>().getAllLawyerCategoriesDataModel.status == true) {
    // } else {}
  } else if (!responseCheck) {
    Get.find<CustomerBookedServicesController>()
        .updateCustomerBookedServicesLoader(true);
  }
}
