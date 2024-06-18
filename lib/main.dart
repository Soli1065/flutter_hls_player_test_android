import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'hls_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HLS Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String hlsUrl = 'http://172.16.251.80/hls/videos/1717823401/index.m3u8';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Play Video'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (context) => HLSVideoPlayer(url: hlsUrl),
                // builder: (context) => HLSVideoPlayerWeb(url: hlsUrl),
                builder: (context) => VideoApp(),
              ),
            );
          },
        ),
      ),
    );
  }
}



class HLSVideoPlayer extends StatefulWidget {
  final String url;

  const HLSVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _HLSVideoPlayerState createState() => _HLSVideoPlayerState();
}

class _HLSVideoPlayerState extends State<HLSVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    print("Initializing video player with URL: ${widget.url}");
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      print("Video player initialized successfully");
      setState(() {});
    }).catchError((error) {
      print("Error initializing video player: $error");
    });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HLS Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_controller.value.isInitialized) {
              print("Video player is initialized");
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              print("Video player is not initialized");
              return Center(child: Text('Video player is not initialized'));
            }
          } else if (snapshot.hasError) {
            print("Error loading video: ${snapshot.error}");
            return Center(child: Text('Error loading video: ${snapshot.error}'));
          } else {
            print("Loading video...");
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

