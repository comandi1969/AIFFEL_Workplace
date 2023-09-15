import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiktok_practice/app/data/service/auth_service.dart';
import 'package:tiktok_practice/app/view/auth/signup.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController =
      TextEditingController(); // 이메일 입력을 받을 컨트롤러
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key}); // 비밀번호 입력을 받을 컨트롤러

  void login() {
    // 로그인 기능을 구현할 메서드
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 위젯 주변에 16.0 픽셀의 여백을 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController, // 이메일 입력 필드에 컨트롤러 연결
              decoration: const InputDecoration(
                labelText: 'Email', // 이메일 입력 필드의 라벨 텍스트
              ),
            ),
            const SizedBox(height: 16.0), // 16.0 픽셀의 높이 공백 추가
            TextField(
              controller: passwordController, // 비밀번호 입력 필드에 컨트롤러 연결
              obscureText: true, // 입력 내용을 가려 비밀번호 형태로 표시
              decoration: const InputDecoration(
                labelText: 'Password', // 비밀번호 입력 필드의 라벨 텍스트
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text; // 입력된 이메일 값
                String password = passwordController.text; // 입력된 비밀번호 값
                signInWithEmail(email, password, context); // 이메일과 비밀번호로 로그인 시도
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: const Text(
                'Log In',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RegisterScreen(), // 회원가입 화면으로 이동
                  ),
                );
              },
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
