import 'package:get/get.dart';
import 'package:lawyer_consultant/src/models/get_themes_model.dart';

class GetThemesController extends GetxController {
  GetThemesModel getThemesModel = GetThemesModel();
  GetThemesDataModel getThemesDataModel = GetThemesDataModel();
  String? selectedPrimaryColor;
  String? selectedSecondaryColor;
  String? selectedTertiaryColor;
  String? themeCode;
  bool themesLoader = false;
  updateThemesLoader(bool newValue) {
    themesLoader = newValue;
    update();
  }
}
