class GetProfileModel {
  GetProfileModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final Data? data;

  factory GetProfileModel.fromJson(Map<String, dynamic> json){
    return GetProfileModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.emailId,
    required this.mobile,
    required this.password,
    required this.otp,
  });

  final String? id;
  final String? username;
  final String? profileImage;
  final String? emailId;
  final String? mobile;
  final String? password;
  final String? otp;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      username: json["username"],
      profileImage: json["profile_image"],
      emailId: json["email_id"],
      mobile: json["mobile"],
      password: json["password"],
      otp: json["otp"],
    );
  }

}
