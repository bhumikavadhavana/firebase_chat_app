import 'package:firebase_flutter_app/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utills/helper/firebase_auth_helper.dart';

class Update_Passwordpage extends StatefulWidget {
  const Update_Passwordpage({super.key});

  @override
  State<Update_Passwordpage> createState() => _Update_PasswordpageState();
}

class _Update_PasswordpageState extends State<Update_Passwordpage> {
  GlobalKey<FormState> updatepasswordkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  String? newpassword;

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 150,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      color: (themeController.darkModeModel.isdark)
                          ? Colors.white
                          : Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              "Update your password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Get.height * 0.026,
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Confirm your New Password and\nwe'llsend the instruction",
                  style: TextStyle(
                    fontSize: Get.height * 0.025,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Form(
              key: updatepasswordkey,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.08,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined),
                      SizedBox(
                        width: Get.height * 0.01,
                      ),
                      Text(
                        "Your updated Password",
                        style: TextStyle(
                          fontSize: Get.height * 0.015,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter your updated password",
                      label: Text("Update password"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      newpassword = val;
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (updatepasswordkey.currentState!.validate()) {
                        updatepasswordkey.currentState!.save();
                        print(updatePassword());
                        updatePassword();

                        passwordController.clear();
                      }
                      Get.back();
                    },
                    child: const Text("Update Password"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  updatePassword() {
    FirebaseAuthHelper.firebaseAuthHelper.updateUserPassWord(newpassword!);

    Get.snackbar(
      "Update Password",
      "Updated password successfully...",
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }
}
