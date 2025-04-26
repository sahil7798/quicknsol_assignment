import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/data/network/base_api_servces.dart';
import 'package:quicknsol_assignment/data/network/network_api_services.dart';
import 'package:quicknsol_assignment/model/userListModel.dart';
import 'package:quicknsol_assignment/utils/utils.dart';
import 'package:quicknsol_assignment/view/home/home_screen.dart';

class UsersController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool get isLoading => _isLoading;

  RxBool _isLoading = false.obs;
  BaseApiServices _apiServices = NetworkApiService();
  RxList<UserListModel> users = <UserListModel>[].obs;
  Future<void> fetchUsers() async {
    _isLoading.value = true;
    update();
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('https://api.escuelajs.co/api/v1/users');

      if (response != null) {
        List<dynamic> newData = response;
        users.value =
            newData.map((json) => UserListModel.fromJson(json)).toList();
        print("data=======>${users[0].avatar}");
        update();
      }
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), Get.context!);
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> deleteUser({required int id}) async {
    _isLoading = false.obs;
    update();
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          'https://api.escuelajs.co/api/v1/users/${id}', "");

      if (response == true) {
        Utils.toastMessage('User Deleted Success');
        fetchUsers();
        Get.back();
        update();
      }

      update();
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), Get.context!);
    } finally {
      _isLoading = false.obs;
      update();
    }
  }

  Future<void> updateUser({required int id}) async {
    _isLoading = false.obs;
    update();
    try {
      dynamic response = await _apiServices
          .getUpdateApiResponse('https://api.escuelajs.co/api/v1/users/${id}', {
        "email": emailController.text.toString(),
        "name": fullNameController.text.toString()
      });

      if (response['id'] != null) {
        Utils.toastMessage("Updated Succesfully!");

        fetchUsers();
        Get.back();
      }

      update();
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), Get.context!);
    } finally {
      _isLoading = false.obs;
      update();
    }
  }

  Future refreshScreen() async {
    users.clear();
    fetchUsers();
  }
}
