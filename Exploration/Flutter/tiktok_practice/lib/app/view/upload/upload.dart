import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tiktok_practice/app/data/model/video.dart';
import 'package:tiktok_practice/app/data/service/auth_service.dart';
import 'package:video_player/video_player.dart';

/*
비디오를 선택하고 업로드하며 업로드 된 비디오 정보를 Firebase Firestore에 저장하는 코드를 작성합니다.
*/

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _videoFile; // 선택한 비디오 파일을 저장할 변수

  final TextEditingController _videoTitleController =
      TextEditingController(); // 비디오 제목을 입력 받을 컨트롤러
  final TextEditingController _songNameController =
      TextEditingController(); // 노래 제목을 입력 받을 컨트롤러
  ImagePicker imgPick = ImagePicker(); // 이미지 및 비디오를 선택하기 위한 ImagePicker

  VideoPlayerController?
      _videoPlayerController; // 선택한 비디오를 재생하기 위한 비디오 플레이어 컨트롤러
  bool _isUploading = false; // 업로드 진행 중인지 여부를 나타내는 플래그

  @override
  void dispose() {
    _videoTitleController.dispose();
    _songNameController.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _selectVideo() async {
    // 갤러리에서 비디오 선택
    final file = await imgPick.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _videoFile = File(file.path); // 선택한 비디오 파일 설정
        _videoPlayerController = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  // TODO: 비디오 정보 업로드

  Future<void> _uploadVideo() async {
    if (_videoFile == null) {
      return; // 업로드할 비디오가 없으면 함수 종료
    }

    setState(() {
      _isUploading = true; // 업로드 진행 중으로 설정
    });

    final currentUserUuid = await getCurrentUserUuid(); // 현재 사용자 UUID 가져오기
    final currentUserName = await getCurrentUserName(); // 현재 사용자 이름 가져오기
    final profileImageUrl =
        await getProfileImageUrl(); // 현재 사용자 프로필 이미지 URL 가져오기

    try {
      final videoUrl = await uploadVideoToFirestore(
          _videoFile!); // 비디오를 Firebase Firestore에 업로드하고 URL 반환
      final video = Video(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        user: currentUserName.toString(),
        userPic: profileImageUrl.toString(),
        videoTitle: _videoTitleController.text,
        songName: _songNameController.text,
        likes: '0',
        comments: '0',
        url: videoUrl,
      );

      await FirebaseFirestore.instance.collection('Videos').doc(video.id).set({
        'user': video.user,
        'userPic': video.userPic,
        'video_title': video.videoTitle,
        'song_name': video.songName,
        'likes': video.likes,
        'comments': video.comments,
        'url': video.url,
      });

      // 사용자 문서의 myVideoList 배열에 비디오 URL 추가
      final userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUuid.toString());
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        // myVideoList 배열이 이미 존재하면 비디오 URL을 추가
        final myVideoList =
            userDocSnapshot.data()?['myVideoList'] as List<dynamic>? ?? [];
        myVideoList.add(video.url);
        await userDocRef.update({'myVideoList': myVideoList});
      } else {
        // myVideoList 배열이 존재하지 않으면 비디오 URL을 포함한 새 배열 생성
        await userDocRef.set({
          'myVideoList': [video.url]
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Video uploaded successfully')), // 업로드 성공 메시지 표시
      );

      setState(() {
        _videoFile = null; // 선택한 비디오 파일 초기화
        _videoPlayerController?.dispose(); // 비디오 플레이어 컨트롤러 폐기
        _videoPlayerController = null; // 폐기 후 null로 설정
        _videoTitleController.clear(); // 비디오 제목 입력 필드 초기화
        _songNameController.clear(); // 노래 제목 입력 필드 초기화
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error uploading video: $error')), // 업로드 오류 메시지 표시
      );
    } finally {
      setState(() {
        _isUploading = false; // 업로드 완료 후 업로드 진행 중 플래그 해제
      });
    }
  }

  // TODO: 비디오 파일 먼저 업로드

  Future<String> uploadVideoToFirestore(File videoFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('videos'); // Firebase Storage 참조 생성
      final uploadTask = storageRef
          .child('${DateTime.now()}.mp4')
          .putFile(videoFile); // 비디오 파일 업로드

      final snapshot = await uploadTask;
      final videoUrl =
          await snapshot.ref.getDownloadURL(); // 업로드한 비디오의 다운로드 URL 가져오기

      return videoUrl;
    } catch (error) {
      throw PlatformException(
        code: 'VIDEO_UPLOAD_ERROR',
        message: 'Failed to upload video: $error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Upload Video',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink)),
                onPressed: _selectVideo,
                child: const Text('Select Video'), // 비디오 선택 버튼
              ),
              const SizedBox(height: 16.0),
              _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(
                          _videoPlayerController!), // 선택한 비디오를 재생하는 부분
                    )
                  : Container(),
              const SizedBox(height: 16.0),
              TextField(
                controller: _videoTitleController,
                decoration: const InputDecoration(
                  labelText: 'Video Title', // 비디오 제목 입력 필드
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _songNameController,
                decoration: const InputDecoration(
                  labelText: 'Song Name', // 노래 제목 입력 필드
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink)),
                onPressed: _uploadVideo, // 비디오 업로드 버튼
                child: _isUploading
                    ? const CircularProgressIndicator() // 업로드 중에는 로딩 인디케이터 표시
                    : const Text('Upload Video'), // 업로드 버튼 렌더링
              ),
            ],
          ),
        ),
      ),
    );
  }
}
