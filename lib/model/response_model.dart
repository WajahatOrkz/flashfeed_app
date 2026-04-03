class ResponseModel {
  int? statusCode;
  String? statusDescription;
  dynamic data;

  ResponseModel();

  ResponseModel.named({
    this.statusCode,
    this.statusDescription,
    this.data,
  });

  factory ResponseModel.fromJson(dynamic json) {
    return ResponseModel.named(
      statusCode: json?['statusCode'],
      statusDescription: json?['statusDescription'] ?? 'Success',
      data: json,
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'statusDescription': statusDescription,
        'data': data,
      };
}