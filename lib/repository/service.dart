import 'dart:convert';
import 'dart:io';
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
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};

    if (customHeaders.isNotEmpty) {
      headers.addAll(customHeaders);
    }

    // useful for debugging!
    // print(package);
    var resp =
        await http.post(Uri.parse(resource), body: package, headers: headers);

    var body = resp.body;
    if (resp.statusCode == 204 || body.isEmpty) {
      return ''; // we'll return an empty string for null response
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
    var proxy = HttpServerProxy('http://diet.web-dev.lite.grp/api/auth/json_rpc/');
    final response = await proxy.call("token", details);
    // json.decode(response);
    // return response;
    return User.fromJson(
      response,
    );
  }
  Future<Places> getPlaces(String accessToken) async {
    Map details = {};
    Map<String, String> token_header = {'Authorization':'Bearer $accessToken'};
    var proxy = HttpServerProxy('http://diet.web-dev.lite.grp/api/auth/json_rpc/',token_header);
    final response = await proxy.call("get_customer_info ", details);
    // json.decode(response);
    // return response;
    var q = 1 ;
    return Places.fromJson(
      response,
    );
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
