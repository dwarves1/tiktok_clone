import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

enum Direction { left, right }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    // 드래그 방향에 따라 상태를 업데이트
    if (details.delta.dx > 0) {
      // Swipe right
      setState(() {
        _direction = Direction.right;
      });
    } else if (details.delta.dx < 0) {
      // Swipe left
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    // 드래그가 끝났을 때 페이지 전환
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else if (_direction == Direction.right) {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (content) => MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 드래그 이벤트를 감지하기 위해 GestureDetector 사용
      onPanUpdate: _onPanUpdate,
      // 손가락이 화면에서 떼었을 때 이벤트 처리
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v80,
                  Text(
                    "Whatch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(fontSize: Sizes.size20),
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v80,
                  Text(
                    "Follow the rules!",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(fontSize: Sizes.size20),
                  ),
                ],
              ),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.size12,
            horizontal: Sizes.size12,
          ),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _showingPage == Page.first ? 0 : 1,
            child: CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: _onEnterAppTap,
              child: Text(
                "Enter the app!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
