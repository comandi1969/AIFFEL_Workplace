import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:tiktok_practice/app/data/model/video.dart';
import 'package:tiktok_practice/app/data/service/post_service.dart';
import 'package:video_player/video_player.dart';

/*
비디오 작업 및 페이지 전환을 관리하는 코드를 작성합니다.
*/

class ViedeoControll with ChangeNotifier {
  VideoPlayerController? controller; // 비디오 플레이어 컨트롤러
  int videoBefore = 0; // 이전 비디오 인덱스
  int currentScreen = 0; // 현재 화면 인덱스
  List<Video> videoList = []; // 비디오 목록

  ViedeoControll._privateConstructor() {
    initializeVideoList(); // 비디오 목록 초기화
  }

  static final ViedeoControll _instance = ViedeoControll._privateConstructor();

  factory ViedeoControll() {
    return _instance;
  }

  Future<List<Video>> initializeVideoList() async {
    videoList = await getVideoList();
    return videoList;
  }

  // 비디오 전환
  void changeVideo(int index) async {
    if (videoList[index].controller == null) {
      await videoList[index].loadController();
    }

    videoList[index].controller!.play();

    if (videoList[videoBefore].controller != null) {
      videoList[videoBefore].controller!.pause();
    }
    videoBefore = index;
  }

  // 비디오 로딩
  void loadVideo(int index) async {
    if (index < videoList.length) {
      await videoList[index].loadController();
      videoList[index].controller?.play();
      notifyListeners();
    }
  }

  // 현재 화면 설정
  void setActualScreen(int index) {
    currentScreen = index;
    Logger().d(currentScreen);

    // 시스템 UI 스타일 설정
    SystemChrome.setSystemUIOverlayStyle(
        index == 0 ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
    notifyListeners();
  }
}
