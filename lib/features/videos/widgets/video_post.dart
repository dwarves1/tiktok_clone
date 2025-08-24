import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  final Function onVideoFinished;

  final int index;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
        // with는 mixin을 추가할 때 사용
        // 해당 클래스의 매서드와 속성을 사용할 수 있게 됨
        with
        // single은 하나의 애니메이션 컨트롤러만 사용할 때 사용
        // 위젯이 화면에 보일때만 ticker가 동작하게 함
        // ticker가 여러개일 경우 TickerProviderStateMixin 사용
        SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isSeeMore = false;

  final Duration _animationDuration = Duration(milliseconds: 200);

  String hashtag = "#flutter #tiktok #clone #coding";

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
      "assets/videos/sample_video.mp4",
    );
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChanged);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      // vsync: ticker를 제공하는 클래스
      // 프레임 단위로 callback을 제공
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    //controller의 변화가 있을 때마다 setState를 호출해서 화면을 다시 그리게 함
    /*_animationController.addListener(() {
      setState(() {});
    });
    */
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // reverse는 upperbound에서 lowerbound로 감
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      // forward는 lowerbound에서 upperbound로 감
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onSeeMoreTap() {
    _isSeeMore = !_isSeeMore;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  )
                : Container(color: Colors.black),
          ),
          Positioned.fill(child: GestureDetector(onTap: _onTogglePause)),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                // animation 값이 변경을 감지
                child: AnimatedBuilder(
                  animation: _animationController,
                  // animation 값이 변할때마다 실행되는 함수
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      // child는 AnimatedOpacity
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@나르",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  "This is my first video",
                  style: TextStyle(fontSize: Sizes.size16, color: Colors.white),
                ),
                Gaps.v10,
                Row(
                  children: [
                    Text(
                      _isSeeMore ? hashtag : "${hashtag.substring(0, 20)}...",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                      ),
                    ),
                    Gaps.h10,
                    GestureDetector(
                      onTap: _onSeeMoreTap,
                      child: Text(
                        _isSeeMore ? "Summation" : "See more",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/45042478?v=4",
                  ),
                  child: Text("나르"),
                ),
                Gaps.v24,
                VideoButton(icon: FontAwesomeIcons.solidHeart, text: "2.9M"),
                Gaps.v24,
                VideoButton(icon: FontAwesomeIcons.solidComment, text: "33K"),
                Gaps.v24,
                VideoButton(icon: FontAwesomeIcons.share, text: "Share"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
