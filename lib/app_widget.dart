import 'package:flutter/material.dart';
import 'package:vision/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vision",
      debugShowCheckedModeBanner: false,
      initialRoute: "/Home",
      routes: {"/Home": (context) => HomePage()},
    );
  }
}
