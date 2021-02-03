import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String name;
  final String token;

  User({
    @required this.name,
    @required this.id,
    @required this.token,
  });

  static User fromJson(Map<String, dynamic> data) {
    print(data);
    return User(
      id: data["id"],
      name: data["name"],
      token: data["token"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = this.name;
    data["token"] = this.token;
    return data;
  }
}
