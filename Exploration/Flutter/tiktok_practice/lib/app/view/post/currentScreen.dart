import 'package:flutter/material.dart';
import 'package:tiktok_practice/app/data/service/video_controll.dart';
import 'package:tiktok_practice/app/view/mypage/mypage.dart';
import 'package:tiktok_practice/app/view/post/videoFeed.dart';
import 'package:tiktok_practice/app/view/upload/upload.dart';

Widget currentScreen() {
  ViedeoControll viedeoControl = ViedeoControll();
  switch (viedeoControl.currentScreen) {
    case 0:
      return feedVideos();
    case 1:
      return const ProfileScreen();
    case 2:
      return const UploadScreen();
    default:
      return feedVideos();
  }
}
