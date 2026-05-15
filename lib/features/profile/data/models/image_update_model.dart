class ImageUpdateModel {
  final bool success;
  final ImageUpdateData? data;

  ImageUpdateModel({required this.success, this.data});

  factory ImageUpdateModel.fromJson(Map<String, dynamic> json) {
    return ImageUpdateModel(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? ImageUpdateData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data?.toJson()};
  }
}

class ImageUpdateData {
  final String? message;

  ImageUpdateData({this.message});

  factory ImageUpdateData.fromJson(Map<String, dynamic> json) {
    return ImageUpdateData(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
