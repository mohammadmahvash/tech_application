import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tech_application/Models/podcast/podcast_info_model.dart';
import 'package:tech_application/constant/api_constant.dart';
import 'package:tech_application/services/dio_service.dart';

class PodcastInfoController extends GetxController {
  RxList<PodcastInfoModel> podcastEpisodesList = RxList();
  RxBool loading = false.obs;

  final player = AudioPlayer();
  late dynamic playList;
  RxBool playState = false.obs;
  RxInt currentPodcastIndex = 0.obs;

  RxBool isLoopAll = false.obs;

  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;
  Timer? timer;

  getPodcastEpisodesList(String id) async {
    progressValue.value = const Duration(seconds: 0);
    bufferedValue.value = const Duration(seconds: 0);

    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);
    await player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);

    loading.value = true;
    var response = await DioService().getMethod(
        "${ApiConstant.baseURL}podcast/get.php?command=get_files&podcats_id=$id");

    if (response.statusCode == 200) {
      podcastEpisodesList.clear();
      response.data["files"].forEach((element) {
        podcastEpisodesList.add(PodcastInfoModel.fromJson(element));
        playList.add(AudioSource.uri(
            Uri.parse(PodcastInfoModel.fromJson(element).file!)));
      });
      loading.value = false;
    }
  }

  startProgressBar() {
    const tick = Duration(seconds: 1);
    int podcastDuration =
        player.duration!.inSeconds - player.position.inSeconds;

    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
    }

    timer = Timer.periodic(tick, (timer) async {
      podcastDuration--;
      log("Duration is : $podcastDuration =====> index: ${player.currentIndex}");
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;
      if (podcastDuration == 0) {
        await player.seekToNext();
        currentPodcastIndex.value = player.currentIndex!;
        timer.cancel();
        progressValue.value = const Duration(seconds: 0);
        bufferedValue.value = const Duration(seconds: 0);
      }
    });
  }

  resetTimerCheck() {
    if (player.playing) {
      startProgressBar();
    } else {
      timer!.cancel();
      progressValue.value = const Duration(seconds: 0);
      bufferedValue.value = const Duration(seconds: 0);
    }
  }

  stopProgressBar() async{
    await player.stop();
    player.seek(Duration.zero);
    timer!.cancel();
    timer = null;
    progressValue.value = const Duration(seconds: 0);
    bufferedValue.value = const Duration(seconds: 0);
  }

  setLoopMode() {
    if (isLoopAll.value) {
      isLoopAll.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }
}
