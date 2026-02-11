
import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/api_link.dart';

class NotificationsData {
  Crud crud = Crud();
  NotificationsData(this.crud);
  getNotifications() async {
    try {
      final response = await crud.getData(
        AppLink.notifications,
        {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
}
