import '../dto/result.dart';

class ResponseResult {
  static final success = Result(code: "200", message: "Success");
  static final fail = Result(code: "500", message: "Fail");
  static final tokenExpired = Result(code: "401", message: "Token Expired");
}