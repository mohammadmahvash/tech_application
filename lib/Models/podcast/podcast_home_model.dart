import 'package:tech_application/constant/api_constant.dart';

class PodcastHomeModel {
  String? id;
  String? title;
  String? poster;
  String? categoryName;
  String? author;
  String? view;
  String? status;
  String? createdAt;

  PodcastHomeModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.categoryName,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
  });

  PodcastHomeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    poster = ApiConstant.baseHostURL + json["poster"];
    categoryName = json["cat_name"];
    author = json["author"];
    view = json["view"];
    status = json["status"];
    createdAt = json["created_at"];
  }
}