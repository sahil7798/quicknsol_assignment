import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/controller/users_controller.dart';
import 'package:quicknsol_assignment/model/userListModel.dart';

import 'package:quicknsol_assignment/utils/routes/route_names.dart';
import 'package:quicknsol_assignment/utils/routes/routes.dart';
import 'package:quicknsol_assignment/utils/widgets/custom_dialog.dart';
import 'package:quicknsol_assignment/utils/config/app_colors.dart';
import 'package:quicknsol_assignment/view/signUp/signUp_screen.dart';
import 'package:quicknsol_assignment/view/update_user/updateUser_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(UsersController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Users List",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () => Get.offNamed(RouteName.loginView),
                icon: Icon(Icons.logout))
          ],
        ),
        //drawer: Drawer(),
        body: Obx(
          () => controller.isLoading.value && controller.users.value.isEmpty
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: controller.refreshScreen,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: ListView.builder(
                        itemCount: controller.users.value.length,
                        itemBuilder: (ctx, int index) {
                          var user = controller.users[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: lightDivColor,
                            child: ListTile(
                              leading:
                                  CircleAvatar(child: Text('${index + 1}')),
                              title: Text(
                                user.name,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.email,
                                    maxLines: 1,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    user.creationAt.toString(),
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.edit,
                                            color: lightPrimaryColor),
                                        onPressed: () {
                                          Get.to(UpdateuserScreen(
                                            id: user.id,
                                            email: user.email.toString(),
                                            fullName: user.name.toString(),
                                          ));
                                        }),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        Get.dialog(
                                          CutomDialog(
                                            tapn: () => Get.back(),
                                            tapy: () {
                                              controller.deleteUser(
                                                  id: user.id);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
        ));
  }
}
