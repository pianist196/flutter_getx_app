import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_2021_workout_app/home_page.dart';
import 'package:video_player/video_player.dart';
import "colors.dart" as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  Widget _playView(
      BuildContext context, VideoPlayerValue value, Widget? child) {
    if (value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(_controller),
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            "Preparing",
            style: TextStyle(fontSize: 20, color: Colors.white60),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                  color.AppColor.gradientFirst.withOpacity(0.9),
                  color.AppColor.gradientSecond,
                ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight))
          : BoxDecoration(
              color: color.AppColor.gradientSecond,
            ),
      child: Column(
        children: [
          _playArea == false
              ? Container(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const HomePage());
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageTopIconColor,
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: color.AppColor.secondPageTopIconColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Legs Toning",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "and Glutes Workout",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      color.AppColor
                                          .secondPageContainerGradient1stColor,
                                      color.AppColor
                                          .secondPageContainerGradient2ndColor,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "68 min",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          color.AppColor.secondPageTitleColor),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 212,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      color.AppColor
                                          .secondPageContainerGradient1stColor,
                                      color.AppColor
                                          .secondPageContainerGradient2ndColor,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.handyman_outlined,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Resistent band, kettebell",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          color.AppColor.secondPageTitleColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: 100,
                      padding:
                          const EdgeInsets.only(top: 50, left: 30, right: 30),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              debugPrint("tapped");
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: color.AppColor.secondPageTopIconColor,
                          )
                        ],
                      ),
                    ),
                    ValueListenableBuilder<VideoPlayerValue>(
                      valueListenable: _controller,
                      builder: _playView,
                    ),
                    _controlView(context),
                  ],
                ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(70),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 30),
                    Text(
                      "Circuit 1: Legs Toning",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Icon(
                          Icons.loop,
                          size: 30,
                          color: color.AppColor.loopColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "3 sets",
                          style: TextStyle(
                              fontSize: 15, color: color.AppColor.setsColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: _listView())
              ],
            ),
          ))
        ],
      ),
    ));
  }

  _controlView(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () async {},
            child: Icon(
              Icons.fast_rewind,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              if (_isPlaying) {
                setState(() {
                  _isPlaying = false;
                });
                _controller.pause();
              } else {
                setState(() {
                  _isPlaying = true;
                });
                _controller.play();
              }
            },
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {},
            child: Icon(
              Icons.fast_forward,
              size: 36,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _onControllerUpdate() async {
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can noy be initialized");
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onTapVideo(int index) {
    final controller =
        VideoPlayerController.network(videoInfo[index]["videoUrl"]);
    final old = _controller;
    _controller = controller;
    if(old!=null){
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _listView() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        itemCount: videoInfo.length,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              _onTapVideo(index);
              debugPrint(index.toString());
              setState(() {
                if (_playArea == false) {
                  _playArea = true;
                }
              });
            },
            child: CustomCard(
              video: videoInfo[index],
            ),
          );
        });
  }
}

class CustomCard extends StatelessWidget {
  final Map<String, dynamic> video;

  const CustomCard({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(video["thumbnail"]),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video["title"],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      video["time"],
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "15s rest",
                    style: TextStyle(color: Color(0xFF839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: const Color(0xFF839fed),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                            color: Colors.white,
                          )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
