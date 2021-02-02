import 'package:auth_sample/notifiers/auth_notifier.dart';
import 'package:auth_sample/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.tajawalTextTheme(),
          appBarTheme: AppBarTheme(
            textTheme: GoogleFonts.tajawalTextTheme(),
          ),
        ),
      ),
    );
  }
}
