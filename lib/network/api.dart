import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../helpers/shared_value_helper.dart';




class Api{

  Future<http.Response> postWithBody(String url,Map<String,String>data) async{
    print("tokkkkkkkkkkkken---->${access_token.$}");
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${access_token.$}'
      },
        body:json.encode(data)


    );
  }
  Future uploadImage(String url,File image) async{
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "conversation_id":"4",
        "type":"file",
        "message":
        await MultipartFile.fromFile(image.path, filename:fileName),
      });
      Dio dio=Dio();
      dio.options.headers["Authorization"] = "Bearer ${access_token.$}";

      var response = await dio.post(url, data: formData);
     print("sender id__>>>${response.data['sender_id']}");
      return response.data['sender_id'];
    }
}
Api api=Api();