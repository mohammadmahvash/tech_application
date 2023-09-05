import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/component/constant/api_constant.dart';
import 'package:tech_application/component/constant/my_storage.dart';
import 'package:tech_application/services/dio_service.dart';
import 'package:tech_application/view/main_screen/main_screen.dart';

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
    if (response.data["response"] == "verified") {
      var box = GetStorage();
      box.write(MyStorage.token, response.data["token"]);
      box.write(MyStorage.userId, response.data["user_id"]);

      Get.to(() => MainScreen());
    } else {
      log("error");
    }
  }
}
