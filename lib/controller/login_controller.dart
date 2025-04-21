import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/data/network/base_api_servces.dart';
import 'package:quicknsol_assignment/data/network/network_api_services.dart';
import 'package:quicknsol_assignment/data/shared_pref.dart';
import 'package:quicknsol_assignment/model/userListModel.dart';
import 'package:quicknsol_assignment/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:quicknsol_assignment/view/home/home_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  BaseApiServices _apiServices = NetworkApiService();
  RxBool loading = false.obs;
  void login() async {
    loading.value = true;

    try {
      dynamic response = await _apiServices
          .getPostApiResponse('https://api.escuelajs.co/api/v1/auth/login', {
        "email": emailController.value.text.toString(),
        "password": passwordController.value.text.toString()
      });

      if (response['access_token'] != null) {
        print("udgyddy======>${response['access_token']}");
        // SharedPrefrence().setAccessToken(response['access_token'].toString());
        // SharedPrefrence().setRefToken(response['refresh_token'].toString());
        Utils.toastMessage('Login Succesfully');
        await Future.delayed(Duration(seconds: 3));
        Get.off(HomeScreen());
      } else {
        print(response);
      }
      update();
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), Get.context!);
    } finally {
      loading.value = false;
    }
  }
}
