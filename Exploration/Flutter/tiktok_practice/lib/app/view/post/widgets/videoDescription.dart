import 'package:flutter/material.dart';

/*
개별 비디오 카드의 설명을 표시하는 코드를 작성합니다.
*/

class VideoDescription extends StatelessWidget {
  final username;
  final videoTitle;
  final songInfo;

  const VideoDescription(this.username, this.videoTitle, this.songInfo,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120.0,
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 사용자 이름 표시
            Text(
              '@' + username,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            // 비디오 제목 표시
            Text(
              videoTitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            // 노래 정보 아이콘과 표시
            Row(children: [
              const Icon(
                Icons.music_note,
                size: 15.0,
                color: Colors.white,
              ),
              Text(
                songInfo,
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              )
            ]),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
