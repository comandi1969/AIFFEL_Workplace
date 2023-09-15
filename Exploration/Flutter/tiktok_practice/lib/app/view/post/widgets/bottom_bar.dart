import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tiktok_practice/app/data/service/video_controll.dart';
import 'package:tiktok_practice/app/util/tik_tok_theme.dart';

/*
TikTok 스타일의 하단 네비게이션 바를 구현하고, 사용자가 화면을 선택하면 해당 화면으로 이동하는 코드를 작성합니다.
*/

class BottomBar extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  // 비디오 컨트롤러 인스턴스 생성
  ViedeoControll viedeoControl = ViedeoControll();

  BottomBar({Key? key}) : super(key: key);

  // 사용자 정의 'Create' 아이콘 위젯
  Widget get customCreateIcon => SizedBox(
      width: 45.0,
      height: 27.0,
      child: Stack(children: [
        Container(
            margin: const EdgeInsets.only(left: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7.0))),
        Container(
            margin: const EdgeInsets.only(right: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7.0))),
        Center(
            child: Container(
          height: double.infinity,
          width: CreateButtonWidth,
          decoration: BoxDecoration(
              color: viedeoControl.currentScreen == 0
                  ? Colors.white
                  : Colors.black,
              borderRadius: BorderRadius.circular(7.0)),
          child: Icon(
            Icons.add,
            color:
                viedeoControl.currentScreen == 0 ? Colors.black : Colors.white,
            size: 20.0,
          ),
        )),
      ]));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menuButton('Home', TikTokIcons.home, 0),
              const SizedBox(
                width: 15,
              ),
              customCreateIcon,
              const SizedBox(
                width: 15,
              ),
              menuButton('Profile', TikTokIcons.profile, 3)
            ],
          ),
          SizedBox(
            height: Platform.isIOS ? 40 : 10,
          )
        ],
      ),
    );
  }

  // 네비게이션 메뉴 버튼 위젯
  Widget menuButton(String text, IconData icon, int index) {
    return GestureDetector(
        onTap: () {
          // 선택된 화면 설정 및 비디오 컨트롤러 업데이트
          viedeoControl.setActualScreen(index);
        },
        child: SizedBox(
          height: 45,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,
                  color: viedeoControl.currentScreen == 0
                      ? viedeoControl.currentScreen == index
                          ? Colors.white
                          : Colors.white70
                      : viedeoControl.currentScreen == index
                          ? Colors.black
                          : Colors.black54,
                  size: NavigationIconSize),
              const SizedBox(
                height: 7,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: viedeoControl.currentScreen == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: viedeoControl.currentScreen == 0
                        ? viedeoControl.currentScreen == index
                            ? Colors.white
                            : Colors.white70
                        : viedeoControl.currentScreen == index
                            ? Colors.black
                            : Colors.black54,
                    fontSize: 11.0),
              )
            ],
          ),
        ));
  }
}
