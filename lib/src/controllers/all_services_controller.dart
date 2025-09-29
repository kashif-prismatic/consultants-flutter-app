import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../api_services/post_service.dart';
import '../models/all_services_model.dart';
import '../repositories/all_services_repo.dart';
import 'general_controller.dart';

class AllServicesController extends GetxController {
  GetAllServicesModel getAllServicesModel = GetAllServicesModel();

  bool allServicesLoader = false;
  updateServicesLoader(bool newValue) {
    allServicesLoader = newValue;
    update();
  }

  ServiceModel selectedServiceForView = ServiceModel();
  GetAllServicesDataModel getAllServicesDataModel = GetAllServicesDataModel();

  List<ServiceModel> servicesListForPagination = [];

  updateSelectedServiceForView(
    ServiceModel newValue,
  ) {
    selectedServiceForView = newValue;

    update();
  }

  ///------------------------------- Lawyers-data-check
  bool getServicesDataCheck = false;
  getServicesDataCheckCheck(bool value) {
    getServicesDataCheck = value;
    update();
  }

  int? selectedServicesCategoryIndex = 0;
  updateSelectedServicesCategoryIndex(int? newValue) {
    selectedServicesCategoryIndex = newValue;
    update();
  }

  /// paginated-data-fetch
  Future paginationDataLoad(BuildContext context) async {
    // perform fetching data delay
    // await new Future.delayed(new Duration(seconds: 2));

    log("load more");
    // update data and loading status
    if (getAllServicesModel.data!.meta!.lastPage! >
        getAllServicesModel.data!.meta!.currentPage!) {
      Get.find<GeneralController>().changeGetPaginationProgressCheck(true);

      postMethod(
          context,
          '${getAllServicesModel.data!.meta!.path}',
          {
            'page': (getAllServicesModel.data!.meta!.currentPage! + 1),
            'perPage': getAllServicesModel.data!.meta!.perPage
          },
          false,
          getAllServicesRepo);
      update();
    }
  }

  updateServicesListForPagination(ServiceModel serviceModel) {
    servicesListForPagination.add(serviceModel);
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
