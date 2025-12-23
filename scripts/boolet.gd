extends CharacterBody2D
class_name Boolet

@export_group("Internal Nodes")
@export var hitbox: Hitbox
@export var movement_cmp: MovementComponent

var shoot_vector: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
    if not multiplayer.is_server(): return

    movement_cmp.handle_movement(self, shoot_vector)

    move_and_slide()

func set_shooter_id(id: int) -> void:
    hitbox.shooter_id = id