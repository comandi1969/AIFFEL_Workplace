import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_practice/app/data/service/video_controll.dart';
import 'package:tiktok_practice/app/view/post/scroll_post.dart';
import 'package:tiktok_practice/app/view/upload/upload.dart';

import '../mypage/mypage.dart';
import '../upload/upload.dart';

// 페이지 뷰로 3가지 다른화면으로 전환하고 전환 시 UI스타일을 변경하는 기능을 구현합니다.

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  ViedeoControll vdController = ViedeoControll(); // 비디오 컨트롤러 객체 생성

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vdController.currentScreen == 0
          ? Colors.black
          : Colors.white, // 배경색 설정 (비디오 재생 화면이면 검정색, 그 외에는 흰색)
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 3, // 페이지 뷰 아이템 개수 (0, 1, 2)
            onPageChanged: (value) {
              print(value);
              if (value == 1) {
                // 페이지가 전환될 때의 이벤트 처리
                // 현재 페이지가 1인 경우 (프로필 화면) 시스템 UI 스타일을 변경
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              } else {
                // 현재 페이지가 1이 아닌 경우 (게시물 화면 또는 업로드 화면) 시스템 UI 스타일을 변경
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
              }
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return scrollPost(); // 게시물 스크롤 화면 표시
              } else if (index == 1) {
                return const ProfileScreen(); // 프로필 화면 표시
              } else {
                return const UploadScreen(); // 업로드 화면 표시
              }
            },
          )
        ],
      ),
    );
  }
}
