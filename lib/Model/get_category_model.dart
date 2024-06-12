class GetCategoryModel {
  GetCategoryModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<Datum> data;

  factory GetCategoryModel.fromJson(Map<String, dynamic> json){
    return GetCategoryModel(
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
    required this.image,
    required this.status,
    required this.createdAt,
  });

  final String? id;
  final String? title;
  final String? image;
  final String? status;
  final DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}
