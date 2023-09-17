import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/introscreen_controller.dart';

class Intro_screen1 extends StatefulWidget {
  const Intro_screen1({super.key});

  @override
  State<Intro_screen1> createState() => _Intro_screen1State();
}

class _Intro_screen1State extends State<Intro_screen1> {
  IntroAccessController introAccessController =
      Get.put(IntroAccessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/gif/inbox.gif"),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "The Best Social Media App of the Century",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                // GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "The best messenger and chat app of the century we make your day great.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 19),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  // Get.offNamed('/intro_screen2');
                  introAccessController.introAccessControllerTrueValue(
                      val: true);
                  Get.offAllNamed('/login_page');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.width * 0.13,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed('/login_page2');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.width * 0.13,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(
                      0.55,
                    ),
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
