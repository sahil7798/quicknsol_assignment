import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:quicknsol_assignment/utils/routes/route_names.dart';
import 'package:quicknsol_assignment/view/home/home_screen.dart';
import 'package:quicknsol_assignment/view/login/login_screen.dart';
import 'package:quicknsol_assignment/view/signUp/signUp_screen.dart';
import 'package:quicknsol_assignment/view/splash/splash_screen.dart';
import 'package:quicknsol_assignment/view/update_user/updateUser_screen.dart';

class AppRoutes {
  // String? name;
  // String? email;
  // int? id;
  // AppRoutes(this.name, this.email, this.id);
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.loginView,
          page: () => LoginScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.signUpView,
          page: () => SignupScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeView,
          page: () => HomeScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        // GetPage(
        //   name: RouteName.userUpdateView,
        //   page: () => UpdateuserScreen(
        //     email: email!,
        //     fullName: name!,
        //     id: id!,
        //   ),
        //   transitionDuration: Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),
      ];
}
