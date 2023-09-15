import 'package:flutter/material.dart';

/*
회전 애니메이션을 적용한 위젯을 만드는 코드를 작성합니다.
*/

class CircleImageAnimation extends StatefulWidget {
  // CircleImageAnimation 위젯 생성자
  const CircleImageAnimation({Key? key, this.child}) : super(key: key);

  // CircleImageAnimation 위젯의 자식 위젯
  final Widget? child;

  @override
  _CircleImageAnimationState createState() => _CircleImageAnimationState();
}

class _CircleImageAnimationState extends State<CircleImageAnimation>
    with TickerProviderStateMixin {
  // 애니메이션 컨트롤러를 선언
  late AnimationController _controller;

  @override
  void initState() {
    // initState 함수는 위젯이 생성될 때 호출

    // AnimationController를 초기화
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000), // 애니메이션 지속 시간
      vsync: this, // TickerProviderStateMixin을 사용하여 vsync 설정
    );

    // 애니메이션을 시작하고 반복합니다.
    _controller.forward(); // 애니메이션을 시작
    _controller.repeat(); // 애니메이션을 반복

    super.initState();
  }

  @override
  void dispose() {
    // dispose 함수는 위젯이 파기될 때 호출

    // 애니메이션 컨트롤러 해제
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // build 함수는 위젯을 화면에 그릴 때 호출

    return RotationTransition(
      // 회전 애니메이션을 적용
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      // 자식 위젯에 회전 애니메이션을 적용
      child: widget.child,
    );
  }
}
