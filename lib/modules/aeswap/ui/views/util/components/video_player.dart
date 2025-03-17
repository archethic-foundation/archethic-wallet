import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.videoId});
  final String videoId;

  static const String routerPage = '/videoPlayer';

  @override
  VideoPlayerState createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  bool isVideoLoading = true;

  InAppWebViewController? webViewController;

  @override
  void dispose() {
    super.dispose();
    webViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            VimeoVideoPlayer(
              videoId: widget.videoId,
              isAutoPlay: true,
              onInAppWebViewCreated: (controller) {
                webViewController = controller;
              },
              onInAppWebViewLoadStart: (controller, url) {
                setState(() {
                  isVideoLoading = true;
                });
              },
              onInAppWebViewLoadStop: (controller, url) {
                setState(() {
                  isVideoLoading = false;
                });
              },
            ),
            if (isVideoLoading)
              const Center(child: CircularProgressIndicator()),
            Positioned(
              top: 8,
              left: 8,
              child: BackButton(
                key: const Key('back'),
                color: ArchethicTheme.text,
                onPressed: () {
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
