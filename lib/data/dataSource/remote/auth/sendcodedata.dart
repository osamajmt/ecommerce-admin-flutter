import 'dart:convert';

import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/api_link.dart';
import 'package:http/http.dart' as http;

class SendCodeData {
  Crud crud = Crud();
  SendCodeData(this.crud);
  sendCode(String email) async {
    try {
      final response = await crud.patchData(AppLink.sendCode, {
        "email": email,
      },{});
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}

