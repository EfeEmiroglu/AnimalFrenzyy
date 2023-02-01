import 'dart:math';

import 'package:animalfrenzy/ball.dart';
import 'package:animalfrenzy/knows_game_size.dart';
import 'package:animalfrenzy/mainMenu.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'chicken.dart';

class Enemy extends SpriteComponent
    with HasGameRef<ChickenGame>, KnowsGameSize, CollisionCallbacks {
  double speed = 250;

  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
  }

  @override
  update(double dt) {
    super.update(dt);

    position += Vector2(0, 1) * speed * dt;

    if (position.y > gameSize.y) {
      parent?.remove(this);
      gameRef.chicken.health -= 10;
      gameRef.camera.shake(duration: 0.2, intensity: 2);
      if (gameRef.chicken.health <= 0) {
        gameRef.chicken.health = 0;
      }
    }
  }

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
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is MyBall || other is Chicken) {
      removeFromParent();

      gameRef.chicken.score += 1;
    }
  }

  @override
  void onRemove() {
    super.onRemove();

    print('Removing ${this.toString()}');
  }
}
