import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        // 'https://tve-live-lln.warnermediacdn.com/hls/live/586495/cnngo/cnn_slate/VIDEO_0_3564000.m3u8')
        // 'http://46.249.100.159/stream/')
        // 'http://46.249.100.159/proxy/https://cdn-bsht5bc.telewebion.com/ek/tv2/live/240p/index.m3u8')
        // 'https://cdn-bsht5bc.telewebion.com/ek/tv3/live/240p/index.m3u8')
        // 'https://cdn-bsht5bd.telewebion.com/se/tv2/live/240p/index.m3u8')
        // 'http://46.209.222.131:8081/?target=https://cdn-bsht5bd.telewebion.com/se/tv2/live/240p/index.m3u8')
        // 'http://46.209.222.131:8081/x36xhzz/x36xhzz.m3u8')
        // 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8')
        // 'https://t3-cdn.eirib.ir/securelive3/tv3hd/tv3hd.m3u8')

        // 'https://res.cloudinary.com/dannykeane/video/upload/sp_full_hd/q_80:qmax_90,ac_none/v1/dk-memoji-dark.m3u8')
        // 'https://diceyk6a7voy4.cloudfront.net/e78752a1-2e83-43fa-85ae-3d508be29366/hls/fitfest-sample-1_Ott_Hls_Ts_Avc_Aac_16x9_1280x720p_30Hz_6.0Mbps_qvbr.m3u8')
        // 'https://test-streams.mux.dev/pts_shift/master.m3u8')
        // 'https://test-streams.mux.dev/issue666/playlists/cisq0gim60007xzvi505emlxx.m3u8')
        // 'https://test-streams.mux.dev/dai-discontinuity-deltatre/manifest.m3u8')
        // 'https://test-streams.mux.dev/test_001/stream.m3u8')
        // 'http://46.209.222.131:8081/test_001/stream.m3u8')
        // 'http://46.209.222.131:8081/x36xhzz/x36xhzz.m3u8')
        // 'http://46.209.222.131:8081/se/tv2/live/240p/index.m3u8')
        // 'https://fam11.fam.ir/famtv/lives/tv3/vs1/out.m3u8')
        // 'http://46.209.222.131:8081/hls/tv3/tv3_480/index.m3u8')
        'https://live.aionet.ir/hls/tv3/tv3_480/index.m3u8')
        // 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}