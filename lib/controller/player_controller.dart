import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var currentPosition = ''.obs;
  var totalDuration = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  updatePosition() {
    audioPlayer.positionStream.listen((p) {
      currentPosition.value = p.toString();
      value.value = p.inSeconds.toDouble();
    });
    audioPlayer.durationStream.listen((d) {
      totalDuration.value = d.toString();
      max.value = d!.inSeconds.toDouble();
    });
  }

  changeDurationToSecond(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playSong(String? uri) {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!)),
      );
      audioPlayer.play();
      isPlaying.value = true;
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  pauseSong() {
    try {
      audioPlayer.pause();
      isPlaying.value = false;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  resumeSong() {
    final currentPositionDuration = audioPlayer.position;
    if (currentPositionDuration != null) {
      audioPlayer.seek(currentPositionDuration);
      audioPlayer.play();
      isPlaying.value = true;
    }
  }

  checkPermission() async {
    // var perm = await Permission.audio.request()
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
    } else if (permission.isDenied) {
      checkPermission();
    } else if (permission.isPermanentlyDenied) {
      checkPermission();
    }
  }
}
