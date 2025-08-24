import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 5;

  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];

  void _onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    if (index == _itemCount - 1) {
      _itemCount += 5;
      colors.addAll([
        Colors.purple,
        Colors.cyan,
        Colors.amber,
        Colors.indigo,
        Colors.lime,
      ]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (value) => _onPageChanged(value),
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text("Screen $index", style: TextStyle(fontSize: 40)),
        ),
      ),
    );
  }
}
