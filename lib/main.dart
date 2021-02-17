import 'package:flutter/material.dart';
import 'package:quedoctorung/router.dart';
import 'package:quedoctorung/utility/my_style.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: '/authen',
      theme: ThemeData(primaryColor: MyStyle().primaryColor),
    );
  }
}
