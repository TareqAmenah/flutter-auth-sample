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
}
