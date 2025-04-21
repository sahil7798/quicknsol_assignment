import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/controller/users_controller.dart';
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
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            "Users List",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.users.value.length,
                  itemBuilder: (ctx, int index) {
                    var user = controller.users[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text(
                          user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.email,
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
                                      color: Colors.deepPurpleAccent),
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
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Confirm delete'),
                                      content: Text('Are you sure?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  ).then(
                                    (confirmed) {
                                      if (confirmed) {
                                        controller.deleteUser(id: user.id);
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        ));
  }
}
