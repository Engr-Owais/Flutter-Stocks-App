import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/constants_app.dart';
import 'exceptions/http_exception.dart';

class RepoStock {
  Future<dynamic> getStockData() async {
    print("CHALA");
    Completer<dynamic> completer = Completer<dynamic>();

    try {
      String url =
          "${AppConstant.endPoint}?access_key=${AppConstant.accessKey}&symbols=${AppConstant.symbol}";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        completer.complete(jsonDecode(response.body));
      } else {
        final errorMessage = HttpExceptions.fromHttpErr(response);
        completer.complete(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
    return completer.future;
  }
}
