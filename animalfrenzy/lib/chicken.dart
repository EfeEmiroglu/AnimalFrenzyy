import 'package:animalfrenzy/knows_game_size.dart';
import 'package:animalfrenzy/mainMenu.dart';
import 'package:animalfrenzy/models/chicken_details.dart';
import 'package:animalfrenzy/models/player_data.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flame/game.dart';
import 'package:provider/provider.dart';

import 'enemy.dart';

class Chicken extends SpriteAnimationComponent
    with
        KnowsGameSize,
        CollisionCallbacks,
        HasGameRef<ChickenGame>,
        KeyboardHandler {
  //Joystick

  int health = 100;
  //int get health => _health;
  int score = 0;
  late Image chickenImage;
  static bool chickenFlipped = false;
  late SpriteAnimationComponent chicken;
  double chickenScaleFactor = 2.0;

  late PlayerData _playerData;

  Player _player;
  PlayerTypes playerTypes;
  late JoystickComponent joyStick;

  Chicken({
    required this.joyStick,
    required this.playerTypes,
    SpriteAnimation? sprite,
    Vector2? position,
    Vector2? size,
  })  : _player = Player.getPlayerByType(playerTypes),
        super(animation: sprite, position: position, size: size);

  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.8 times
    // the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);

    _playerData = Provider.of<PlayerData>(gameRef.buildContext!, listen: false);

    //_playerData = Provider.of<PlayerData>(gameRef.buildContext!, listen: false);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // If other entity is an Enemy, reduce player's health by 10.
    if (other is Enemy) {
      // Make the camera shake, with custom intensity.
      gameRef.camera.shake(duration: 0.2, intensity: 2);

      health -= 10;
      if (health <= 0) {
        health = 0;
      }
    }
  }

  void setPlayerType(PlayerTypes playerTypes) {
    playerTypes = playerTypes;
    _player = Player.getPlayerByType(playerTypes);
    animation = gameRef.spriteAnimation;
  }

  // Resets player score, health and position. Should be called
  // while restarting and exiting the game.
  void reset() {
    score = 0;
    health = 100;
    position = gameRef.size / 2;
  }

  @override
  Future<void> onLoad() async {}

  @override
  Future<void> update(double dt) async {
    super.update(dt);
  }
}
