import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:get/get.dart';

abstract class SuccessResetPasswordController extends GetxController {

  goToLogin();
}

class SuccessResetPasswordControllerImp extends SuccessResetPasswordController {
  @override
 
  @override
  goToLogin() {
    Future.microtask(() => Get.offAllNamed(appRoute.login));
  }


  @override
  void dispose() {
    super.dispose();
  }
}
