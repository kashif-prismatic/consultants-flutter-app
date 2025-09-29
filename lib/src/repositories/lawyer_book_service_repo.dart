import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/general_controller.dart';
import '../controllers/lawyer_book_service_controller.dart';

getLawyerBookServiceRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    // Get.find<LawyerAppointmentScheduleController>()
    //         .getLawyerAppointmentScheduleModel =
    //     GetLawyerAppointmentScheduleModel.fromJson(response);
    Get.find<LawyerBookServiceController>().updateLawyerBookServiceLoader(true);
    // log("${Get.find<LawyerAppointmentScheduleController>().getLawyerAppointmentScheduleModel.data!} Total Lawyer Book Appointment Length");

    Get.find<GeneralController>().changeGetPaginationProgressCheck(false);
  } else if (!responseCheck) {
    Get.find<LawyerBookServiceController>().updateLawyerBookServiceLoader(true);
  }
}
