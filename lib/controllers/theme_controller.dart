import 'package:firebase_flutter_app/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utills/utills.dart';



class ThemeController extends GetxController {
  ThemeModel darkModeModel = ThemeModel(
    isdark: box.read('isDarkMode') ?? false,
  );

  darkThemeUDF({required bool val}) {
    darkModeModel.isdark = val;
    box.write('isDarkMode', darkModeModel.isdark);
    (darkModeModel.isdark)
        ? Get.changeTheme(
      ThemeData.dark(
        useMaterial3: true,
      ),
    )
        : Get.changeTheme(
      ThemeData.light(useMaterial3: true),
    );
    update();
  }
}
//   ThemeModel darkModeModel = ThemeModel(
//     isdark: box.read('isDarkMode') ?? false,
//   );
//
//   darkThemeUDF({required bool val}) {
//     darkModeModel.isdark = val;
//     box.write('isDarkMode', darkModeModel.isdark);
//     (darkModeModel.isdark)
//         ? Get.changeTheme(
//       ThemeData.dark(
//         // useMaterial3: true,
//       ),
//     )
//         : Get.changeTheme(
//       ThemeData.light(),
//     );
//     update();
//   }
// }