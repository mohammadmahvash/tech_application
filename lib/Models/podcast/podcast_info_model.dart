class PodcastInfoModel {
  String? id;
  String? podcastId;
  String? file;
  String? title;
  String? length;

  PodcastInfoModel(
      [this.id, this.podcastId, this.file, this.title, this.length]);

  PodcastInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    podcastId = json["podcast_id"];
    file = json["file"];
    title = json["title"];
    length = json["length"];
  }
}
