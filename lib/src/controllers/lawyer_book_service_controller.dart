import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LawyerBookServiceController extends GetxController {
  TextEditingController serviceQuestionFieldController =
      TextEditingController();

  bool getLawyerBookServiceLoader = false;
  updateLawyerBookServiceLoader(bool newValue) {
    getLawyerBookServiceLoader = newValue;
    update();
  }
}
