import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter_app/firebase_options.dart';
import 'package:firebase_flutter_app/utills/app_utills.dart';
import 'package:firebase_flutter_app/views/chat_screen.dart';
import 'package:firebase_flutter_app/views/delete_page.dart';
import 'package:firebase_flutter_app/views/home_page.dart';
import 'package:firebase_flutter_app/views/intro_screen1.dart';
import 'package:firebase_flutter_app/views/intro_screen2.dart';
import 'package:firebase_flutter_app/views/intro_screen3.dart';
import 'package:firebase_flutter_app/views/login_page.dart';
import 'package:firebase_flutter_app/views/otp_loginpage.dart';
import 'package:firebase_flutter_app/views/otpverify_page.dart';
import 'package:firebase_flutter_app/views/splash_screen.dart';
import 'package:firebase_flutter_app/views/upadateemail_page.dart';
import 'package:firebase_flutter_app/views/update_passwordpage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      initialRoute: '/splash_screen',
      themeMode: ThemeMode.system,
      theme: AppThemes.lighttheme,
      darkTheme: AppThemes.darktheme,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const Home_page()),
        GetPage(name: '/splash_screen', page: () => const Splash_screen1()),
        GetPage(name: '/intro_screen1', page: () => const Intro_screen1()),
        GetPage(name: '/intro_screen2', page: () => const Intro_screen2()),
        GetPage(name: '/intro_screen3', page: () => const Intro_screen3()),
        GetPage(name: '/login_page', page: () => const Login_page()),
        GetPage(name: '/otplogin_page', page: () => const otpLogainpage()),
        GetPage(name: '/otpverify_page', page: () => const Otpverify_page()),
        GetPage(name: '/chat_page', page: () =>  Chat_page()),
        GetPage(
            name: '/update_emailpage', page: () => const UpdateEmail_Page()),
        GetPage(
            name: '/update_passwordpage',
            page: () => const Update_Passwordpage()),
        GetPage(
            name: '/delete_accountpage',
            page: () => const Delete_AccountPage()),
      ],
    ),
  );
}
