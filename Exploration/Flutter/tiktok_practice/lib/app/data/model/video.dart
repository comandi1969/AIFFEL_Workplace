import 'package:video_player/video_player.dart';

/*
video클래스를 정의하고 비디오 데이터, 비디오 플레이어 컨트롤러를 관리하는 코드를 작성합니다.
*/

class Video {
  String id; // 비디오 고유 ID
  String user; // 사용자 이름
  String userPic; // 사용자 프로필 이미지 URL
  String videoTitle; // 비디오 제목
  String songName; // 노래 제목
  String likes; // 좋아요 수
  String comments; // 댓글 수
  String url; // 비디오 URL

  VideoPlayerController? controller; // 비디오 플레이어 컨트롤러

  Video({
    required this.id,
    required this.user,
    required this.userPic,
    required this.videoTitle,
    required this.songName,
    required this.likes,
    required this.comments,
    required this.url,
  });

  Video.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'] ?? '',
        user = json['user'] ?? '',
        userPic = json['user_pic'] ?? '',
        videoTitle = json['video_title'] ?? '',
        songName = json['song_name'] ?? '',
        likes = json['likes'] ?? '',
        comments = json['comments'] ?? '',
        url = json['url'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'user_pic': userPic,
      'video_title': videoTitle,
      'song_name': songName,
      'likes': likes,
      'comments': comments,
      'url': url,
    };
  }

  // 비디오 플레이어 컨트롤러 초기화 및 설정
  Future<void> loadController() async {
    Uri urlLink = Uri.parse(url);
    controller = VideoPlayerController.networkUrl(urlLink);
    await controller?.initialize();
    controller?.setLooping(true);
  }

  // 비디오 플레이어 컨트롤러 해제
  Future<void> disposeController() async {
    await controller?.dispose();
  }

  @override
  String toString() {
    return 'Video(id: $id, user: $user, userPic: $userPic, videoTitle: $videoTitle, songName: $songName, likes: $likes, comments: $comments, url: $url)';
  }
}
