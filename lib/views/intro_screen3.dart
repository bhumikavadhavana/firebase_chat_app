import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Intro_screen3 extends StatefulWidget {
  const Intro_screen3({super.key});

  @override
  State<Intro_screen3> createState() => _Intro_screen3State();
}

class _Intro_screen3State extends State<Intro_screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/gif/inbox.gif"),
                  ),
                ),
              ),
              const Text("Everything you Can Do in the App",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)
                  // GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "You can share chat with your match.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  // SharedPreferences sharePreferences =
                  //     await SharedPreferences.getInstance();

                  // sharePreferences.setBool('isIntroAccess', true);
                  Get.offNamed('/login_page');
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
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed('/login_page');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.width * 0.13,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.blueAccent),
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
