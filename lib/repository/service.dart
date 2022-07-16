import 'dart:convert';
import 'dart:io';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/repository/models/diets.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/repository/models/result_error.dart';
import 'package:game_app_training/repository/session.dart';

import 'models/user.dart';
import 'models/places.dart';

import 'package:http/http.dart' as http;
import 'package:jsonrpc2/jsonrpc2.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
// import 'package:infogames/repository/models/model_barrel.dart';
// import 'package:infogames/repository/models/result_error.dart';

class HttpServerProxy extends ServerProxyBase {
  /// customHeaders, for jwts and other niceties
  Map<String, String> customHeaders;

  /// constructor. superize properly
  HttpServerProxy(url, [this.customHeaders = const <String, String>{}])
      : super(url);

  /// Return a Future with the JSON-RPC response
  @override
  Future<String> transmit(String package) async {
    /// This is HttpRequest from dart:html
    String strToUtf8Charset(String _str) {
      return Utf8Decoder().convert(_str.toString().codeUnits);
    }

    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept-Encoding': 'gzip, deflate, br',
      'Accept-Language': 'ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7'
    };

    if (customHeaders.isNotEmpty) {
      headers.addAll(customHeaders);
    }

    // Здесь можно обработать все коды ошибок.
    var resp =
        await http.post(Uri.parse(resource), body: package, headers: headers);
    var body = strToUtf8Charset(resp.body);
    if (resp.statusCode == 204 || body.isEmpty) {
      throw ErrorConnection('Упс...Что-то не так с соединением');
    } else {
      return body;
    }
  }

  // optionally, mirror remote API
  // Future echo(dynamic aThing) async {
  //   var resp = await call('echo', [aThing]);
  //   return resp;
  // }
}

/// see the documentation in [BatchServerProxyBase]
class HttpBatchServerProxy extends BatchServerProxyBase {
  @override
  dynamic proxy;

  /// constructor
  HttpBatchServerProxy(String url, [customHeaders = const <String, String>{}]) {
    proxy = HttpServerProxy(url, customHeaders);
  }
}

class GameService {
  Future<User> getToken() async {
    Map details = {'username': 'ИвановИИ', 'password': '12345678'};
    var proxy =
        HttpServerProxy('https://diet.dev41359.it-o.ru/api/auth/json_rpc/');

    final response = await proxy.call("token", details);
    // json.decode(response);
    // return response;
    return User.fromJson(
      response,
    );
  }

  Future<User> refreshAccessToken(String refreshtoken) async {
    Map details = {'refresh': refreshtoken};
    var proxy =
        HttpServerProxy('https://diet.dev41359.it-o.ru/api/auth/json_rpc/');
    final response = await proxy.call("token.refresh", details);
    //New refresh token
    return User.fromJson(
        {'refresh': refreshtoken, 'access': response['access']});
  }

