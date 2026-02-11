import 'package:admin_app/bindings/initialbinding.dart';
import 'package:admin_app/core/localization/changelocal.dart';
import 'package:admin_app/core/localization/translations.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      translations: translations(),
      title: 'Admin App',
      locale: controller.language,
      theme: controller.appTheme,
      initialBinding: InitialBinding(),
      getPages: routes,
    );
  }
}



// import 'package:admin_app/bindings/initialbinding.dart';
// import 'package:admin_app/core/localization/changelocal.dart';
// import 'package:admin_app/core/localization/translations.dart';
// import 'package:admin_app/core/services/services.dart';
// import 'package:admin_app/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// void main() async{
//    WidgetsFlutterBinding.ensureInitialized();
//   await initialServices();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LocalController>(
//       builder: (controller) => GetMaterialApp(
//         translations: translations(),
//         title: 'Admin App',
//         locale: controller.language,
//         theme: controller.appTheme,
//         initialBinding: InitialBinding(),
//         getPages: routes,
//       ),
//     );
//   }
// }

