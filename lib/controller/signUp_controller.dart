import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/data/network/base_api_servces.dart';
import 'package:quicknsol_assignment/data/network/network_api_services.dart';
import 'package:quicknsol_assignment/utils/routes/route_names.dart';
import 'package:quicknsol_assignment/utils/utils.dart';
import 'package:quicknsol_assignment/view/home/home_screen.dart';
import 'package:quicknsol_assignment/view/login/login_screen.dart';

class SignupController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final emailFocusNode = FocusNode().obs;
  // final passwordFocusNode = FocusNode().obs;
  BaseApiServices _apiServices = NetworkApiService();
  RxBool loading = false.obs;
  void registerUser() async {
    loading.value = true;

    try {
      dynamic response = await _apiServices
          .getPostApiResponse('https://api.escuelajs.co/api/v1/users/', {
        "name": fullNameController.text.toString(),
        "email": emailController.text.toString(),
        "password": passwordController.text.toString(),
        "avatar": "https://picsum.photos/800"
      });
      print("shgsf======>$response");

      if (response['id'] != null) {
        Utils.toastMessage("Register Succesfully.");
        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
        await Future.delayed(Duration(seconds: 3));

        Get.offNamed(RouteName.loginView);
      } else {
        print(response);
      }
      update();
    } catch (e) {
      print(e.toString());
      Utils.flushBarErrorMessage(e.toString(), Get.context!);
    } finally {
      loading.value = false;
    }
  }
}
