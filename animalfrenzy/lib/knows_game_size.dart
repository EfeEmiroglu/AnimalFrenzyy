import 'package:flame/components.dart';

mixin KnowsGameSize on Component {
  late Vector2 gameSize = Vector2(380, 800);

  void onResize(Vector2 newGameSize) {
    gameSize = newGameSize;
  }
}
