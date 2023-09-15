import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_practice/app/data/service/auth_service.dart';

/*
사용자가 이메일, 비밀번호, 이름 및 프로필 이미지를 제출하여 회원가입 할 수 있는 페이지를 구성합니다.
*/

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController =
      TextEditingController(); // 이메일 입력을 받을 컨트롤러
  final TextEditingController passwordController =
      TextEditingController(); // 비밀번호 입력을 받을 컨트롤러
  final TextEditingController nameController =
      TextEditingController(); // 이름 입력을 받을 컨트롤러
  String? profileImage; // 프로필 이미지 파일 경로를 저장할 변수

  void register() {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    signUpWithEmailAndImage(email, password, name, File(profileImage!),
        context); // 이메일, 비밀번호, 이름 및 프로필 이미지를 사용하여 회원가입
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택
    if (pickedImage != null) {
      setState(() {
        profileImage = pickedImage.path; // 선택한 이미지의 파일 경로를 저장
        Logger().d(profileImage); // 선택한 이미지의 경로를 로그에 기록
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: pickImage, // 이미지를 선택하는 메서드 호출
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileImage != null
                    ? FileImage(File(profileImage!)) // 프로필 이미지 표시
                    : null,
                child: profileImage == null
                    ? const Icon(Icons.add_a_photo,
                        size: 40, color: Colors.white) // 이미지가 없을 경우 아이콘 표시
                    : null,
              ),
            ),
            const SizedBox(height: 16.0), //
            TextField(
              controller: emailController, // 이메일 입력 필드에 컨트롤러 연결
              decoration: const InputDecoration(
                labelText: 'Email', // 이메일 입력 필드의 라벨 텍스트
              ),
            ),
            const SizedBox(height: 16.0), //
            TextField(
              controller: passwordController,
              obscureText: true, // 입력 내용을 가려 비밀번호 형태로 표시
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: register, // 회원가입 메서드 호출
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
