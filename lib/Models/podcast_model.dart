class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? image;
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
    image = json["poster"];
    categoryName = json["cat_name"];
    author = json["author"];
    view = json["view"];
    status = json["status"];
    createdAt = json["created_at"];
  }
}
//              "id": "29",
//             "title": "رادیوگیگ-عاشقتم",
//             "poster": "/Techblog/assets/upload/images/podcast/images/20221205181800.jpg",
//             "cat_name": "اخبار و مقالات",
//             "author": "ساسان صفری",
//             "view": "129",
//             "status": "0",
//             "created_at": "۱۴۰۲/۱/۱۷"