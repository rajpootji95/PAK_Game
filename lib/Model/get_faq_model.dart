class GetFaqModel {
  GetFaqModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<Datum> data;

  factory GetFaqModel.fromJson(Map<String, dynamic> json){
    return GetFaqModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  final String? id;
  final String? question;
  final String? answer;
  final DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      question: json["question"],
      answer: json["answer"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}
