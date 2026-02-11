import 'package:admin_app/api_link.dart';
import 'package:admin_app/core/class/crud.dart';

class LogoutData {
  Crud crud;
  LogoutData(this.crud);

  logout() async {
    final response = await crud.postData(
      AppLink.logoutURL,
      {}, 
      {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
