import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/article_info_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

class SingleArticleInfo extends StatefulWidget {
  const SingleArticleInfo({super.key});

  @override
  State<SingleArticleInfo> createState() => _SingleArticleInfoState();
}

class _SingleArticleInfoState extends State<SingleArticleInfo> {
  final ArticleInfoController articleInfoController =
      Get.put(ArticleInfoController());

  @override
  void initState() {
    super.initState();
    articleInfoController.getArticleInfo();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() => articleInfoController.loading.value == false
            ? Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                          imageUrl: articleInfoController
                              .articleInfoModel.value.image!,
                          imageBuilder: (context, imageProvider) => SizedBox(
                              width: double.maxFinite,
                              height: size.height / 3.5,
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
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
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                const Icon(
                                  Icons.bookmark_border_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 15),
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
                          articleInfoController.articleInfoModel.value.title!,
                          style: textTheme.headlineLarge,
                        ),
                        Row(
                          children: [
                            Image.asset(Assets.images.profileavatar.path,
                                scale: 8),
                            const SizedBox(width: 10),
                            Text(
                                articleInfoController
                                    .articleInfoModel.value.author!,
                                style: textTheme.headlineMedium),
                            const SizedBox(width: 10),
                            Text(articleInfoController
                                .articleInfoModel.value.view!),
                          ],
                        ),
                        const SizedBox(height: 30),
                        HtmlWidget(
                          articleInfoController.articleInfoModel.value.content!,
                          enableCaching: true,
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  circularLoading(),
                        ),
                        const SizedBox(height: 70),
                        //hashtag list
                        hashtagList(size, textTheme),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            MyStrings.relatedArticle,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 20),
                        //related Article
                        relatedArticles(size, textTheme),
                      ],
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  SizedBox(height: size.height / 2.3),
                  circularLoading(),
                ],
              )),
      )),
    );
  }

  Widget relatedArticles(Size size, TextTheme textTheme) {
    return SizedBox(
      height: size.height / 3.6,
      child: ListView.builder(
        itemCount: articleInfoController.relatedArticle.length,
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
                    imageUrl:
                        articleInfoController.relatedArticle[index].image!,
                    imageBuilder: (context, imageProvider) => Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                          foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: GradientColors.blogPost,
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 0,
                          left: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  articleInfoController
                                      .relatedArticle[index].author!,
                                  style: textTheme.titleSmall),
                              Row(
                                children: [
                                  Text(
                                    articleInfoController
                                        .relatedArticle[index].view!,
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
                    placeholder: (context, url) => circularLoading(),
                    errorWidget: (context, url, error) => const Icon(
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
                      articleInfoController.relatedArticle[index].title!,
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
    );
  }

  Widget hashtagList(Size size, TextTheme textTheme) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: articleInfoController.relatedTags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                  child: Row(
                    children: [
                      ImageIcon(
                        Assets.icons.hashtag.provider(),
                        color: Colors.white,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        articleInfoController.relatedTags[index].title!,
                        style: textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
