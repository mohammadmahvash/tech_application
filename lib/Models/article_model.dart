import 'package:tech_application/component/constant/api_constant.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? categoryId;
  String? categoryName;
  String? author;
  String? view;
  String? status;
  String? createdAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.categoryId,
    required this.categoryName,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    image = ApiConstant.baseHostImageURL + json["image"];
    categoryId = json["cat_id"];
    categoryName = json["cat_name"];
    author = json["author"];
    view = json["view"];
    status = json["status"];
    createdAt = json["created_at"];
  }
}
