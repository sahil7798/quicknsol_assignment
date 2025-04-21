// import 'package:get/get.dart';
// import 'package:quicknsol_assignment/view/login/login_screen.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';

// class SharedPrefrence {
//   late String accessToken;
//   late String refreshToken;

//   Future<bool> setAccessToken(String accessToken) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setString("access_token", accessToken);
//   }

//   Future<String> getAccessToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString("access_token") ?? '';
//   }

//   Future<bool> setRefToken(String refreshToken) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setString("refresh_token", refreshToken);
//   }

//   Future<String> getRefToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString("refresh_token") ?? '';
//   }

//   Future<bool> tryAutoLogin() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     if (!prefs.containsKey("access_token")) {
//       return false;
//     } else {
//       // final extractedUserData =
//       //     json.decode(pref.getString('user_fname').toString());

//       // print(extractedUserData['user_id']);
//       // print(extractedUserData['user_token']);

//       return true;
//     }
//   }

//   static logOut() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear();

//     Get.off(() => LoginScreen());
//   }
// }
