// import 'package:infogames/repository/models/model_barrel.dart';
import 'package:game_app_training/repository/models/agency.dart';
import 'package:game_app_training/repository/models/dietCategories.dart';
import 'package:game_app_training/repository/models/order.dart';
import 'package:game_app_training/repository/models/diets.dart';

import 'package:game_app_training/repository/service.dart';

import 'models/user.dart';
import 'models/places.dart';

class GameRepository {
  const GameRepository({
    required this.service,
  });
  final GameService service;
  Future<User> getToken() async => service.getToken();
  Future<User> refreshAccessToken(String refresh_token) async =>
      service.refreshAccessToken(refresh_token);
  Future<String> getUserInfo() async => service.getUserInfo();

  Future<List<Order>> getOrders() async => service.getOrders();

  Future<bool> sendNewOrder(order,state) async => service.sendOrder(order,state);
  Future<List<Diets>> getDiets(agencyUid) async => service.getDiets(agencyUid);
  Future<List<CategoryDiet>> getPeopleCategory(agencyUid) async => service.getPeopleCategory(agencyUid);

  Future<List<Agency>> getAgencies() async => service.getAgencies();
  Future<List<Places>> getPlaces(uid) async => service.getPlaces(uid);

  // Future<Game> getGames() async => service.getGames();
  // Future get_all() async => true;

  // Future<List<Genre>> getGenres() async => service.getGenres();

  // Future<List<Result>> getGamesByCategory(int genreId) async =>
  //     service.getGamesByCategory(genreId);
}
