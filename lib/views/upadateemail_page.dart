import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/theme_controller.dart';
import '../../utills/helper/firebase_auth_helper.dart';

class UpdateEmail_Page extends StatefulWidget {
  const UpdateEmail_Page({super.key});

  @override
  State<UpdateEmail_Page> createState() => _UpdateEmail_PageState();
}

class _UpdateEmail_PageState extends State<UpdateEmail_Page> {
  GlobalKey<FormState> updateemailformkey = GlobalKey<FormState>();
  String? newemail;
  TextEditingController updateemailController = TextEditingController();

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text("Update E-mail"),
      // ),
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
              height: Get.height * 0.03,
            ),
            Text(
              "Update your email",
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
                  "Confirm your New Email and we'll \nsend the instruction",
                  style: TextStyle(
                    fontSize: Get.height * 0.025,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Form(
              key: updateemailformkey,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined),
                      SizedBox(
                        width: Get.height * 0.01,
                      ),
                      Text(
                        "Your updated Email",
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
                    controller: updateemailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter your updated email",
                      label: Text("Update email"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      newemail = val;
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (updateemailformkey.currentState!.validate()) {
                        updateemailformkey.currentState!.save();
                        print(updateUserEmail());
                        updateUserEmail();
                        updateemailController.clear();
                      }
                      Get.back();
                    },
                    child: const Text("Update E-mail"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.09,
            ),
            const Text(
              "Please check your updated email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserEmail() async {
    await FirebaseAuthHelper.firebaseAuthHelper.updateUserEmail(newemail!);

    Get.snackbar(
      "Update E-mail",
      "Your email is successfully updated..",
      backgroundColor: Colors.green,
      duration: const Duration(
        seconds: 1,
      ),
    );
  }
}
