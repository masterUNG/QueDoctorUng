import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quedoctorung/utility/dialog.dart';
import 'package:quedoctorung/utility/my_style.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  File file;
  String name, user, password, rePassword, phone, email, shed;

  Container buildName() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          labelText: 'ชื่อ - นามสกุล',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          labelText: 'ชื่อผู้ใช้งาน',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'รหัสผ่าน:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildRePassword() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => rePassword = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'รหัสผ่านอีกครั้ง:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPhone() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => phone = value.trim(),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'เบอร์โทรศัพย์:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildEmail() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => email = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'อีเมล:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildShed() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => shed = value.trim(),
        decoration: InputDecoration(
          labelText: 'โรงประจำตัว:',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyStyle().mySizebox(),
            buildAvatar(),
            MyStyle().mySizebox(),
            buildName(),
            MyStyle().mySizebox(),
            buildUser(),
            MyStyle().mySizebox(),
            buildPassword(),
            MyStyle().mySizebox(),
            buildRePassword(),
            MyStyle().mySizebox(),
            buildPhone(),
            MyStyle().mySizebox(),
            buildEmail(),
            MyStyle().mySizebox(),
            buildShed(),
            MyStyle().mySizebox(),
            buildSave(),
          ],
        ),
      ),
    );
  }

  Container buildSave() {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'ยังไม่เลือกรูปภาพ',
                'กรุณาเลือกรูปภาพ โดยการ คลิก Camera หรือ Gallery');
          } else if ((name?.isEmpty ?? true) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true) ||
              (rePassword?.isEmpty ?? true) ||
              (phone?.isEmpty ?? true) ||
              (email?.isEmpty ?? true) ||
              (shed?.isEmpty ?? true)) {
            normalDialog(context, 'มีช่องว่าง ?', 'กรุณา กรอกทุกช่อง คะ');
          } else if (password == rePassword) {
            uploadAvataAndCreateUser();
          } else {
            normalDialog(context, 'พิมพ์ รหัสผ่าน ไม่เหมือนกัน',
                'กรุณา พิมพ์ รหัสผ่าน ให้เหมือนๆ กันคะ');
          }
        },
        child: Text('บันทึก'),
      ),
    );
  }

  Future<Null> uploadAvataAndCreateUser() async {
    String nameAvatar = '$user${Random().nextInt(1000000)}.jpg';
    String apiSaveAvatar =
        'https://www.androidthai.in.th/jan/saveAvatarUng.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameAvatar);
      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveAvatar, data: data).then((value) async {
        String avatar =
            'https://www.androidthai.in.th/jan/avatarung/$nameAvatar';
        String apiAddUser =
            'https://www.androidthai.in.th/jan/addUserUng.php?isAdd=true&name=$name&user=$user&password=$password&phone=$phone&email=$email&shed=$shed&avatar=$avatar';
        await Dio().get(apiAddUser).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  Future<Null> choodeImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Row buildAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.add_a_photo,
            size: 36,
          ),
          onPressed: () => choodeImage(ImageSource.camera),
        ),
        Container(
          width: 250,
          height: 250,
          child: Image(
            image: file == null
                ? AssetImage('images/avatar.png')
                : FileImage(file),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36,
          ),
          onPressed: () => choodeImage(ImageSource.gallery),
        ),
      ],
    );
  }
}
