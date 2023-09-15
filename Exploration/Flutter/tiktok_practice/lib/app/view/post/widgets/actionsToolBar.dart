import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_practice/app/util/tik_tok_theme.dart';
import 'circleImageAnimation.dart';

/*
다양한 효과를 적용한 flutter 위젯을 작성합니다.
*/

class ActionsToolbar extends StatefulWidget {
  // Full dimensions of an action
  static const double ActionWidgetSize = 60.0;

  // The size of the icon shown for Social Actions
  static const double ActionIconSize = 35.0;

  // The size of the share social icon
  static const double ShareActionIconSize = 25.0;

  // The size of the profile image in the follow Action
  static const double ProfileImageSize = 50.0;

  // The size of the plus icon under the profile image in follow action
  static const double PlusIconSize = 20.0;

  final String numLikes;
  final String numComments;
  final String userPic;

  const ActionsToolbar(this.numLikes, this.numComments, this.userPic,
      {super.key});

  @override
  _ActionsToolbarState createState() => _ActionsToolbarState();
}

class _ActionsToolbarState extends State<ActionsToolbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 및 애니메이션 초기화
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heartAnimation = Tween(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // 애니메이션 완료시 역방향으로 재생
    _heartAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    // 애니메이션 컨트롤러 해제
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                // 하트 애니메이션을 토글
                if (_heartAnimationController.isAnimating) {
                  _heartAnimationController.stop();
                } else {
                  _heartAnimationController.forward();
                }
              });
            },
            child: AnimatedBuilder(
              animation: _heartAnimationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _heartAnimation.value,
                  child: child,
                );
              },
              child: Icon(
                TikTokIcons.heart,
                size: ActionsToolbar.ActionIconSize,
                color: _heartAnimationController.isAnimating
                    ? Colors.red
                    : Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _getSocialAction(icon: TikTokIcons.reply, title: '공유', isShare: true),
          CircleImageAnimation(
            child: _getMusicPlayerAction(widget.userPic),
          ),
        ],
      ),
    );
  }

  // Widget을 반환하는 함수. 다양한 소셜 액션(공유, 좋아요 등)을 표시
  Widget _getSocialAction(
      {required String title, required IconData icon, bool isShare = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      width: 60.0,
      height: 60.0,
      child: Column(
        children: [
          Icon(
            icon,
            size: isShare
                ? ActionsToolbar.ShareActionIconSize
                : ActionsToolbar.ActionIconSize,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 사용자 프로필 사진을 표시하는 함수
  Widget _getProfilePicture(userPic) {
    return Positioned(
      left: (ActionsToolbar.ActionWidgetSize / 2) -
          (ActionsToolbar.ProfileImageSize / 2),
      child: Container(
        padding: const EdgeInsets.all(1.0),
        height: ActionsToolbar.ProfileImageSize,
        width: ActionsToolbar.ProfileImageSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(ActionsToolbar.ProfileImageSize / 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10000.0),
          child: CachedNetworkImage(
            imageUrl: userPic,
            // 이미지 로딩 중에 표시할 효과
            placeholder: (context, url) => const SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
            // 이미지 로딩 오류 시에 표시할 효과
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  // MusicPlayerAction을 표시하는 함수
  Widget _getMusicPlayerAction(userPic) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: ActionsToolbar.ActionWidgetSize,
      height: ActionsToolbar.ActionWidgetSize,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11.0),
            height: ActionsToolbar.ProfileImageSize,
            width: ActionsToolbar.ProfileImageSize,
            decoration: BoxDecoration(
              gradient: musicGradient,
              borderRadius:
                  BorderRadius.circular(ActionsToolbar.ProfileImageSize / 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10000.0),
              child: CachedNetworkImage(
                imageUrl: userPic,
                // 이미지 로딩 중에 표시할 효과
                placeholder: (context, url) => const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
                // 이미지 로딩 오류 시에 표시할 효과
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient get musicGradient => LinearGradient(
        colors: [
          Colors.grey[800]!,
          Colors.grey[900]!,
          Colors.grey[900]!,
          Colors.grey[800]!,
        ],
        stops: const [0.0, 0.4, 0.6, 1.0],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      );
}
