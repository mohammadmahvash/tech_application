import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_application/component/constant/my_colors.dart';
import 'package:tech_application/component/constant/my_strings.dart';
import 'package:tech_application/component/my_components.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:tech_application/gen/assets.gen.dart';

class SingleArticleInfo extends StatelessWidget {
  SingleArticleInfo({super.key});

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
                  const SizedBox(height: 30),
                  HtmlWidget(
                    '''
                     <p>چند ماه پیش جدیدترین قسمت از مجموعه بازی‌های اساسینز کرید عرضه شد. بازی اساسینز کرید والهالا ماجرای قاتلان تاریخی را در سرزمین وایکینگ‌ها روایت می‌کند و تفاوت عظیمی با بازی‌های اصلی این سری دارد. البته چیزی که در این بازی حاضر هست و در دیگر بازی‌های این سری هم همیشه موجود بوده، حجم بالایی از محتوای مخفی و رازهای عجیب و غریب است. قصد داریم تا نگاهی به آن‌ها داشته باشیم تا در صورتی که آن‌ها را ندیده‌اید، غافل نمانید.

سری بازی‌های اساسینز کرید این روز‌ها شباهت بیش‌تری به بازی‌های نقش‌آفرینی دارند تا اساسینز کرید. گیم‌پلی این بازی‌ها تا حد زیادی تغییر کرده و المان‌های نقش‌آفرینی زیادی به آن‌ها اضافه شده. بازی اساسینز کرید والهالا همانند بازی‌های نقش‌آفرینی بسیار بزرگ شده و جارو کردن دنیای پهناور آن بیش‌تر از صد ساعت زمان می‌خواهد. در میان این نقشه‌ی بزرگ، نکات مخفی زیادی که در جوامع گیمرها به آن‌ها «ایستر اگ» (Easter Egg) گفته می‌شود وجود دارند.</p>
                     
                    ''',
                    enableCaching: true,
                    onLoadingBuilder: (context, element, loadingProgress) =>
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
                  Obx(
                    () => relatedArticles(size, textTheme),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget relatedArticles(Size size, TextTheme textTheme) {
    return SizedBox(
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
                    imageUrl:
                        homeScreenController.topArticlesList[index].image!,
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
                                  homeScreenController
                                      .topArticlesList[index].author!,
                                  style: textTheme.titleSmall),
                              Row(
                                children: [
                                  Text(
                                    homeScreenController
                                        .topArticlesList[index].view!,
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
                      homeScreenController.topArticlesList[index].title!,
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
      width: size.width,
      height: 100,
      child: GridView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
