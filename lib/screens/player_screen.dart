import 'dart:ffi';

import 'package:noisie/controller/player_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late dynamic artwork;
  late String title;
  late String artist;
  late dynamic uri;
  final controller = Get.put(PlayerController());
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    artwork = arguments['artwork'];
    title = arguments['title'];
    artist = arguments['artist'];
    uri = arguments['uri'];
    print("Nghệ sĩ: " + artist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          'Now playing',
          style: TextStyle(
            fontFamily: "Spotify",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            Center(
              child: artist == "Unknown Artist"
                  ? Image.asset(
                      'assets/images/noise.jpg',
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                    )
                  : Image.memory(
                      artwork,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                    ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: "Spotify",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    artist,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: "Spotify",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Obx(
              () => Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Text(
                    controller.currentPosition.value.length >= 7
                        ? controller.currentPosition.value.substring(2, 7)
                        : controller.currentPosition.value,
                    style: const TextStyle(
                      fontFamily: "Spotify",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.greenAccent,
                        inactiveTrackColor: Colors.grey,
                        trackHeight: 2.0,
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6.0),
                        overlayColor: Colors.greenAccent.withAlpha(32),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 12.0),
                      ),
                      child: Slider(
                          value: controller.value.value,
                          min: Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value,
                          onChanged: (newValue) {
                            controller.changeDurationToSecond(newValue.toInt());
                            newValue = newValue;
                          }),
                    ),
                  ),
                  Text(
                    controller.totalDuration.value.length >= 7
                        ? controller.totalDuration.value.substring(2, 7)
                        : controller.totalDuration.value,
                    style: const TextStyle(
                      fontFamily: "Spotify",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => IconButton(
                    onPressed: () {
                      if (controller.isPlaying.value) {
                        controller.pauseSong();
                      } else {
                        controller.resumeSong();
                      }
                    },
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
