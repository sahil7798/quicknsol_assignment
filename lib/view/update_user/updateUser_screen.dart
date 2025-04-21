import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/controller/signUp_controller.dart';
import 'package:quicknsol_assignment/controller/users_controller.dart';
import 'package:quicknsol_assignment/utils/widgets/custom_button.dart';
import 'package:quicknsol_assignment/utils/widgets/custom_textfield.dart';
import 'package:quicknsol_assignment/view/login/login_screen.dart';

class UpdateuserScreen extends StatefulWidget {
  int id;
  String fullName;
  String email;
  UpdateuserScreen(
      {super.key,
      required this.id,
      required this.fullName,
      required this.email});

  @override
  State<UpdateuserScreen> createState() => _UpdateuserScreenState();
}

class _UpdateuserScreenState extends State<UpdateuserScreen> {
  UsersController updateController = Get.put(UsersController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateController.fullNameController.text = widget.fullName;
    updateController.emailController.text = widget.email;
    updateController.update();
  }

  @override
  Widget build(BuildContext context) {
    //  updateController.emailController.text = widget.email;
    print(widget.email);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Update User",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  CustomTextFiled(
                    controller: updateController.fullNameController,
                    hint: 'Full Name',
                    icon: Icons.person,
                    ktype: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFiled(
                    controller: updateController.emailController,
                    hint: 'Email',
                    icon: Icons.email,
                    ktype: TextInputType.emailAddress,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                title: 'SAVE',
                press: () {
                  updateController.updateUser(id: widget.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
