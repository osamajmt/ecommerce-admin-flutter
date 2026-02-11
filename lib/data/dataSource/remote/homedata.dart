
import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/api_link.dart';
class HomeData {
  Crud crud = Crud();
  HomeData(this.crud);
  getCategories() async {
    try {
      final response = await crud.getData(AppLink.categories,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getItems() async {
    try {
      final response = await crud.getData(AppLink.items,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getSettings() async {
    try {
      final response = await crud.getData(AppLink.settings,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  
 
}