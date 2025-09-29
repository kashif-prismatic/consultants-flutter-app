import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/app_colors.dart';
import 'package:lawyer_consultant/src/config/app_text_styles.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';

import '../controllers/general_controller.dart';
import '../controllers/pusher_beams_controller.dart';
import '../controllers/signin_controller.dart';

import '../repositories/signin_repo.dart';
import '../routes.dart';
import '../widgets/auth_text_form_field_widget.dart';
import '../widgets/button_widget.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final logic = Get.put(SigninController());
  final pusherLogic = Get.put(PusherBeamsController());

  bool boolValue = false;
  bool obscurePassword = true;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GestureDetector(onTap: () {
        generalController.focusOut(context);
      }, child: GetBuilder<SigninController>(builder: (signInController) {
        return ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            inAsyncCall: generalController.formLoaderController,
            child: Scaffold(
              backgroundColor: AppColors.tertiaryBgColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/law-hammer.png"),
                        SizedBox(height: 28.h),
                        Text(
                          LanguageConstant.welcomeBack.tr,
                          style: AppTextStyles.bodyTextStyle8,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          LanguageConstant.signInToYourAccount.tr,
                          style: AppTextStyles.bodyTextStyle1,
                        ),
                        SizedBox(height: 28.h),
                        AuthTextFormFieldWidget(
                          hintText: LanguageConstant.userNameEmail.tr,
                          prefixIconColor: AppColors.black,
                          prefixIcon: "assets/icons/Message.png",
                          controller: signInController.emailController,
                          onChanged: (value) {
                            signInController.emailValidator = null;
                            signInController.update();
                          },
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return LanguageConstant.emailFieldRequired.tr;
                            }
                            if (!GetUtils.isEmail(value!)) {
                              return LanguageConstant
                                  .pleaseMakeSureYourEmailAddressIsValid.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        AuthPasswordFormFieldWidget(
                          hintText: LanguageConstant.password.tr,
                          prefixIconColor: AppColors.black,
                          prefixIcon: "assets/icons/Unlock.png",
                          controller: signInController.passwordController,
                          onChanged: (value) {
                            signInController.passwordValidator = null;
                            signInController.update();
                          },
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return LanguageConstant.passwordIsRequired.tr;
                            }
                            return null;
                          },
                          suffixIconOnTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          suffixIcon: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20.h,
                            color: AppColors.lightGrey,
                          ),
                          obsecureText: obscurePassword,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       value: boolValue,
                            //       tristate: false,
                            //       activeColor: AppColors.primaryColo
                            //       visualDensity: const VisualDensity(
                            //           horizontal: -2, vertical: 2),
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(5)),
                            //       side: const BorderSide(
                            //           color: AppColors.primaryColor),
                            //       onChanged: (bool? boolValue) {
                            //         // setState(() {
                            //         //   this.boolValue = boolValue!;
                            //         // });
                            //       },
                            //     ),
                            //     const Text(
                            //       "Remember",
                            //       style: AppTextStyles.bodyTextStyle11,
                            //     )
                            //   ],
                            // ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(PageRoutes.forgotPasswordScreen);
                              },
                              child: Text(
                                LanguageConstant.forgotPassword.tr,
                                style: AppTextStyles.buttonTextStyle3,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ButtonWidgetOne(
                          borderRadius: 10,
                          buttonText: LanguageConstant.signIn.tr,
                          buttonTextStyle: AppTextStyles.buttonTextStyle1,
                          onTap: () {
                            if (_loginFormKey.currentState!.validate()) {
                              generalController.focusOut(context);
                              generalController
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  signInWithEmailURL,
                                  {
                                    'email':
                                        signInController.emailController.text,
                                    'password': signInController
                                        .passwordController.text,
                                    'login_as': "customer"
                                  },
                                  true,
                                  signInWithEmailRepo);
                            }
                          },
                        ),
                        SizedBox(height: 28.h),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(PageRoutes.signupScreen);
                          },
                          child: Text(LanguageConstant.createYourAccount.tr,
                              style: AppTextStyles.underlineTextStyle1),
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            const Expanded(
                                child: Divider(color: AppColors.grey)),
                            Expanded(
                              child: Center(
                                child: Text(
                                  LanguageConstant.or.tr,
                                  style: AppTextStyles.bodyTextStyle7,
                                ),
                              ),
                            ),
                            const Expanded(
                                child: Divider(color: AppColors.grey)),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        ButtonWidgetThree(
                          buttonIcon: "assets/icons/Google.png",
                          buttonText: LanguageConstant.signInViaGoogle.tr,
                          iconHeight: 25.h,
                          onTap: () {
                            signInController.signInWithGoogle();
                          },
                        ),
                        SizedBox(height: 14.h),
                        ButtonWidgetThree(
                          buttonIcon: "assets/icons/Facebook.png",
                          buttonText: LanguageConstant.signInViaFacebook.tr,
                          iconHeight: 25.h,
                          onTap: () {
                            signInController.signinWithFacebook();
                          },
                        ),
                        SizedBox(height: 18.h),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }));
    });
  }
}
