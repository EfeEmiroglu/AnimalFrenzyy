import 'package:hive/hive.dart';
part 'chicken_details.g.dart';

class Player {
  final String name;
  final int cost;
  final double speed;
  final int spriteId;
  final String assetPath;
  final int level;

  const Player(
      {required this.name,
      required this.cost,
      required this.speed,
      required this.spriteId,
      required this.assetPath,
      required this.level});

  static Player getPlayerByType(PlayerTypes playerTypes) {
    return players[playerTypes] ?? players.entries.first.value;
  }

  static const Map<PlayerTypes, Player> players = {
    PlayerTypes.chicken: Player(
      name: 'Chicken',
      cost: 0,
      speed: 250,
      spriteId: 0,
      assetPath: 'assets/images/chicken.png',
      level: 1,
    ),
    PlayerTypes.bee: Player(
      name: 'Bee',
      cost: 100,
      speed: 400,
      spriteId: 1,
      assetPath: 'assets/images/bee.png',
      level: 2,
    ),
    PlayerTypes.blueBird: Player(
      name: 'Blue Bird',
      cost: 200,
      speed: 300,
      spriteId: 2,
      assetPath: 'assets/images/blueBird.png',
      level: 2,
    ),
    PlayerTypes.bunny: Player(
      name: 'Bunny',
      cost: 400,
      speed: 300,
      spriteId: 3,
      assetPath: 'assets/images/bunny.png',
      level: 3,
    ),
    PlayerTypes.chameleon: Player(
      name: 'Chameleon',
      cost: 550,
      speed: 300,
      spriteId: 4,
      assetPath: 'assets/images/chameleon.png',
      level: 3,
    ),
    PlayerTypes.duck: Player(
      name: 'Duck',
      cost: 700,
      speed: 350,
      spriteId: 5,
      assetPath: 'assets/images/duck.png',
      level: 3,
    ),
    PlayerTypes.fatBird: Player(
      name: 'Fat Bird',
      cost: 850,
      speed: 400,
      spriteId: 6,
      assetPath: 'assets/images/fatBird.png',
      level: 4,
    ),
    PlayerTypes.ghost: Player(
      name: 'Ghost',
      cost: 1000,
      speed: 450,
      spriteId: 7,
      assetPath: 'assets/images/ghost.png',
      level: 4,
    ),
  };
}

@HiveType(typeId: 1)
enum PlayerTypes {
  @HiveField(0)
  chicken,

  @HiveField(1)
  bee,

  @HiveField(2)
  blueBird,

  @HiveField(3)
  bunny,

  @HiveField(4)
  chameleon,

  @HiveField(5)
  duck,

  @HiveField(6)
  fatBird,

  @HiveField(7)
  ghost,
}
