class GetBannerModel {
  GetBannerModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<Datum> data;

  factory GetBannerModel.fromJson(Map<String, dynamic> json){
    return GetBannerModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.image,
  });

  final String? id;
  final String? image;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      image: json["image"],
    );
  }

}
