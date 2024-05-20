import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  playSong(String? uri) {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!)),
      );
      audioPlayer.play();
      isPlaying.value = true;
      audioPlayer.positionStream.listen((position) {
        currentPosition.value = position;
      });
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
    audioPlayer.seek(currentPosition.value);
    audioPlayer.play();
    isPlaying.value = true;
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
