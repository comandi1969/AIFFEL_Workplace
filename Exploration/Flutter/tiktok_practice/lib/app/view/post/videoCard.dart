import 'package:flutter/material.dart';
import 'package:tiktok_practice/app/data/model/video.dart';
import 'package:video_player/video_player.dart';

import 'widgets/actionsToolBar.dart';
import 'widgets/videoDescription.dart';

/*
비디오 카드를 생성하고 개별 비디오 카드를 나타내는 코드를 작성합니다.
*/

class VideoCard extends StatefulWidget {
  final Video video;

  const VideoCard(this.video, {super.key});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  // 비디오 컨트롤러 초기화
  Future<void> _initializeController() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.url));
    await _controller?.initialize();
    setState(() {});
  }

  // 비디오 컨트롤러 해제
  Future<void> _disposeController() async {
    await _controller?.dispose();
  }

  // 재생/일시정지 토글 함수
  void _togglePlayPause() {
    if (_controller?.value.isPlaying == true) {
      _controller?.pause();
    } else {
      _controller?.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 비디오 플레이어 또는 로딩 텍스트 표시
        _controller != null && _controller!.value.isInitialized
            ? GestureDetector(
                onTap: _togglePlayPause,
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              )
            : Container(
                color: Colors.black,
                child: const Center(
                  child: Text("Loading"),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // 비디오 설명 정보 표시
                VideoDescription(
                  widget.video.user,
                  widget.video.videoTitle,
                  widget.video.songName,
                ),
                // 비디오 액션 도구 모음 표시
                ActionsToolbar(
                  widget.video.likes,
                  widget.video.comments,
                  widget.video.userPic,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}

// VideoCard를 반환하는 함수
Widget videoCard(Video video) {
  return VideoCard(video);
}
