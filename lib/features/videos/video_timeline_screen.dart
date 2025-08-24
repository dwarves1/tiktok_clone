import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 5;

  final PageController _pageController = PageController();

  final _scroolDuration = Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;

  void _onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: _scroolDuration,
      curve: _scrollCurve,
    );
    if (index == _itemCount - 1) {
      _itemCount += 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(duration: _scroolDuration, curve: _scrollCurve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (value) => _onPageChanged(value),
      itemCount: _itemCount,
      itemBuilder: (context, index) =>
          VideoPost(onVideoFinished: _onVideoFinished, index: index),
    );
  }
}
