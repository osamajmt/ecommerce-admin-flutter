
import 'dart:convert';

import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/api_link.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class ItemsData {
  Crud crud = Crud();
  ItemsData(this.crud);
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
   addItem(String categoryName,String name, String nameAr,String desc,String descAr,String count,String price,String? discount, String imagePath) async {
    try {
      Services myServices = Get.find();
      String? token = await myServices.secureStorage.read(key: "token");

      var request =
          http.MultipartRequest("POST", Uri.parse(AppLink.items));

      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      request.fields['categoryName'] = categoryName;
      request.fields['name'] = name;
      request.fields['nameAr'] = nameAr;
      request.fields['desc'] = desc;
      request.fields['descAr'] = descAr;
      request.fields['price'] = price;
      request.fields['count'] = count;
      request.fields['discount'] = discount!;

     if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imagePath));
      }
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      return jsonDecode(responseBody.body);
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
  editItem(
     String categoryName, String id,String name, String nameAr,String desc,String descAr,String price,String count,String? discount, String? imagePath,String isActive) async {
    try {
      Services myServices = Get.find();
      String? token = await myServices.secureStorage.read(key: "token");

      var request = http.MultipartRequest(
          "POST", Uri.parse("${AppLink.editItem}/$id"));

    request.headers.addAll({
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        });

      request.fields['categoryName'] = categoryName;
      request.fields['name'] = name;
      request.fields['nameAr'] = nameAr;
      request.fields['desc'] = desc;
      request.fields['descAr'] = descAr;
      request.fields['price'] = price;
      request.fields['count'] = count;
      request.fields['discount'] = discount!;
      request.fields['isActive'] = isActive!;

      if (imagePath != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imagePath));
      }

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      return jsonDecode(responseBody.body);
    } catch (e) {
      print("Update error: $e");
      return null;
    }
  }

    deleteItem(int id) async {
    try {
       final response = await crud.deleteData(
      "${AppLink.items}/$id",
      {},
      {'Accept': 'application/json'},
    );
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}