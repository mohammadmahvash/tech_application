import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/services/dio_service.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activatedCodeTextEditingController =
      TextEditingController();

  var email = "";
  var userId = "";

  registerEmail() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register'
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailTextEditingController.text;
    userId = response.data['user_id'];
    log(response.data.toString());
  }

  verifyCode() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activatedCodeTextEditingController.text,
      'command': 'verify',
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    log(response.data.toString());
  }
}
