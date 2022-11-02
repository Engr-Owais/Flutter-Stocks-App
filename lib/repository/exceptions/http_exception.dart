


import '../../constants/constants_app.dart';

class HttpExceptions implements Exception {
  HttpExceptions.fromHttpException(Exception exception) {
    message = exception.runtimeType.toString();
  }

  String message = "";

  HttpExceptions.fromHttpErr( response) {
    switch (response.statusCode) {
      case 400:
        message = response.message;
        break;
      case 401:
        message = response.message;
        break;
      case 403:
        message = response.message;
        break;
      case 404:
        message = response.message;
        break;
      case 409:
        message = response.message;
        break;
      case 422:
        message = response.message;
        break;
      case 429:
        message = response.message;
        break;
      case 500:
        message = AppConstant.someProblemErrMsg;
        break;
      default:
        message = AppConstant.someProblemErrMsg;
        break;
    }
  }

  @override
  String toString() => message;
}

class CommonResponseModel {
  CommonResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  dynamic data;

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) =>
      CommonResponseModel(
        statusCode: json["status"],
        message: json["message"],
        data: json["data"],
      );
}

