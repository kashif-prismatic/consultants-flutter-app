import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/themes_controller.dart';

class AppColors {
  AppColors._();

  // Primary Color
  static Color primaryColor = Color(int.parse(
      "0xff${Get.find<GetThemesController>().selectedPrimaryColor!.replaceFirst('#', '')}"));
  static Color secondaryColor = Color(int.parse(
      "0xff${Get.find<GetThemesController>().selectedSecondaryColor!.replaceFirst('#', '')}"));
  static Color tertiaryColor = Color(int.parse(
      "0xff${Get.find<GetThemesController>().selectedTertiaryColor!.replaceFirst('#', '')}"));

  // Regular colors
  static const Color darkGrey = Color(0xff303041);
  static const Color grey = Color(0xFF817B7B);
  static Color tertiaryBgColor = AppColors.tertiaryColor;
  static const Color blue = Color(0xFF4285F4);
  static const Color hintTextGrey = Color(0xFF818181);
  static const Color lightGrey = Color(0xFFC9C9C9);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color burgundy = Color(0xFF880d1e);
  static const Color spaceCadet = Color(0xFFF4FCFE);
  static const Color green = Color(0xFF38FF06);
  static const Color red = Color(0xFFFF0606);
  static const Color orange = Color.fromARGB(255, 255, 114, 6);

  // Custom Dialog Colors
  static const Color customDialogSuccessColor = Color(0xff0FC6C2);
  static const Color customDialogErrorColor = Color(0xffED1E54);
  static const Color customDialogInfoColor = Color(0xffFFA200);
  static const Color customDialogQuestionColor = Color(0xff528AF7);

  // Gradients
  static Gradient gradientOne = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.primaryColor,
      AppColors.secondaryColor,
    ],
  );

  static Gradient gradientTwo = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.tertiaryBgColor,
      AppColors.white,
    ],
  );

  static Gradient gradientThree = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.tertiaryBgColor,
      AppColors.lightGrey,
    ],
  );
}
