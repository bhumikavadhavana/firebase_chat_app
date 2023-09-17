import 'package:firebase_flutter_app/controllers/login_out_controllers.dart';
import 'package:firebase_flutter_app/controllers/theme_controller.dart';
import 'package:firebase_flutter_app/utills/helper/firebase_auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/indexedstack_controller.dart';
import '../../utills/utills.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  LogINOutController logINOutController = Get.put(LogINOutController());
  IndexedStackValController indexedStackValController =
      Get.put(IndexedStackValController());
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexedStackValController>(
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: (themeController.darkModeModel.isdark)
                ? Colors.black
                : Colors.white,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: IndexedStack(
              index: indexedStackValController.indexedStackModel.indexstackval,
              children: [
                //signin layer
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        Text(
                          "Log in to your\nAccount",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: (themeController.darkModeModel.isdark)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: signInformkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: signinemailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              label: Text("E-mail 📧"),
                              hintText: "Enter email here...",
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter email first...";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: signinpasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              label: Text("Password 🗝️"),
                              hintText: "Enter password here...",
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter password first...";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueAccent),
                            ),
                            onPressed: () {
                              ValidateAndSignIn();
                              logINOutController.logInOutTrueValue();
                              signinemailController.clear();
                              signinpasswordController.clear();
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.blueAccent,
                              ),
                            ),
                            onPressed: () {
                              Get.offAllNamed('/otplogin_page');
                            },
                            child: const Text(
                              "Sign In with Phone number",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      "or continue with",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          foregroundImage:
                              const AssetImage("assets/images/google.png"),
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              Map<String, dynamic> data =
                                  await FirebaseAuthHelper.firebaseAuthHelper
                                      .signInWithGoogle();

                              if (data['user'] != null) {
                                Get.snackbar("SUCCESSFULLY",
                                    "Login Successfully with Google",
                                    backgroundColor: Colors.green);
                                Get.offNamed('/', arguments: data['user']);
                                // logINOutController.logInOutTrueValue();
                              } else {
                                Get.snackbar("FAILURE", data['msg'],
                                    backgroundColor: Colors.red);
                              }
                            },
                            icon: const Icon(Icons.supervised_user_circle),
                            label: const Text("Sign in with google"),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        CircleAvatar(
                          radius: 18,
                          foregroundImage:
                              const AssetImage("assets/images/user.png"),
                          child: OutlinedButton(
                            onPressed: () async {
                              Map<String, dynamic> data =
                                  await FirebaseAuthHelper.firebaseAuthHelper
                                      .signInAnonymously();

                              if (data['user'] != null) {
                                Get.snackbar(
                                  "SUCCESSFULLY",
                                  "Login Successfully with Anonymous",
                                  backgroundColor: Colors.green,
                                );
                                Get.offNamed('/', arguments: data['user']);
                                logINOutController.logInOutTrueValue();
                              } else {
                                Get.snackbar(
                                  "NOT SUCCESSFULLY",
                                  data['msg'],
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            child: Text(""),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        CircleAvatar(
                          radius: 15,
                          foregroundImage:
                              const AssetImage("assets/images/facebook.png"),
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              //   Map<String, dynamic> data =
                              // //  await FirebaseAuthHelper.firebaseAuthHelper
                              //       //.signInWithFacebook();
                              //
                              //   if (data['user'] != null) {
                              //     Get.snackbar("SUCCESSFULLY",
                              //         "Login Successfully with Facebook😊..",
                              //         backgroundColor: Colors.green);
                              //     Get.offNamed('/', arguments: data['user']);
                              //     logINOutController.logInOutTrueValue();
                              //
                              //   } else {
                              //     Get.snackbar(
                              //       "FAILURE",
                              //       data['msg'],
                              //       backgroundColor: Colors.red,
                              //     );
                              //   }
                            },
                            icon: const Icon(Icons.facebook),
                            label: const Text(
                              "Sign in with facebook",
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     OutlinedButton.icon(
                    //       onPressed: () async {
                    //         Map<String, dynamic> data = await FirebaseAuthHelper
                    //             .firebaseAuthHelper
                    //             .signInWithFacebook();
                    //
                    //         if (data['user'] != null) {
                    //           Get.snackbar("SUCCESSFULLY",
                    //               "Login Successfully with Facebook😊..",
                    //               backgroundColor: Colors.green);
                    //           Get.offNamed('/', arguments: data['user']);
                    //         } else {
                    //           Get.snackbar("FAILURE", data['msg'],
                    //               backgroundColor: Colors.red);
                    //         }
                    //       },
                    //       icon: const Icon(Icons.facebook),
                    //       label: const Text("Sign in with facebook"),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Don't have an account ?? ",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign Up,",
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blueAccent),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  indexedStackValController
                                      .indexedStackModel.indexstackval = 1;
                                });
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //sign up layer
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    // Image.asset(
                    //   "assets/images/signup.png",
                    //   height: 300,
                    //   width: 300,
                    // ),
                    Row(
                      children: [
                        Text(
                          "Create your\nAccount",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: (themeController.darkModeModel.isdark)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: signUpformkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: signupemailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                label: Text("E-mail 📧"),
                                hintText: "Enter email here...",
                                border: OutlineInputBorder()),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter email first...";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (v) {
                            //   email = v;
                            // },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: signuppasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              label: Text("Password 🗝️"),
                              hintText: "Enter password here...",
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter password first...";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (v) {
                            //   password = v;
                            // },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueAccent),
                            ),
                            onPressed: () {
                              ValidateAndSignUp();
                              logINOutController.logInOutTrueValue();

                              signupemailController.clear();
                              signuppasswordController.clear();

                              // setState(() {
                              //   email = null;
                              //   password = null;
                              // });
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueAccent),
                            ),
                            onPressed: () {
                              Get.offAllNamed('/otplogin_page');
                              // Get.dialog(
                              //   AlertDialog(
                              //     title: Text(
                              //       "Enter Your Phone-Number",
                              //       style: GoogleFonts.aBeeZee(
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     actions: [
                              //       Container(
                              //         height: 400,
                              //         width: double.infinity,
                              //         child: Column(
                              //           children: [
                              //             TextFormField(
                              //               controller: phoneController,
                              //               validator: (val) {
                              //                 if (val!.isEmpty) {
                              //                   return "Please enter phone number";
                              //                 }
                              //                 return null;
                              //               },
                              //               decoration: const InputDecoration(
                              //                 hintText: "Enter Phone-Number",
                              //                 label: Text("Phone Number"),
                              //                 border: OutlineInputBorder(),
                              //               ),
                              //             ),
                              //             const SizedBox(
                              //               height: 10,
                              //             ),
                              //             // TextFormField(
                              //             //   controller: phonepasswordController,
                              //             //   validator: (val) {
                              //             //     if (val!.isEmpty) {
                              //             //       return "Please enter password";
                              //             //     }
                              //             //     return null;
                              //             //   },
                              //             //   decoration: const InputDecoration(
                              //             //     hintText: "Enter Password",
                              //             //     label: Text("Password"),
                              //             //     border: OutlineInputBorder(),
                              //             //   ),
                              //             // ),
                              //             // const SizedBox(
                              //             //   height: 30,
                              //             // ),
                              //             ElevatedButton(
                              //               onPressed: () async {
                              //                 FirebaseAuthHelper
                              //                     .firebaseAuthHelper
                              //                     .fetchOTP();
                              //               },
                              //               child: const Text("Fetch OTP"),
                              //             ),
                              //             ElevatedButton(
                              //               style: const ButtonStyle(
                              //                 backgroundColor:
                              //                     MaterialStatePropertyAll(
                              //                   Colors.blueAccent,
                              //                 ),
                              //               ),
                              //               onPressed: () async {
                              //                 FirebaseAuthHelper
                              //                     .firebaseAuthHelper
                              //                     .veRIfy();
                              //               },
                              //               child: const Text(
                              //                 "Send",
                              //                 style: TextStyle(
                              //                   color: Colors.white,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                            child: const Text(
                              "Sign Up with Phone number",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Already have an account ?? ",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blueAccent),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  indexedStackValController
                                      .indexedStackModel.indexstackval = 0;
                                });
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<void> ValidateAndSignUp() async {
  if (signUpformkey.currentState!.validate()) {
    signUpformkey.currentState!.save();

    Map<String, dynamic> data = await FirebaseAuthHelper.firebaseAuthHelper
        .signUpWithEmailPassword(
            Email: signupemailController.text,
            Password: signuppasswordController.text);

    if (data['user'] != null) {
      Get.snackbar(
        "SUCCESSFULLY",
        "successfully signup....😊",
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      );
    } else {
      Get.snackbar(
        "NOT SUCCESSFULLY",
        data['msg'],
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      );
    }
  }
}

Future<void> ValidateAndSignIn() async {
  if (signInformkey.currentState!.validate()) {
    signInformkey.currentState!.save();

    Map<String, dynamic> data = await FirebaseAuthHelper.firebaseAuthHelper
        .signInWithEmailPassword(
            Email: signinemailController.text,
            Password: signinpasswordController.text);

    if (data['user'] != null) {
      Get.snackbar(
        "SUCCESSFULLY",
        "successfully login....😊",
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      );
      Get.offNamed('/', arguments: data['user']);
    } else {
      Get.snackbar(
        "NOT SUCCESSFULLY",
        data['msg'],
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      );
    }
  }
}
