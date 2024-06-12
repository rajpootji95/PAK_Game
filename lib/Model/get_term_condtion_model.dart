class GetTermAndConditionModel {
  GetTermAndConditionModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final Data? data;

  factory GetTermAndConditionModel.fromJson(Map<String, dynamic> json){
    return GetTermAndConditionModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.description,
  });

  final String? id;
  final String? description;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      description: json["description"],
    );
  }

}
