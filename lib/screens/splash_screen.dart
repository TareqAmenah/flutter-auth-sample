import 'package:auth_sample/notifiers/auth_notifier.dart';
import 'package:auth_sample/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/constants.dart' as Constants;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkPreSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Constants.appaColor2,
          highlightColor: Constants.appaColor3,
          child: Hero(
            tag: 'appa-h',
            child: Text(
              'APPA',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkPreSession() async {
    print('***********');
    var _authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    await _authNotifier.checkPreSession();
    if (_authNotifier.isAuthenticated) {
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    }
  }
}
