import 'package:get/get.dart';
import 'package:tech_application/controller/article/article_info_controller.dart';
import 'package:tech_application/controller/article/article_list_controller.dart';
import 'package:tech_application/controller/home_screen_controller.dart';
import 'package:tech_application/controller/register_controller.dart';

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ArticleListController());

    Get.lazyPut(() => ArticleInfoController());
  }
}
