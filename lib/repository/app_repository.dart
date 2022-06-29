// import 'package:infogames/repository/models/model_barrel.dart';
import 'package:game_app_training/repository/service.dart';

import 'models/user.dart';
import 'models/places.dart';

class GameRepository {
  const GameRepository({
    required this.service,
  });
  final GameService service;
  Future<User> getToken() async => service.getToken();
  Future<Places> getPlaces(String access_token) async => service.getPlaces(access_token);
  // Future<Game> getGames() async => service.getGames();
  // Future get_all() async => true;

  // Future<List<Genre>> getGenres() async => service.getGenres();

  // Future<List<Result>> getGamesByCategory(int genreId) async =>
  //     service.getGamesByCategory(genreId);
}
