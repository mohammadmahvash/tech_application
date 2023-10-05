import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_application/component/constant/dimensions.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/podcast/podcast_info_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

class PodcastSinglePageInfo extends StatelessWidget {
  PodcastSinglePageInfo({super.key});

  final homeScreenPodcast = Get.arguments['homeScreenPodcast'];
  final PodcastInfoController podcastInfoController =
      Get.find<PodcastInfoController>();

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
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                InkWell(
                                  onTap: () async {
                                    await Share.share("");
                                    //TODO Add share icon
                                    // "${articleInfoController.articleInfoModel.value.title!}\n ${MyStrings.shareText}");
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
                            Text(homeScreenPodcast.author!,
                                style: Get.theme.textTheme.headlineMedium),
                          ],
                        ),
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
        Positioned(
          right: 0,
          left: 0,
          bottom: 10,
          child: Padding(
            padding: EdgeInsets.only(
                right: Dimensions.bodyMargin, left: Dimensions.bodyMargin),
            child: Container(
              height: Get.height / 7,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(colors: GradientColors.bottomNav)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LinearPercentIndicator(
                      percent: 0.5,
                      backgroundColor: Colors.white,
                      progressColor: Colors.orangeAccent,
                      lineHeight: 8,
                      barRadius: const Radius.circular(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            await podcastInfoController.player.stop();

                            podcastInfoController.currentPodcastIndex.value = 0;
                            podcastInfoController.playState.value = false;
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
                          },
                          child: const Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(),
                        const Icon(
                          Icons.repeat,
                          color: Colors.white,
                          size: 30,
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
