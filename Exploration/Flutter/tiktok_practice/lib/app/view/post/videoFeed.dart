import 'package:flutter/material.dart';
import 'package:tiktok_practice/app/data/service/video_controll.dart';
import 'package:tiktok_practice/app/view/post/videoCard.dart';
import '../../data/model/video.dart';

/*
TikTok스타일의 피드 화면을 생성하는 코드를 작성합니다.
*/

// 피드 비디오를 반환하는 함수
Widget feedVideos() {
  // 비디오 컨트롤러 인스턴스 생성
  ViedeoControll viedeoControl = ViedeoControll();

  return FutureBuilder<List<Video>>(
    future: viedeoControl.initializeVideoList(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // 데이터가 로딩 중일 때, 로딩 스피너를 표시
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        );
      } else if (snapshot.hasError) {
        // 데이터 로딩 중 오류가 발생한 경우 에러 메시지 표시
        return const Center(
          child: Text('Error loading videos'),
        );
      } else {
        // 데이터 로딩이 완료된 경우, 피드 화면을 렌더링
        return Stack(
          children: [
            PageView.builder(
              controller: PageController(
                initialPage: 0,
                viewportFraction: 1,
              ),
              itemCount: snapshot.data!.length,
              onPageChanged: (index) {
                index = index % snapshot.data!.length;
                viedeoControl.changeVideo(index);
              },
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                index = index % snapshot.data!.length;
                // VideoCard 위젯을 사용하여 비디오 카드 생성
                return videoCard(snapshot.data![index]);
              },
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('팔로잉',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white70)),
                    const SizedBox(
                      width: 7,
                    ),
                    Container(
                      color: Colors.white70,
                      height: 10,
                      width: 1.0,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    const Text('❤️',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                  ],
                ),
              ),
            ),
          ],
        );
      }
    },
  );
}
