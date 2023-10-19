import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_application/constant/dimensions.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/podcast/podcast_info_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

// ignore: must_be_immutable
class PodcastSinglePageInfo extends StatelessWidget {
  PodcastSinglePageInfo({super.key});

  final homeScreenPodcast = Get.arguments['homeScreenPodcast'];
  final PodcastInfoController podcastInfoController =
      Get.find<PodcastInfoController>();

  String? currentPodcastTitle = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        Positioned.fill(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                          imageUrl: homeScreenPodcast.poster!,
                          imageBuilder: (context, imageProvider) => SizedBox(
                              width: double.maxFinite,
                              height: Get.height / 3.5,
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              )),
                          placeholder: (context, url) => Column(
                                children: [
                                  const SizedBox(height: 80),
                                  circularLoading(),
                                ],
                              ),
                          errorWidget: (context, url, error) => SizedBox(
                                width: double.maxFinite,
                                height: Get.height / 3.5,
                                child: Image.asset(
                                  Assets.images.singlePlaceHolder.path,
                                  fit: BoxFit.cover,
                                ),
                              )),
                      Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: GradientColors.singleAppbarGradient,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                    podcastInfoController.stopProgressBar();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                //ShareIcon
                                InkWell(
                                  onTap: () async {
                                    await Share.share(
                                        "پادکست : ${homeScreenPodcast.title!}\n $currentPodcastTitle \n ${MyStrings.shareText}");
                                  },
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "پادکست : ${homeScreenPodcast.title!}",
                            style: Get.theme.textTheme.headlineLarge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset(Assets.images.profileavatar.path,
                                scale: 8),
                            const SizedBox(width: 10),
                            Text(
                              // MyStrings.nameMohamadMahvash,
                              homeScreenPodcast.author!,
                                style: Get.theme.textTheme.headlineMedium),
                          ],
                        ),
                        //files
                        SizedBox(
                          height: Get.height / 2.7,
                          child: Obx(
                            () => ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: podcastInfoController
                                  .podcastEpisodesList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await podcastInfoController.player
                                        .seek(Duration.zero, index: index);

                                    podcastInfoController
                                            .currentPodcastIndex.value =
                                        podcastInfoController
                                            .player.currentIndex!;

                                    podcastInfoController.resetTimerCheck();

                                    currentPodcastTitle = podcastInfoController
                                        .podcastEpisodesList[index].title
                                        .toString();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ImageIcon(
                                                Assets.icons.bluemicrophone
                                                    .provider(),
                                                color: SolidColors.blueColor),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: Get.width / 1.5,
                                              child: Obx(
                                                () => Text(
                                                    podcastInfoController
                                                        .podcastEpisodesList[
                                                            index]
                                                        .title
                                                        .toString(),
                                                    style: podcastInfoController
                                                                .currentPodcastIndex
                                                                .value ==
                                                            index
                                                        ? Get.theme.textTheme
                                                            .titleMedium
                                                        : Get.theme.textTheme
                                                            .headlineMedium),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            "${podcastInfoController.podcastEpisodesList[index].length!}:00",
                                            style:
                                                Get.theme.textTheme.labelSmall)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
        //playerContainer
        Positioned(
          right: 0,
          left: 0,
          bottom: 10,
          child: Padding(
            padding: EdgeInsets.only(
                right: Dimensions.bodyMargin / 2,
                left: Dimensions.bodyMargin / 2),
            child: Container(
              height: Get.height / 5.5,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(colors: GradientColors.bottomNav)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => ProgressBar(
                        timeLabelTextStyle:
                            const TextStyle(color: Colors.white),
                        thumbColor: Colors.orange,
                        progressBarColor: Colors.orange,
                        progress: podcastInfoController.progressValue.value,
                        buffered: podcastInfoController.bufferedValue.value,
                        total: podcastInfoController.player.duration ??
                            const Duration(seconds: 0),
                        onSeek: (position) async {
                          podcastInfoController.player.seek(position);

                          if (podcastInfoController.player.playing) {
                            podcastInfoController.startProgressBar();
                          } else {
                            await podcastInfoController.player.seekToNext();

                            podcastInfoController.currentPodcastIndex.value =
                                podcastInfoController.player.currentIndex!;

                            podcastInfoController.resetTimerCheck();
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            podcastInfoController.stopProgressBar();

                            podcastInfoController.playState.value = false;

                            podcastInfoController.resetTimerCheck();
                          },
                          child: const Icon(
                            Icons.stop_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(),
                        InkWell(
                          onTap: () async {
                            await podcastInfoController.player.seekToNext();

                            podcastInfoController.currentPodcastIndex.value =
                                podcastInfoController.player.currentIndex!;

                            podcastInfoController.resetTimerCheck();
                          },
                          child: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            podcastInfoController.player.playing
                                ? podcastInfoController.timer!.cancel()
                                : podcastInfoController.startProgressBar();

                            podcastInfoController.player.playing
                                ? podcastInfoController.player.pause()
                                : podcastInfoController.player.play();

                            podcastInfoController.playState.value =
                                podcastInfoController.player.playing;

                            podcastInfoController.currentPodcastIndex.value =
                                podcastInfoController.player.currentIndex!;
                          },
                          child: Obx(
                            () => Icon(
                              podcastInfoController.playState.value
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await podcastInfoController.player.seekToPrevious();

                            podcastInfoController.currentPodcastIndex.value =
                                podcastInfoController.player.currentIndex!;

                            podcastInfoController.resetTimerCheck();
                          },
                          child: const Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(),
                        InkWell(
                          onTap: () {
                            podcastInfoController.setLoopMode();
                          },
                          child: Obx(
                            () => Icon(
                              Icons.repeat,
                              color: podcastInfoController.isLoopAll.value
                                  ? Colors.blue
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ])),
    );
  }
}
