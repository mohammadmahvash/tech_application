import 'package:tech_application/component/constant/api_constant.dart';

class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? categoryName;
  String? author;
  String? view;
  String? status;
  String? createdAt;

  PodcastModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.categoryName,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
  });

  PodcastModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    poster = ApiConstant.baseHostImageURL + json["poster"];
    categoryName = json["cat_name"];
    author = json["author"];
    view = json["view"];
    status = json["status"];
    createdAt = json["created_at"];
  }

  get length => null;
}