import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/view/auth/login.dart';
import 'firebase_options.dart';

// Firebase 초기화 및 스플래시 화면을 표시하는 앱의 main함수입니다.

// 앱 진입점
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 바인딩을 초기화합니다.

  // Firebase 초기화를 수행합니다.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 앱을 실행하고 MaterialApp 위젯을 렌더링합니다.
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너를 숨깁니다.
      home: AnimatedSplashScreen(
        duration: 3000, // 스플래시 화면이 표시될 시간(3초)
        splash: Image.asset('assets/images/modulabs.png'),
        nextScreen: LoginScreen(), // 스플래시 화면이 사라진 후 표시될 다음 화면(LoginScreen)
      ),
    ),
  );
}
