// import 'package:infogames/repository/models/model_barrel.dart';
import 'package:game_app_training/repository/service.dart';

import 'models/user.dart';

class GameRepository {
  const GameRepository({
    required this.service,
  });
  final GameService service;

  // Future<Game> getGames() async => service.getGames();
  // Future get_all() async => true;

  // Future<List<Genre>> getGenres() async => service.getGenres();

  // Future<List<Result>> getGamesByCategory(int genreId) async =>
  //     service.getGamesByCategory(genreId);
}
