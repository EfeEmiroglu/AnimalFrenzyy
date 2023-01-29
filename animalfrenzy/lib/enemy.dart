import 'dart:math';

import 'package:animalfrenzy/ball.dart';
import 'package:animalfrenzy/knows_game_size.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/animation.dart';

class Enemy extends SpriteAnimationComponent
    with KnowsGameSize, CollisionCallbacks {
  double speed = 250;

  Enemy({
    SpriteAnimation? animation,
    Vector2? position,
    Vector2? size,
  }) : super(animation: animation, position: position, size: size);

  @override
  update(double dt) {
    super.update(dt);

    position += Vector2(0, 1) * speed * dt;

    // if (position.y < size[1] - sprite?.image.height) {
    //   parent?.remove(this);
    // }
  }

  @override
  void onRemove() {
    super.onRemove();

    print('Removing ${this.toString()}');
  }
}
