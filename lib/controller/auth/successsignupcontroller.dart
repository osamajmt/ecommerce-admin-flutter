import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:get/get.dart';

abstract class SuccessSignupController extends GetxController {

  goToLogin();
}

class SuccessSignupControllerImp extends SuccessSignupController {
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
