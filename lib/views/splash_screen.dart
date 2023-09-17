import 'package:firebase_flutter_app/utills/helper/firebase_auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/introscreen_controller.dart';
import '../../controllers/login_out_controllers.dart';

class Splash_screen1 extends StatefulWidget {
  const Splash_screen1({super.key});

  @override
  State<Splash_screen1> createState() => _Splash_screen1State();
}

class _Splash_screen1State extends State<Splash_screen1> {
  //@override
  // void initState() {
  //   super.initState();
  // introvisited() async {
  // SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  // sharedPreferences.setBool('isIntroAccess', true);
  // Get.offNamed('/intro_screen1');
  // }
//  }
  LogINOutController loginoutController = Get.put(LogINOutController());
  IntroAccessController introAccessController =
      Get.put(IntroAccessController());

  @override
  Widget build(BuildContext context) {
    // Future.delayed(
    //   const Duration(seconds: 5),
    //   () => Get.offNamed('/intro_screen1'),
    // );
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => (introAccessController.introAccess_Model.introaccess)
          ? (loginoutController.loginInOutModel.islogin)
              ? Get.offAndToNamed(
                  '/',
                  arguments: FirebaseAuthHelper.firebaseAuth.currentUser,
                )
              : Get.offAndToNamed(
                  '/login_page',
                  arguments: FirebaseAuthHelper.firebaseAuth.currentUser,
                )
          : Get.offAllNamed(
              '/intro_screen1',
              arguments: FirebaseAuthHelper.firebaseAuth.currentUser,
            ),
    );
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/chat.png"),
            ),
          ),
        ),
      ),
    );
  }
}
