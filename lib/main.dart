import 'package:flutter/material.dart';
import 'package:rendu_flutter/app_style.dart';
import 'package:rendu_flutter/database/db.dart';
import 'package:rendu_flutter/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppStyle.appTheme,
      home: LoginPage(),
    );
  }
}
