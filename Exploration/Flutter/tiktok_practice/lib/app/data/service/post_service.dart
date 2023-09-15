//TODO 비디오 리스트 받기
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_practice/app/data/model/video.dart';

// Firebase Firestore를 사용하여 비디오 데이터, 사용자의 비디오 목록을 가져오고 적절한 형식으로 변환하는 코드를 작성합니다.

// 비디오 리스트를 가져오는 비동기 함수
Future<List<Video>> getVideoList() async {
  var videos = await FirebaseFirestore.instance.collection("Videos").get();

  // 비디오 리스트를 Firestore에서 가져와 Video 객체로 변환하여 반환
  return videos.docs.map((doc) => Video.fromJson(doc.data())).toList();
}

// 사용자의 비디오 목록을 가져오는 비동기 함수
Future<List<String>> getMyVideoList() async {
  // 현재 로그인한 사용자 정보 가져오기
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user!.uid;

  // 사용자 문서 참조 가져오기
  final userDocRef =
      FirebaseFirestore.instance.collection('users').doc(uid.toString());

  // 사용자 문서 스냅샷 가져오기
  final userDocSnapshot = await userDocRef.get();

  if (userDocSnapshot.exists) {
    // 사용자 문서에서 'myVideoList' 필드 가져오기 (사용자가 업로드한 비디오 URL 목록)
    final myVideoList =
        userDocSnapshot.data()?['myVideoList'] as List<dynamic>? ?? [];

    // URL 목록을 문자열 리스트로 변환하여 반환
    return myVideoList.map((url) => url.toString()).toList();
  } else {
    // 문서가 없으면 빈 리스트 반환
    return [];
  }
}
