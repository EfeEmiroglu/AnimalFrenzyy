import 'package:animalfrenzy/models/chicken_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

//part 'player_data.g.dart';

// This class represents all the persistent data that we
// might want to store for tracking player progress.
@HiveType(typeId: 0)
class PlayerData extends ChangeNotifier {
  static const String playerDataBox = 'PlayerDataBox';
  static const String playerDataKey = 'PlayerData';

  @HiveField(0)
  PlayerTypes playerTypes;

  @HiveField(1)
  final List<PlayerTypes> ownedPlayers;

  @HiveField(2)
  late int _highScore;
  int get highScore => _highScore;

  @HiveField(3)
  int money;

  // Keeps track of current score.
  // If game is not running, this will
  // represent score of last round.
  int _currentScore = 0;

  int get currentScore => _currentScore;

  set currentScore(int newScore) {
    _currentScore = newScore;
    // While setting currentScore to a new value
    // also make sure to update highScore.
    if (_highScore < _currentScore) {
      _highScore = _currentScore;
    }
  }

  PlayerData(
      {required this.playerTypes,
      required this.ownedPlayers,
      int highScore = 0,
      required this.money}) {
    _highScore = highScore;
  }

  PlayerData.fromMap(Map<String, dynamic> map)
      : playerTypes = map['currentPlayerType'],
        ownedPlayers = map['ownedPlayerTypes']
            .map((e) => e as PlayerTypes)
            .cast<PlayerTypes>()
            .toList(),
        _highScore = map['highScore'],
        money = map['money'];

  static Map<String, dynamic> defaultData = {
    'currentPlayerType': PlayerTypes.chicken,
    'ownedPlayerTypes': [PlayerTypes.chicken],
    'highScore': 0,
    'money': 0,
  };

  /// Returns true if given [PlayerData] is owned by player.
  bool isOwned(PlayerTypes playerTypes) {
    return ownedPlayers.contains(playerTypes);
  }

  /// Returns true if player has enough money to by given [PlayerData].
  bool canBuy(PlayerTypes spaceshipType) {
    return (money >= Player.getPlayerByType(spaceshipType).cost);
  }

  /// Returns true if player's current spaceship type is same as given [PlayerData].
  bool isEquipped(PlayerTypes spaceshipType) {
    return (this.playerTypes == spaceshipType);
  }

  /// Buys the given [SpaceshipType] if player has enough money and does not already own it.
  void buy(PlayerTypes playerTypes) {
    if (canBuy(playerTypes) && (!isOwned(playerTypes))) {
      money -= Player.getPlayerByType(playerTypes).cost;
      ownedPlayers.add(playerTypes);
      notifyListeners();

      // Saves player data to disk.
      //save();
    }
  }

  /// Sets the given [SpaceshipType] as the current spaceship type for player.
  void equip(PlayerTypes spaceshipType) {
    this.playerTypes = spaceshipType;
    notifyListeners();

    // Saves player data to disk.
    //save();
  }
}
