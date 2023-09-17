import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/theme_controller.dart';
import '../../utills/helper/firebase_auth_helper.dart';

class Delete_AccountPage extends StatefulWidget {
  const Delete_AccountPage({super.key});

  @override
  State<Delete_AccountPage> createState() => _Delete_AccountPageState();
}

class _Delete_AccountPageState extends State<Delete_AccountPage> {
  String? deleteemail;
  String? deletepassword;

  GlobalKey<FormState> deleteaccountformkey = GlobalKey<FormState>();
  TextEditingController deleteaccountemailController = TextEditingController();
  TextEditingController deleteaccountpasswordController =
      TextEditingController();

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
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
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: (themeController.darkModeModel.isdark)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              "Delete your Account",
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
                  "Confirm your Delete Account and\nwe'll send the instruction",
                  style: TextStyle(
                    fontSize: Get.height * 0.025,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Form(
              key: deleteaccountformkey,
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
                        "Delete your Email",
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
                    controller: deleteaccountemailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter your delete email",
                      label: Text("Delete email"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter delete email";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      deleteemail = val;
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextFormField(
                    controller: deleteaccountpasswordController,
                    decoration: const InputDecoration(
                      hintText: "Enter your delete password",
                      label: Text("Delete password"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter delete password";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      deletepassword = val;
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                      if (deleteaccountformkey.currentState!.validate()) {
                        deleteaccountformkey.currentState!.save();
                        print(FirebaseAuthHelper.firebaseAuthHelper
                            .deleteUserAccount(
                                Email: deleteemail!,
                                Password: deletepassword!));

                        FirebaseAuthHelper.firebaseAuthHelper.deleteUserAccount(
                            Email: deleteemail!, Password: deletepassword!);

                        Get.snackbar(
                            "Delete Account", "Account deleted successfully..",
                            backgroundColor: Colors.green);

                        deleteaccountemailController.clear();
                        deleteaccountpasswordController.clear();
                      }
                    },
                    child: const Text("Deleted your Account"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
