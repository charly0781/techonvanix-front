class ApiResponse {
  final int code;
  final String message;
  final dynamic body;

  ApiResponse({required this.code, required this.message, required this.body});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      body: json['body'],
    );
  }

}
