import 'package:animalfrenzy/knows_game_size.dart';
import 'package:animalfrenzy/mainMenu.dart';
import 'package:animalfrenzy/models/chicken_details.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flame/game.dart';

class Chicken extends SpriteAnimationComponent
    with
        KnowsGameSize,
        CollisionCallbacks,
        HasGameRef<ChickenGame>,
        KeyboardHandler {
  //Joystick

  int _health = 100;
  int get health => _health;
  late Image chickenImage;
  static bool chickenFlipped = false;
  static late SpriteAnimationComponent chicken;
  double chickenScaleFactor = 2.0;

  Player _player;
  PlayerTypes playerTypes;
  late JoystickComponent joyStick;

  final knobPaint = BasicPalette.blue.withAlpha(200).paint();
  final backGroundPaint = BasicPalette.blue.withAlpha(100).paint();

  Chicken({
    required this.joyStick,
    required this.playerTypes,
    SpriteAnimation? sprite,
    Vector2? position,
    Vector2? size,
  })  : _player = Player.getPlayerByType(playerTypes),
        super(animation: sprite, position: position, size: size);

  @override
  Future<void> onLoad() async {
    joyStick = JoystickComponent(
        knob: CircleComponent(radius: 15, paint: knobPaint),
        background: CircleComponent(radius: 50, paint: backGroundPaint),
        margin: const EdgeInsets.only(left: 150, bottom: 20));
    add(joyStick);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    bool moveLeft = joyStick.relativeDelta[0] < 0;
    bool moveRight = joyStick.relativeDelta[0] > 0;
    bool moveUp = joyStick.relativeDelta[1] < 0;
    bool moveDown = joyStick.relativeDelta[1] > 0;
    double chickenVectorX = (joyStick.relativeDelta * 300 * dt)[0];
    double chickenVectorY = (joyStick.relativeDelta * 300 * dt)[1];

    //chicken moving on x
    if ((moveLeft && chicken.x > 0) || (moveRight && chicken.x < size[0])) {
      chicken.position.add(Vector2(chickenVectorX, 0));
    }

    //chicken moving on y
    if ((moveUp && chicken.y > 0) ||
        (moveDown && chicken.y < size[1] - chicken.height)) {
      chicken.position.add(Vector2(0, chickenVectorY));
    }

    if (joyStick.relativeDelta[0] < 0 && chickenFlipped) {
      chickenFlipped = false;
      chicken.flipHorizontallyAroundCenter();
    } else if (joyStick.relativeDelta[0] > 0 && !chickenFlipped) {
      chickenFlipped = true;
      chicken.flipHorizontallyAroundCenter();
    }
  }
}
