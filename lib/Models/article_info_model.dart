import 'package:tech_application/component/constant/api_constant.dart';

class ArticleInfoModel {
  String? id;
  String? title;
  String? content;
  String? image;
  String? categoryId;
  String? categoryName;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  bool? isFavorite;

  ArticleInfoModel([
    this.title,
    this.content,
    this.image
  ]);

  ArticleInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["info"]["id"];
    title = json["info"]["title"];
    content = json["info"]["content"];
    image = ApiConstant.baseHostImageURL + json["info"]["image"];
    categoryId = json["info"]["cat_id"];
    categoryName = json["info"]["cat_name"];
    author = json["info"]["author"];
    view = json["info"]["view"];
    status = json["info"]["status"];
    createdAt = json["info"]["created_at"];
    isFavorite = json["isFavorite"];
  }
}
