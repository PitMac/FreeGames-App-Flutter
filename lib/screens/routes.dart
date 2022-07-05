import 'package:flutter/material.dart';
import 'package:free_games_app/screens/game_detail_screen.dart';
import 'package:free_games_app/screens/games_list_screen.dart';
import 'package:free_games_app/screens/home_screen.dart';

final routes = <String, WidgetBuilder>{
  '/': (BuildContext _) => const HomeScreen(),
  '/list': (BuildContext _) => const GamesListScreen(),
  '/game': (BuildContext _) => const GameDetailScreen(),
};
