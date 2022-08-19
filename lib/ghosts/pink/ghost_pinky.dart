import 'package:bonfire/bonfire.dart';
import 'ghost_pinky_sprite.dart';

class PinkyGhost extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement {
  PinkyGhost(Vector2 position)
      : super(
          position: position,
          animation: PinkyGhostSprite.simpleDirectionAnimation,
          size: Vector2(25, 25),
          life: 100,
          speed: 80,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.circle(radius: 4, align: Vector2(10, 10)),
        ],
      ),
    );
  }

  //Criando a lógica para o fantasma movimentar sozinho pelo mapa e quando perceber o player, ir em direção a ele
  @override
  void update(double dt) {
    if (true) {
      seePlayer(
        observed: (player) {
          seeAndMoveToPlayer(
            closePlayer: (player) {
              simpleAttackMelee(
                interval: 0,
                damage: 100,
                size: Vector2(23, 23),
                direction: lastDirection,
                withPush: false,
              );
            },
            radiusVision: 10 * 10,
          );
        },
        notObserved: () {
          runRandomMovement(dt,
              speed: 65,
              maxDistance: 400,
              minDistance: 200,
              timeKeepStopped: 0,
              runOnlyVisibleInCamera: true);
        },
        radiusVision: 10 * 10,
      );
    }

    super.update(dt);
  }
}
