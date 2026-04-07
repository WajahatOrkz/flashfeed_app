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

  /// Extracts a human-readable error message from the response data.
  String extractError([String fallback = 'Something went wrong']) {
    if (data is Map) {
      if (data['message'] != null) return data['message'].toString();
      if (data['error'] is List && (data['error'] as List).isNotEmpty) {
        return (data['error'] as List).join(', ');
      }
      if (data['error'] != null) return data['error'].toString();
    }
    return fallback;
  }
}