import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/app_colors.dart';
import 'package:lawyer_consultant/src/config/app_font.dart';

import '../controllers/all_events_controller.dart';
import '../controllers/all_featured_lawyers_controller.dart';
import '../controllers/all_law_firms_controller.dart';
import '../controllers/all_lawyers_controller.dart';
import '../controllers/all_services_controller.dart';
import '../controllers/all_top_rated_lawyers_controller.dart';
import '../controllers/get_carousel_banner_controller.dart';
import '../models/logged_in_user_model.dart';
import '../api_services/get_service.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../controllers/general_controller.dart';

import '../repositories/all_events_repo.dart';
import '../repositories/all_featured_lawyers_repo.dart';
import '../repositories/all_law_firms_repo.dart';
import '../repositories/all_lawyers_repo.dart';
import '../repositories/all_services_repo.dart';
import '../repositories/all_top_rated_lawyers_repo.dart';
import '../repositories/get_carousel_banner_repo.dart';
import '../routes.dart';
import '../widgets/background_widgets/splash_screen_background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late AnimationController _controller;
  final allLawyerslogic = Get.put(AllLawyersController());
  final featuredLawyerslogic = Get.put(AllFeaturedLawyersController());
  final topRatedLawyerslogic = Get.put(AllTopRatedLawyersController());
  final allEventslogic = Get.put(AllEventsController());
  final allServiceslogic = Get.put(AllServicesController());
  final allLawFirmslogic = Get.put(AllLawFirmsController());
  final allCarouselBannerlogic = Get.put(GetAllCarouselBannerController());

  startTime() async {
    var duration = const Duration(seconds: 5);

    return Timer(duration, checkFirstSeenAndNavigate);
  }

  Future checkFirstSeenAndNavigate() async {
    bool seen =
        (Get.find<GeneralController>().storageBox.read('seen') ?? false);

    if (seen) {
      Get.toNamed(PageRoutes.homeScreen);
    } else {
      await Get.find<GeneralController>().storageBox.write('seen', true);
      Get.toNamed(PageRoutes.introScreen);
    }
  }

  @override
  void initState() {
    super.initState();

    if (Get.find<GeneralController>().storageBox.hasData('userData') &&
        Get.find<GeneralController>().storageBox.hasData('authToken')) {
      Get.find<GeneralController>().currentUserModel = User.fromJson(jsonDecode(
          Get.find<GeneralController>().storageBox.read('userData')));
    }
    log("${Get.find<GeneralController>().storageBox.read('userData')} Intro User Data");
    // Get All Carousel Banner on Home Page
    getMethod(
        context, getCarouselBannerUrl, null, false, getAllCarouselBannerRepo);
    // Get All Lawyers on Home Page
    postMethod(
        context, '$getAllLawyers?page=1', null, false, getAllLawyersRepo);
    // Get All Featured Lawyers on Home Page
    getMethod(context, getFeaturedLawyers, {'limit': 10}, false,
        getAllFeaturedLawyersRepo);
    // Get All Top Rated Lawyers on Home Page
    getMethod(context, getTopRatedLawyers, {'limit': 10}, false,
        getAllTopRatedLawyersRepo);
    // Get All Events on Home Page
    postMethod(context, '$getAllEvents?page=1', null, false, getAllEventsRepo);
    // Get All Services on Home Page
    postMethod(
        context, '$getAllServices?page=1', null, false, getAllServicesRepo);
    // Get All Law Firms on Home Page
    postMethod(
        context, '$getAllLawFirms?page=1', null, false, getAllLawFirmsRepo);

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    startTime();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 10800),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Positioned(child: SplashBackgroundWidget()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Container(
                    width: animation.value * 450,
                    height: animation.value * 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/app-icon.png"),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
