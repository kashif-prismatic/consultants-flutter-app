import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../api_services/post_service.dart';
import '../models/customer_booked_services_model.dart';
import '../repositories/all_lawyers_repo.dart';
import 'general_controller.dart';

class CustomerBookedServicesController extends GetxController {
  GetCustomerBookedServicesModel getCustomerBookedServicesModel =
      GetCustomerBookedServicesModel();

  bool allCustomerBookedServicesLoader = false;
  updateCustomerBookedServicesLoader(bool newValue) {
    allCustomerBookedServicesLoader = newValue;
    update();
  }

  GetCustomerBookedServicesDataModel getCustomerBookedServicesDataModel =
      GetCustomerBookedServicesDataModel();

  List<CustomerBookedServiceModel> customerAllBookedServicesListForPagination =
      [];

  ///------------------------------- Lawyers-data-check
  bool getCustomerBookedServiceDataCheck = false;
  getCustomerBookedServicesDataCheck(bool value) {
    getCustomerBookedServiceDataCheck = value;
    update();
  }

  int? selectedLawyerCategoryIndex = 0;
  updateSelectedLawyerCategoryIndex(int? newValue) {
    selectedLawyerCategoryIndex = newValue;
    update();
  }

  /// paginated-data-fetch
  Future paginationDataLoad(BuildContext context) async {
    // perform fetching data delay
    // await new Future.delayed(new Duration(seconds: 2));

    log("load more");
    // update data and loading status
    if (getCustomerBookedServicesModel.data!.meta!.lastPage! >
        getCustomerBookedServicesModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      postMethod(
          context,
          '${getCustomerBookedServicesModel.data!.meta!.path}',
          {
            'page':
                (getCustomerBookedServicesModel.data!.meta!.currentPage! + 1),
            'perPage': getCustomerBookedServicesModel.data!.meta!.perPage
          },
          false,
          getAllLawyersRepo);
      update();
    }
  }

  updateLawyerListForPagination(
      CustomerBookedServiceModel customerBookedServiceModel) {
    customerAllBookedServicesListForPagination.add(customerBookedServiceModel);
    update();
  }

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
}
