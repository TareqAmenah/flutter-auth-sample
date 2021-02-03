import 'dart:convert';
import 'dart:io';

import 'package:auth_sample/models/user.dart';
import 'package:http/http.dart' as http;

class AuthWebService {
  Future<User> login(String email, String password) async {
    final url = 'https://srv.wassuna.com/api/login';
    try {
      final response = await http.post(
        url,
        headers: {
          'app-type': '0',
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == true) {
        User user = User(
          name: responseData['data']['first_name'],
          id: responseData['data']['id'],
          token: responseData['data']['access_token'],
        );
        return user;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
