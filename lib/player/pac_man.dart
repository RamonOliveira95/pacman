import 'package:bonfire/bonfire.dart';
import 'package:pacman_game/player/player_sprite.dart';

class PacMan extends SimplePlayer with ObjectCollision {
  PacMan(Vector2 position)
      : super(
          position: position,
          animation: PlayerSprite.simpleDirectionAnimation,
          size: Vector2(22, 22),
          life: 100,
          speed: 115,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.circle(radius: 10.0, align: Vector2(2, 2)),
        ],
      ),
    );
  }
  @override
  void update(double dt) {
    simpleAttackMelee(
      //Deixei damage em 3 para poder pegar as comidas, pois criei elas como inimigo
      damage: 3,
      size: Vector2(1, 1),
      direction: lastDirection,
      withPush: false,
    );

    super.update(dt);
  }

  @override
  void die() async {
    removeFromParent();
    final sprite = await PlayerSprite.die;
    gameRef.add(
      GameDecoration.withSprite(
        sprite: sprite.getSprite(),
        position: Vector2(
          position.x,
          position.y,
        ),
        size: Vector2.all(30),
      ),
    );
    super.die();
  }
}
