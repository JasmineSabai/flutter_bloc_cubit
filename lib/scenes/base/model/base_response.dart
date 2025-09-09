class BaseResponse<T> {
  final String responseCode;
  final String responseMessage;
  final T? data;

  BaseResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data
  });

  // Factory constructor for deserialization from JSON
  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return BaseResponse(
      responseCode: json['responseCode'] ?? '',
      responseMessage: json['responseMessage'] ?? '',
      data: fromJsonT(json['data']),
    );
  }
}