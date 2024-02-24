import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../constant.dart';

ApiBaseHelper apiBaseHelper = ApiBaseHelper();
class ApiBaseHelper {
  Future<dynamic> postAPICall(Uri url, Map param) async {
    var responseJson;
    try {
      final response = await post(url,
              body: param.length > 0 ? param : [],)
          .timeout(Duration(seconds: timeOut));

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Something went wrong, try again later');
    }
    return responseJson;
  }
  Future<dynamic> getAPICall(Uri url) async {
    var responseJson;
    try {
      final response = await get(url)
          .timeout(Duration(seconds: timeOut));

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Something went wrong, try again later');
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;
  CustomException([this._message, this._prefix]);
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
