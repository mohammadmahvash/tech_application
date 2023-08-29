import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_application/Models/fake_data.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

class SingleArticleContent extends StatelessWidget {
  SingleArticleContent({super.key});

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                    imageUrl: "",
                    imageBuilder: (context, imageProvider) => SizedBox(
                          width: double.maxFinite,
                          height: size.height / 3.5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                        ),
                    placeholder: (context, url) => Column(
                          children: [
                            const SizedBox(height: 80),
                            circularLoading(),
                          ],
                        ),
                    errorWidget: (context, url, error) => SizedBox(
                          width: double.maxFinite,
                          height: size.height / 3.5,
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
                      child: const Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.bookmark_border_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "رازهای اساسینز کرید والهالا؛ از هری پاتر و ارباب حلقه‌ها تا دارک سولز",
                    style: textTheme.headlineLarge,
                  ),
                  Row(
                    children: [
                      Image.asset(Assets.images.profileavatar.path, scale: 8),
                      const SizedBox(width: 10),
                      Text("محمد ماهوش", style: textTheme.headlineMedium),
                      const SizedBox(width: 10),
                      const Text("دو روز پیش"),
                    ],
                  ),
                  HtmlWidget(
                    '''
                     <h1>Mohamad</h1>
                     <h2>Mohamad</h2>
                     <h3>Mohamad</h3>
                     <h4>Mohamad</h4>
                    ''',
                    enableCaching: true,
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        circularLoading(),
                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    width: size.width,
                    height: 100,
                    child: GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              childAspectRatio: 3),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: SolidColors.surface),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),
                                Text(
                                  "تست",
                                  style: textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      MyStrings.relatedArticle,
                      style: textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => SizedBox(
                      height: size.height / 3.6,
                      child: ListView.builder(
                        itemCount: homeScreenController.topArticlesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height / 5.3,
                                  width: size.width / 2.4,
                                  child: CachedNetworkImage(
                                    imageUrl: homeScreenController
                                        .topArticlesList[index].image!,
                                    imageBuilder: (context, imageProvider) =>
                                        Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                          foregroundDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                  colors:
                                                      GradientColors.blogPost,
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter)),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          right: 0,
                                          left: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  homeScreenController
                                                      .topArticlesList[index]
                                                      .author!,
                                                  style: textTheme.titleSmall),
                                              Row(
                                                children: [
                                                  Text(
                                                    homeScreenController
                                                        .topArticlesList[index]
                                                        .view!,
                                                    style: textTheme.titleSmall,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
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
                                SizedBox(
                                  width: size.width / 2.7,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      homeScreenController
                                          .topArticlesList[index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                )
                              ],
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
        ),
      ),
    ));
  }
}
