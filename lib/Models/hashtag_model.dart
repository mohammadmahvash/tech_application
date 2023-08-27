class HashtagModel {
  String? id;
  String? title;

  HashtagModel({
    required this.id,
    required this.title,
  });

  HashtagModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
  }
}
