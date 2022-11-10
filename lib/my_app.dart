import 'package:Banking_App/Pages/bank.dart';
import 'package:Banking_App/Pages/welcome.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/bank': (context) => const BankPage(),
      },
      initialRoute: '/welcome',
    );
  }
}
