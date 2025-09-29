import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/models/book_service_model.dart';

import '../models/book_appointment_model.dart';
import '../models/wallet_topup_model.dart';

class MakePaymentController extends GetxController {
  BookAppointmentModel bookAppointmentModel = BookAppointmentModel();
  BookServiceModel bookServiceModel = BookServiceModel();
  WalletTopupModel walletTopupModel = WalletTopupModel();
  TextEditingController amountController = TextEditingController();
  bool makePaymentLoader = false;
  updateMakePaymentLoader(bool newValue) {
    makePaymentLoader = newValue;
    update();
  }
}
