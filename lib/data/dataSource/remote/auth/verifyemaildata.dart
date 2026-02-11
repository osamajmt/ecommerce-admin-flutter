import 'dart:convert';

import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/api_link.dart';
import 'package:http/http.dart' as http;

class VerifyEmailData {
  Crud crud = Crud();
  VerifyEmailData(this.crud);
  verifyEmail(String email, String code) async {
    try {
      final response = await crud.postData(AppLink.verifyEmail, {
        "email": email,
        "verify_code": code,
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  sendCode(String email) async {
    try {
      final response = await crud.postData(AppLink.sendCode, {
        "email": email,
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}

