// lib/controller/users_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/data/db_helper.dart';
import 'package:quicknsol_assignment/data/network/network_api_services.dart';
import 'package:quicknsol_assignment/model/userListModel.dart';
import 'package:quicknsol_assignment/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class UsersController extends GetxController {
  // ---------- UI ----------
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final RxList<UserListModel> users = <UserListModel>[].obs;

  // ---------- Services ----------
  final _api = NetworkApiService();
  final _db = DBHelper();

  // ---------- Lifecycle ----------
  @override
  void onInit() {
    super.onInit();
    _startConnectivityListener();
    fetchUsers(); // initial load (cached + remote)
  }

  // -----------------------------------------------------------------
  // 1. FETCH (always from remote when online, otherwise from cache)
  // -----------------------------------------------------------------
  Future<void> fetchUsers() async {
    _isLoading.value = true;
    try {
      // 1. Try remote
      if (await _api.isOnline()) {
        final raw = await _api
            .getGetApiResponse('https://api.escuelajs.co/api/v1/users');
        final List<UserListModel> remote =
            (raw as List).map((j) => UserListModel.fromJson(j)).toList();

        // Persist a **local copy** (simple in-memory for demo)
        users.assignAll(remote);
      }
      // 2. If offline → keep what we already have (could be empty)
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), Get.context!);
    } finally {
      _isLoading.value = false;
    }
  }

  // -----------------------------------------------------------------
  // 2. DELETE
  // -----------------------------------------------------------------
  Future<void> deleteUser({required int id}) async {
    final payload = {'id': id};

    if (await _api.isOnline()) {
      await _api.getDeleteApiResponse(
          'https://api.escuelajs.co/api/v1/users/$id', '');
      _removeLocally(id);
      Utils.toastMessage('User Deleted');
    } else {
      // queue
      await _db.enqueue('delete', payload);
      _removeLocally(id); // optimistic UI
      Utils.toastMessage('Queued for deletion (offline)');
    }
  }

  // -----------------------------------------------------------------
  // 3. UPDATE
  // -----------------------------------------------------------------
  Future<void> updateUser({required int id}) async {
    final payload = {
      'id': id,
      'name': fullNameController.text.trim(),
      'email': emailController.text.trim(),
    };

    if (await _api.isOnline()) {
      final resp = await _api.getUpdateApiResponse(
          'https://api.escuelajs.co/api/v1/users/$id', payload);
      if (resp['id'] != null) {
        _applyUpdateLocally(payload);
        Utils.toastMessage('Updated');
        Get.back();
      }
    } else {
      await _db.enqueue('update', payload);
      _applyUpdateLocally(payload); // optimistic UI
      Utils.toastMessage('Queued for update (offline)');
      Get.back();
    }
  }

  // -----------------------------------------------------------------
  // 4. REFRESH (pull-to-refresh)
  // -----------------------------------------------------------------
  Future<void> refreshScreen() async {
    users.clear();
    await fetchUsers();
    await _syncPending(); // also push any queued ops
  }

  // -----------------------------------------------------------------
  // 5. LOCAL HELPERS (optimistic UI)
  // -----------------------------------------------------------------
  void _removeLocally(int id) {
    users.removeWhere((u) => u.id == id);
  }

  void _applyUpdateLocally(Map<String, dynamic> payload) {
    final idx = users.indexWhere((u) => u.id == payload['id']);
    if (idx != -1) {
      users[idx] = users[idx].copyWith(
        name: payload['name'],
        email: payload['email'],
      );
    }
  }

  // -----------------------------------------------------------------
  // 6. CONNECTIVITY LISTENER → auto-sync when back online
  // -----------------------------------------------------------------
  void _startConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await _syncPending();
      }
    });
  }

  // -----------------------------------------------------------------
  // 7. RE-PLAY QUEUE
  // -----------------------------------------------------------------
  Future<void> _syncPending() async {
    final pending = await _db.getPending();
    if (pending.isEmpty) return;

    _isLoading.value = true;
    for (final row in pending) {
      final op = row['operation'] as String;
      final payload =
          jsonDecode(row['payload'] as String) as Map<String, dynamic>;

      try {
        if (op == 'delete') {
          await _api.getDeleteApiResponse(
              'https://api.escuelajs.co/api/v1/users/${payload['id']}', '');
          _removeLocally(payload['id']);
        } else if (op == 'update') {
          await _api.getUpdateApiResponse(
              'https://api.escuelajs.co/api/v1/users/${payload['id']}',
              payload);
          _applyUpdateLocally(payload);
        }
        await _db.deleteFromQueue(row['id'] as int);
      } catch (e) {
        // keep in queue – will retry next time
        Utils.flushBarErrorMessage('Sync error: $e', Get.context!);
        break; // stop on first failure to preserve order
      }
    }
    _isLoading.value = false;
    users.refresh();
  }
}
