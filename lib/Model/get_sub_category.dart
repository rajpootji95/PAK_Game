class GetSubCategoryModel {
  GetSubCategoryModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<Datum> data;

  factory GetSubCategoryModel.fromJson(Map<String, dynamic> json){
    return GetSubCategoryModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.catId,
    required this.image,
    required this.url,
    required this.status,
    required this.type,
    required this.created,
  });

  final String? id;
  final String? title;
  final String? catId;
  final String? image;
  final String? url;
  final String? status;
  final String? type;
  final DateTime? created;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      title: json["title"],
      catId: json["cat_id"],
      image: json["image"],
      url: json["url"],
      status: json["status"],
      type: json["type"],
      created: DateTime.tryParse(json["created"] ?? ""),
    );
  }

}
