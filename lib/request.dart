import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './config.dart';

Future<Map<String, dynamic>> fetchPost(String url, Map<String, String> parameter) async {
  final response =
      await http.post(SERVER_HOST+SERVER_NAME+url, body: parameter);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return json.decode(response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<Map<String, dynamic>> fetchGet(String url, Map<String, String> parameter) async {
  String queryParameter = '?';
  parameter.forEach((key, value){
    queryParameter += key + '=' + value.toString() + '&';
  });
  queryParameter = queryParameter.substring(0,queryParameter.length-1);
  final response = await http.get(SERVER_HOST+SERVER_NAME+url+queryParameter);
    if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return json.decode(response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}