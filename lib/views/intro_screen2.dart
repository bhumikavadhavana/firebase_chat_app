import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Intro_screen2 extends StatefulWidget {
  const Intro_screen2({super.key});

  @override
  State<Intro_screen2> createState() => _Intro_screen2State();
}

class _Intro_screen2State extends State<Intro_screen2> {
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
                    image: AssetImage("assets/gif/connectivity.gif"),
                  ),
                ),
              ),
              const Text("Let's Connect with Everyone in the world",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                  // GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "It's easy to find a soul mate nearby & around you.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  // SharedPreferences sharePreferences =
                  //     await SharedPreferences.getInstance();

                  // sharePreferences.setBool('isIntroAccess', true);

                  Get.offNamed('/intro_screen3');
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
                        color: Colors.white),
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
