import 'package:get/get.dart';
import 'package:tech_application/route_manager/binding.dart';
import 'package:tech_application/route_manager/my_route.dart';
import 'package:tech_application/constant/my_strings.dart';
import 'package:tech_application/view/article/article_list_screen.dart';
import 'package:tech_application/view/article/article_management_list.dart';
import 'package:tech_application/view/article/article_management_single_page_info.dart';
import 'package:tech_application/view/article/article_single_page_info.dart';
import 'package:tech_application/view/main_screen/main_screen.dart';
import 'package:tech_application/view/podcast/podcast_list_screen.dart';
import 'package:tech_application/view/podcast/podcast_single_page_info.dart';
import 'package:tech_application/view/register/register_intro.dart';

class PagesRoute {
  PagesRoute._();

  static List<GetPage<dynamic>> pagesList = [
    GetPage(
        name: MyRoute.routeMainScreen,
        page: () => MainScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: MyRoute.routeRegisterIntro,
        page: () => RegisterIntro(),
        binding: RegisterBinding()),
    GetPage(
        name: MyRoute.routePodcastListScreen,
        page: () => PodcastListScreen(),
        binding: PodcastBinding(),
        arguments: {'title': MyStrings.titleAppBarPodcastsList}),
    GetPage(
      name: MyRoute.routePodcastSinglePageInfo,
      page: () => PodcastSinglePageInfo(),
      binding: PodcastBinding(),
    ),
    GetPage(
        name: MyRoute.routeArticleListScreen,
        page: () => ArticleListScreen(),
        binding: ArticleBinding(),
        arguments: {'title': MyStrings.titleAppBarArticlesList}),
    GetPage(
        name: MyRoute.routeArticleSinglePageInfo,
        page: () => ArticleSinglePageInfo(),
        binding: ArticleBinding()),
    GetPage(
        name: MyRoute.routeArticleManagementList,
        page: () => ArticleManagementList(),
        binding: ArticleManagementBinding()),
    GetPage(
        name: MyRoute.routeArticleManagementSinglePageInfo,
        page: () => ArticleManagementSinglePageInfo(),
        binding: ArticleManagementBinding()),
  ];
}
