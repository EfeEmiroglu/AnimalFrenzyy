import 'dart:math';

import 'package:animalfrenzy/knows_game_size.dart';
import 'package:animalfrenzy/main.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'enemy.dart';
import 'mainMenu.dart';

class EnemyManager extends Component
    with KnowsGameSize, HasGameRef<ChickenGame> {
  late Timer timer;
  SpriteSheet spriteSheet;
  Random random = Random();

  EnemyManager({required this.spriteSheet}) : super() {
    timer = Timer(1, onTick: spawnEnemy, repeat: true);
  }

  void spawnEnemy() {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(random.nextDouble() * gameSize.x, 0);

    position.clamp(
        Vector2.zero() + initialSize / 2, gameSize - initialSize / 2);

    Enemy enemy = Enemy(
        sprite: spriteSheet.getSpriteById(13),
        size: initialSize,
        position: position);

    enemy.anchor = Anchor.center;

    gameRef.add(enemy);
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }

  void reset() {
    timer.stop();
    timer.start();
  }
}
