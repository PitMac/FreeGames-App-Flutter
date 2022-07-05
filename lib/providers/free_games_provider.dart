import 'package:flutter/material.dart';
import 'package:free_games_app/models/all_games_model.dart';
import 'package:free_games_app/models/game_model.dart';
import 'package:http/http.dart' as http;

class FreeGamesProvider extends ChangeNotifier {
  var url = 'https://www.freetogame.com/api/games';
  List<AllGamesResponse> _searchResults = [];
  String _selectedCategory = "anime";

  List<String> categories = <String>[
    'mmorpg',
    'shooter',
    'strategy',
    'moba',
    'racing',
    'sports',
    'social',
    'sandbox',
    'open-world',
    'survival',
    'pvp',
    'pve',
    'pixel',
    'voxel',
    'zombie',
    'turn-based',
    'first-person',
    'third-Person',
    'top-down',
    'tank',
    'space',
    'sailing',
    'side-scroller',
    'superhero',
    'permadeath',
    'card',
    'battle-royale',
    'mmo',
    'mmofps',
    'mmotps',
    '3d',
    '2d',
    'anime',
    'fantasy',
    'sci-fi',
    'fighting',
    'action-rpg',
    'action',
    'military',
    'martial-arts',
    'flight',
    'low-spec',
    'tower-defense',
    'horror',
    'mmorts'
  ];

  String? get selectedCategory => _selectedCategory;

  List<AllGamesResponse> get searchResults => _searchResults;

  void setSelectedCategory(dynamic value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void searchResult(query, List<AllGamesResponse> results) {
    _searchResults = results.where((game) {
      final gameTitle = game.title.toLowerCase();
      final input = query.toLowerCase();
      return gameTitle.contains(input);
    }).toList();
    notifyListeners();
  }

  Future<List<AllGamesResponse>> getAllGames(String? category) async {
    dynamic response;
    if (category == null) {
      response = await http.get(Uri.parse(url));
    } else {
      response = await http.get(Uri.parse('$url?category=$category'));
    }
    var decodedData = allGamesResponseFromJson(response.body);
    _searchResults = [];
    return decodedData;
  }

  Future<Game> getGame(int id) async {
    var response =
        await http.get(Uri.parse('https://www.freetogame.com/api/game?id=$id'));
    var decodedData = gameFromJson(response.body);
    return decodedData;
  }
}
