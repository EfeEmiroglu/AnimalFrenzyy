import 'package:animalfrenzy/ball.dart';
import 'package:animalfrenzy/enemy_manager.dart';
import 'package:animalfrenzy/knows_game_size.dart';
import 'package:animalfrenzy/models/chicken_details.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;

import 'chicken.dart';
import 'enemy.dart';

// void main() {
//   runApp(GameWidget(game: ChickenGame()));
// }

class ChickenGame extends FlameGame
    with
        HasDraggables,
        TapDetector,
        KnowsGameSize,
        HasCollisionDetection,
        CollisionCallbacks,
        HasGameRef {
  double chickenScaleFactor = 2.0;
  late Chicken chicken;
  late final JoystickComponent joyStick;
  static bool chickenFlipped = false;
  late SpriteComponent background;
  final Vector2 buttonSize = Vector2(50, 50);
  late SpriteSheet spriteSheet;
  late SpriteSheet eggImage;
  static bool shootButtonPressed = false;
  late MyBall ball;
  late EnemyManager enemyManager;
  late TextComponent playerScore;
  late TextComponent playerHealth;
  static int health = 100, score = 0;
  late TextPainter textPainter;
  TextStyle textStyle = const TextStyle(fontFamily: 'BungeeInline');
  late Offset textOffset;

  late SpriteAnimation spriteComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await images.load('shootSprite.png');
    spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('shootSprite.png'), columns: 8, rows: 6);

    await images.load('egg.png');
    eggImage = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('egg.png'), columns: 8, rows: 6);

    background = SpriteComponent()
      ..sprite = await loadSprite('pixelGrassImage.png')
      ..size = size;
    add(background);

    // Enemy enemy = Enemy(
    //     sprite: spriteSheet.getSpriteById(6),
    //     size: Vector2(64, 64),
    //     position: Vector2(0, -5));
    // add(enemy);

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backGroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joyStick = JoystickComponent(
        knob: CircleComponent(radius: 15, paint: knobPaint),
        background: CircleComponent(radius: 50, paint: backGroundPaint),
        margin: const EdgeInsets.only(left: 150, bottom: 20));
    add(joyStick);

    const playerType = PlayerTypes.chicken;
    final player = Player.getPlayerByType(playerType);

    print('2 load assets for the game');
    await images.load('chicken.png');
    spriteComponent = SpriteAnimation.fromFrameData(
        images.fromCache('chicken.png'),
        SpriteAnimationData.sequenced(
            amount: 14, stepTime: 0.2, textureSize: Vector2(32, 34)));
    chicken = Chicken(
        joyStick: joyStick,
        playerTypes: playerType,
        sprite: spriteComponent,
        size: Vector2(64, 64),
        position: Vector2(150, 500));
    add(chicken);

    enemyManager = EnemyManager(spriteSheet: spriteSheet);
    add(enemyManager);

    playerScore = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'BungeeInline',
        ),
      ),
    );
    add(playerScore);

    playerHealth = TextComponent(
      text: 'Health: 100%',
      position: Vector2(size.x - 10, 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'BungeeInline',
        ),
      ),
      anchor: Anchor.topRight,
    );
    //playerHealth.anchor = Anchor.topRight;
    add(playerHealth);
  }

  @override
  Future<void> onTapDown(TapDownInfo info) async {
    super.onTapDown(info);

    ball = MyBall(
      sprite: spriteSheet.getSpriteById(28),
      size: Vector2(64, 64),
      position: chicken.position,
    );

    ball.anchor = Anchor.center;
    add(ball);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
        Rect.fromLTWH(size.x - 110, 30, chicken.health.toDouble(), 10),
        Paint()..color = Colors.red);

    //textPainter.paint(canvas, Offset(size.x - 110, 10));
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

    //chicken.position.add(joyStick.relativeDelta * 300 * dt);

    if (chicken.isMounted) {
      playerScore.text = 'Score: ${chicken.score}';
      playerHealth.text = 'Health: ${chicken.health}%';
    }
  }

  void reset() {
    chicken.reset();
    enemyManager.reset();

    children.whereType<Enemy>().forEach((enemy) {
      enemy.removeFromParent();
    });

    children.whereType<MyBall>().forEach((bullet) {
      bullet.removeFromParent();
    });
  }
}