  Future<String> getUserInfo() async {
    var access_token = await SessionState().token_data.getAccessToken();
    Map<String, String> token_header = {
      'Authorization': 'Bearer $access_token'
    };
    Map details = {};
    var proxy = HttpServerProxy(
        'https://diet.dev41359.it-o.ru/api/json_rpc/', token_header);
    try {
      final response = await proxy.call("get_user_info", details);
      return response[0]['uid_1c'];
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<List<Order>> getNewOrders() async {
    var access_token = await SessionState().token_data.getAccessToken();
    Map details = {};
    Map<String, String> token_header = {
      'Authorization': 'Bearer $access_token'
    };
    var proxy = HttpServerProxy(
        'https://diet.dev41359.it-o.ru/api/auth/json_rpc/', token_header);
    final response = await proxy.call("get_table_info", details);
    //убрать первый элемент
    return List<Order>.from(response.map(
      (data) => Order.fromJson(data),
    ));
  }

  Future<bool> sendOrder(order) async {
    var access_token = await SessionState().token_data.getAccessToken();

    List diets_list = [];
    for (final p in order.places) {
      for (final d in p.diets) {
        Map diet_request = {
          "user": order.user_uid,
          "customer": order.agency_uid,
          "customer_division": p.uid_1c,
          "peoples_category": "3ba6eff9-ba94-11ea-aab0-005056aeb06b",
          "diet": d.uid,
          "date_execution": order.date.date_for_request,
          "count": d.count
        };
        diets_list.add(diet_request);
      }
    }

    Map details = {'order': diets_list};
    print(details);

    return true;
    //превратить это всё в {}...
  }

  Future<List<Diets>> getDiets() async {
    var access_token = await SessionState().token_data.getAccessToken();
    Map details = {};
    Map<String, String> token_header = {
      'Authorization': 'Bearer $access_token'
    };
    var proxy = HttpServerProxy(
        'https://diet.dev41359.it-o.ru/api/auth/json_rpc/', token_header);

    final response = await proxy.call("get_diet_info", details);
    response.removeAt(0);
    return (response as List).map((it) => Diets.fromJson(it)).toList();
  }

  Future<List<Agency>> getAgencies() async {
    var access_token = await SessionState().token_data.getAccessToken();
    Map details = {};
    Map<String, String> token_header = {
      'Authorization': 'Bearer $access_token'
    };
    var proxy = HttpServerProxy(
        'https://diet.dev41359.it-o.ru/api/auth/json_rpc/', token_header);

    final response = await proxy.call("get_customer_info", details);
    response.removeAt(0);
    return (response as List).map((it) => Agency.fromJson(it)).toList();
  }

  Future<List<Places>> getPlaces(uid) async {
    var access_token = await SessionState().token_data.getAccessToken();
    Map details = {"uid_1c": uid};
    Map<String, String> token_header = {
      'Authorization': 'Bearer $access_token'
    };
    var proxy = HttpServerProxy(
        'https://diet.dev41359.it-o.ru/api/auth/json_rpc/', token_header);

    final response =
        await proxy.call("get_customer_divisions_by_customer", details);
    response.removeAt(0);
    return (response as List).map((it) => Places.fromJson(it)).toList();
  }

  // Uri getUrl({
  //   required String url,
  //   Map<String, String>? extraParameters,
  // }) {
  //   final queryParameters = <String, String>{
  //     'key': dotenv.get('GAMES_API_KEY')
  //   };
  //   if (extraParameters != null) {
  //     queryParameters.addAll(extraParameters);
  //   }

  //   return Uri.parse('$baseUrl/$url').replace(
  //     queryParameters: queryParameters,
  //   );
  // }

  // Future<Game> getToken() async {
  //   final response = await _httpClient.get(
  //     getUrl(url: 'games'),
  //   );
  //   if (response.statusCode == 200) {
  //     if (response.body.isNotEmpty) {
  //       return Game.fromJson(
  //         json.decode(response.body),
  //       );
  //     } else {
  //       throw ErrorEmptyResponse();
  //     }
  //   } else {
  //     throw ErrorGettingGames('Error getting games');
  //   }
  // }

  // Future<List<Genre>> getGenres() async {
  //   final response = await _httpClient.get(
  //     getUrl(url: 'genres'),
  //   );
  //   if (response.statusCode == 200) {
  //     if (response.body.isNotEmpty) {
  //       return List<Genre>.from(
  //         json.decode(response.body)['results'].map(
  //               (data) => Genre.fromJson(data),
  //             ),
  //       );
  //     } else {
  //       throw ErrorEmptyResponse();
  //     }
  //   } else {
  //     throw ErrorGettingGames('Error getting genres');
  //   }
  // }

  // Future<List<Result>> getGamesByCategory(int genreId) async {
  //   final response = await _httpClient.get(
  //     getUrl(
  //       url: 'games',
  //       extraParameters: {
  //         'genres': genreId.toString(),
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     if (response.body.isNotEmpty) {
  //       return List<Result>.from(
  //         json.decode(response.body)['results'].map(
  //               (data) => Result.fromJson(data),
  //             ),
  //       );
  //     } else {
  //       throw ErrorEmptyResponse();
  //     }
  //   } else {
  //     throw ErrorGettingGames('Error getting games');
  //   }
  // }
}
