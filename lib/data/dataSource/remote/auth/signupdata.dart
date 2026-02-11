import 'dart:convert';

import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/api_link.dart';
import 'package:http/http.dart' as http;

class SignupData {
  Crud crud = Crud();
  SignupData(this.crud);
  register(String userName, String email, String password, String phone) async {
    try {
      final response = await crud.postData(AppLink.registerURL, {
        "user_name": userName,
        "email": email,
        "password": password,
        "phone_number": phone,
      },{});
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {
      print('Exception in register: $e');
      return StatusRequest.serverException;
    }
  }
}

