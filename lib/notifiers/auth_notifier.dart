import 'package:auth_sample/models/user.dart';
import 'package:auth_sample/services/auth_web_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_session/flutter_session.dart';

class AuthNotifier extends ChangeNotifier {
  User userData;

  bool get isAuthenticated => userData != null;

  Future<void> checkPreSession() async {
    userData = await FlutterSession().get('userData') as User;
  }

  Future<void> login(String email, String password) async {
    try {
      var _authWebService = AuthWebService();
      userData = await _authWebService.login(email, password);
      await FlutterSession().set('userData', userData);
    } catch (error) {
      throw error;
    }
  }
}
