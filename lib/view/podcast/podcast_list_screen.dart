import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/appbar_component.dart';
import 'package:tech_application/constant/dimensions.dart';
import 'package:tech_application/constant/my_colors.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/podcast/podcast_info_controller.dart';
import 'package:tech_application/controller/podcast/podcast_list_controller.dart';
import 'package:tech_application/route_manager/my_route.dart';

class PodcastListScreen extends StatelessWidget {
  PodcastListScreen({super.key});

  final String title = Get.arguments['title'];
  final PodcastListController podcastListController =
      Get.find<PodcastListController>();
  final PodcastInfoController podcastInfoController =
      Get.put(PodcastInfoController());

  @override
  Widget build(BuildContext context) {
    double bodyMargin = Dimensions.bodyMargin;

    return SafeArea(
        child: Scaffold(
      backgroundColor: SolidColors.scaffoldBackground,
      appBar: appBar(title),
      body: Obx(
        () => podcastListController.loading.value == false
            ? Padding(
                padding: EdgeInsets.only(
                    left: bodyMargin / 1.9, right: bodyMargin / 1.9),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: podcastListController.podcastList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () async {
                          await podcastInfoController.getPodcastEpisodesList(
                              podcastListController.podcastList[index].id
                                  .toString());

                          Get.toNamed(MyRoute.routePodcastSinglePageInfo,
                              arguments: {
                                'homeScreenPodcast':
                                    podcastListController.podcastList[index]
                              });
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width / 4,
                              height: Get.height / 7,
                              child: CachedNetworkImage(
                                imageUrl: podcastListController
                                    .podcastList[index].poster!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                                placeholder: (context, url) =>
                                    circularLoading(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                      podcastListController
                                          .podcastList[index].title!,
                                      style: Get.theme.textTheme.headlineMedium,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          podcastListController
                                                  .podcastList[index]
                                                  .author ??
                                              "",
                                          style:
                                              Get.theme.textTheme.labelSmall),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : SizedBox(height: Get.height, child: circularLoading()),
      ),
    ));
  }
}
