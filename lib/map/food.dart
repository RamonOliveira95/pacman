import 'package:bonfire/bonfire.dart';
import 'package:pacman_game/map/food_sprite.dart';

class Food extends SimpleEnemy with ObjectCollision {
  @override
  bool onCollision(GameComponent component, bool active) {
    return false;
    //retornei como false para não ter colisão com os fantasmas e o player
    //Mesmo assim tive que criar a classe com colisão, pois com ela posso setar o raio da comida e assim pegar.
  }

  Food(Vector2 position)
      : super(
          position: position,
          animation: FoodSprite.simpleDirectionAnimation,
          size: Vector2(20, 20),
          life: 1,
          //life em 1 para garantir que o player conseguirá matar, pois o ataque dele é 3
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.circle(radius: 11.0),
        ],
      ),
    );
  }

  @override
  void die() {
    //Após o personagem passar por cima é retirado do mapa
    removeFromParent();
    super.die();
  }
}
