import 'package:tech_application/constant/api_constant.dart';

class PodcastListModel {
  String? id;
  String? title;
  String? poster;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  bool? isFavorite;

  PodcastListModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
    required this.isFavorite,
  });

  PodcastListModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    poster = ApiConstant.baseHostURL + json["poster"];
    author = json["publisher"];
    view = json["view"];
    status = json["status"];
    createdAt = json["created_at"];
    isFavorite = json["isFavorite"];
  }
  }