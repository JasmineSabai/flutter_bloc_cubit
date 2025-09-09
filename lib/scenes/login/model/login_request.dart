class LoginRequest{
  final String email;
  final String password;
  // final String deviceId;
  // final String notificationToken;

  LoginRequest({
    required this.email,
    required this.password,
    // required this.deviceId,
    // required this.notificationToken
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      // 'deviceId': deviceId,
      // 'notificationToken': notificationToken
    };
  }
}