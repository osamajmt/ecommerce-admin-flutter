import 'package:admin_app/bindings/editcategorybinding.dart';
import 'package:admin_app/bindings/edititembinding.dart';
import 'package:admin_app/core/middleware/mymiddleware.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:admin_app/view/screen/admin_profile.dart';
import 'package:admin_app/view/screen/categories/add.dart';
import 'package:admin_app/view/screen/categories/edit.dart';
import 'package:admin_app/view/screen/categories/view.dart';
import 'package:admin_app/view/screen/home.dart';
import 'package:admin_app/view/screen/orders.dart';
import 'package:admin_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:admin_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:admin_app/view/screen/auth/login.dart';
import 'package:admin_app/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:admin_app/view/screen/auth/forgetpassword/verifyemail.dart';
import 'package:admin_app/view/screen/home_screen.dart';
import 'package:admin_app/view/screen/items/add.dart';
import 'package:admin_app/view/screen/items/edit.dart';
import 'package:admin_app/view/screen/items/view.dart';
import 'package:admin_app/view/screen/language_screen.dart';
import 'package:admin_app/view/screen/onboarding_screen.dart';
import 'package:admin_app/view/screen/orders/order_details.dart';
import 'package:admin_app/view/screen/orders/pending_screen.dart';
import 'package:admin_app/view/screen/orders/beaing_prepared_screen.dart';
import 'package:admin_app/view/screen/support_screen.dart';
import 'package:admin_app/view/screen/system_info_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: "/",
    page: () => const Language(),
    middlewares: [Mymiddleware()],
  ),

  GetPage(name: appRoute.home, page: () => const Home()),
  GetPage(name: appRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(name: appRoute.login, page: () => const Login()),
  GetPage(name: appRoute.onboarding, page: () => const OnBoarding()),
  GetPage(name: appRoute.forgetpassword, page: () => const ForgetPassword()),
  GetPage(name: appRoute.verifyemail, page: () => const VerifyEmail()),
  GetPage(name: appRoute.resetpassword, page: () => const ResetPassword()),
  GetPage(
    name: appRoute.successresetpassword,
    page: () => const SuccessResetPassword(),
  ),

  GetPage(name: appRoute.orders, page: () => const Orders()),
  GetPage(
    name: appRoute.pendingOrders,
    page: () => const PendingOrdersScreen(),
  ),
  GetPage(
    name: appRoute.beaingPreparedOrders,
    page: () => const BeaingPreparedOrdersScreen(),
  ),
  GetPage(name: appRoute.orderDetails, page: () => const OrderDetailsScreen()),

  GetPage(name: appRoute.categories, page: () => const Categories()),
  GetPage(name: appRoute.addCategory, page: () => const AddCategory()),
  GetPage(name: appRoute.editCategory, page: () => const EditCategory(),binding: EditCategoryBinding()),

  GetPage(name: appRoute.items, page: () => const Items()),
  GetPage(name: appRoute.addItem, page: () => const AddItem()),
  GetPage(name: appRoute.editItem, page: () => const EditItem(), binding: EditItemBinding(),),

  GetPage(name: appRoute.adminProfile, page: () => const AdminProfile()),
  GetPage(name: appRoute.support, page: () => const SupportPage()),
  GetPage(name: appRoute.systemInfo, page: () => const SystemInfo()),
];
