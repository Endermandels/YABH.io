extends Node
class_name MovementComponent

@export_group("Settings")
@export var speed: int = 100

func handle_movement(body: CharacterBody2D, dir: Vector2) -> void:
	body.velocity = body.velocity.move_toward(dir * speed, speed)
