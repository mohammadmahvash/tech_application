import 'package:tech_application/constant/api_constant.dart';

class PodcastInfoModel {
  String? id;
  String? podcastId;
  String? file;
  String? title;
  String? length;

  PodcastInfoModel(
      [this.title, this.id, this.podcastId, this.file, this.length]);

  PodcastInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    podcastId = json["podcast_id"];
    file = ApiConstant.baseHostURL + json["file"];
    title = json["title"];
    length = json["length"];
  }
}
