import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quedoctorung/utility/dialog.dart';
import 'package:quedoctorung/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLogo(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildUser(),
                  buildPassword(),
                  buildLogin(),
                ],
              ),
              buildCreateAccount()
            ],
          ),
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'มีช่องว่าง ?', 'กรุณากรอก ทุกช่องคะ');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String path =
        'https://www.androidthai.in.th/jan/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      if (value.toString() == 'null') {
        normalDialog(context, 'ชื่อผู้ใช้งานผิด', 'กรุณาใส ชื่อผู้ใช้งานใหม่');
      } else {
        var result = json.decode(value.data);
        for (var item in result) {
          if (password == item['password']) {
            Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false);
          } else {
            normalDialog(context, 'Password False', 'Password False');
          }
        }
      }
    });
  }

  Container buildUser() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          labelText: 'User Name:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
          labelText: 'Password:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/createAccount'),
          child: Text('สมัครสมาชิก'),
        ),
      ],
    );
  }

  Widget buildLogo() {
    return Row(
      children: [
        Container(
          width: 80,
          child: MyStyle().showLogo(),
        ),
        MyStyle().titleH1('DR.QUE Clinic'),
      ],
    );
  }
}
