import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/width_height.dart';
import 'package:ojos_app/core/ui/button/arrow_back_button_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart' as Get;

class OJOSVideoPlayer extends StatefulWidget {
  static const routeName = '/home/pages/OJOSVideoPlayer';

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<OJOSVideoPlayer> {
  final args = Get.Get.arguments as String;
  TargetPlatform? _platform;
  VideoPlayerController? _videoPlayerController1;
  // VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1!.dispose();
    // _videoPlayerController2.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  Future<void>? _initializeVideoPlayerFuture;
  Future<void> initializePlayer() async {
    print('args video link $args');
    _videoPlayerController1 = VideoPlayerController.network(args);
    await _videoPlayerController1!.initialize();
    // _videoPlayerController2 = VideoPlayerController.network(
    //     widget.videoUrl);
    // await _videoPlayerController2.initialize();
    _initializeVideoPlayerFuture = _videoPlayerController1!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1!,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: false,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
        appBar: appBar,
        backgroundColor: globalColor.white,
        body: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              return Container(
                color: Colors.black,
                child: Center(
                  child: snapshot.connectionState == ConnectionState.done
                      ? AspectRatio(
                          aspectRatio: _videoPlayerController1 != null &&
                                  _videoPlayerController1!.value.aspectRatio !=
                                      null
                              ? _videoPlayerController1!.value.aspectRatio
                              : 1.0,
                          child: Chewie(
                            controller: _chewieController!,
                          ),
                        )
                      : new CircularProgressIndicator(),
                ),
              );
            })
        // Column(
        //   children: <Widget>[
        //     Expanded(
        //       child: Center(
        //         child: _chewieController != null &&
        //             _chewieController
        //                 .videoPlayerController.value.initialized
        //             ? Chewie(
        //           controller: _chewieController,
        //         )
        //             : Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: const [
        //             CircularProgressIndicator(),
        //             SizedBox(height: 20),
        //             Text('Loading'),
        //           ],
        //         ),
        //       ),
        //     ),
        //     FlatButton(
        //       onPressed: () {
        //         _chewieController.enterFullScreen();
        //       },
        //       child: const Text('Fullscreen'),
        //     ),
        //     Row(
        //       children: <Widget>[
        //         Expanded(
        //           child: FlatButton(
        //             onPressed: () {
        //               setState(() {
        //                 _chewieController.dispose();
        //                 _videoPlayerController1.pause();
        //                 _videoPlayerController1.seekTo(const Duration());
        //                 _chewieController = ChewieController(
        //                   videoPlayerController: _videoPlayerController1,
        //                   autoPlay: true,
        //                   looping: true,
        //                 );
        //               });
        //             },
        //             child: const Padding(
        //               padding: EdgeInsets.symmetric(vertical: 16.0),
        //               child: Text("Landscape Video"),
        //             ),
        //           ),
        //         ),
        //         // Expanded(
        //         //   child: FlatButton(
        //         //     onPressed: () {
        //         //       setState(() {
        //         //         _chewieController.dispose();
        //         //         // _videoPlayerController2.pause();
        //         //         // _videoPlayerController2.seekTo(const Duration());
        //         //         _chewieController = ChewieController(
        //         //           videoPlayerController: _videoPlayerController2,
        //         //           autoPlay: true,
        //         //           looping: true,
        //         //         );
        //         //       });
        //         //     },
        //         //     child: const Padding(
        //         //       padding: EdgeInsets.symmetric(vertical: 16.0),
        //         //       child: Text("Portrait Video"),
        //         //     ),
        //         //   ),
        //         // )
        //       ],
        //     ),
        //     Row(
        //       children: <Widget>[
        //         Expanded(
        //           child: FlatButton(
        //             onPressed: () {
        //               setState(() {
        //                 _platform = TargetPlatform.android;
        //               });
        //             },
        //             child: const Padding(
        //               padding: EdgeInsets.symmetric(vertical: 16.0),
        //               child: Text("Android controls"),
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: FlatButton(
        //             onPressed: () {
        //               setState(() {
        //                 _platform = TargetPlatform.iOS;
        //               });
        //             },
        //             child: const Padding(
        //               padding: EdgeInsets.symmetric(vertical: 16.0),
        //               child: Text("iOS controls"),
        //             ),
        //           ),
        //         )
        //       ],
        //     )
        //   ],
        // ),
        );
  }
}
