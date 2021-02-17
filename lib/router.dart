import 'package:flutter/material.dart';
import 'package:quedoctorung/states/authen.dart';
import 'package:quedoctorung/states/create_account.dart';
import 'package:quedoctorung/states/my_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myService': (BuildContext context) => MyService(),
};
