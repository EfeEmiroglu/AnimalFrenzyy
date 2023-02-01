import 'package:animalfrenzy/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

import 'enemy.dart';

class MyBall extends SpriteComponent with CollisionCallbacks {
  double speed = 450;

  MyBall({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  // @override
  // void onMount() {
  //   super.onMount();

  //   // Adding a circular hitbox with radius as 0.4 times
  //   //  the smallest dimension of this components size.
  //   final shape = CircleHitbox.relative(
  //     0.4,
  //     parentSize: size,
  //     position: size / 2,
  //     anchor: Anchor.center,
  //   );
  //   add(shape);
  // }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   super.onCollision(intersectionPoints, other);

  //   // If the other Collidable is Enemy, remove this bullet.
  //   if (other is Enemy) {
  //     removeFromParent();
  //   }
  // }

  @override
  void update(double dt) {
    super.update(dt);

    //shoots to the sides
    // if (ChickenGame.chickenFlipped == false) {
    //   position += Vector2(-1, 0) * speed * dt;
    // } else {
    //   position += Vector2(1, 0) * speed * dt;
    // }

    position += Vector2(0, -1) * speed * dt;

    if (position.x < 0 ||
        position.x > WidgetsBinding.instance.window.physicalSize.width - 700) {
      parent?.remove(this);
    }

    if (position.y < 0) {
      parent?.remove(this);
    }
  }
}
