extends Node
class_name GunHandler

@export_group("External Nodes")
@export var input_cmp: InputComponent

@export_group("Internal Nodes")
@export var cooldown_timer: Timer

var can_shoot: bool = false
var shoot_vector: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	if not is_multiplayer_authority(): return
	
	if input_cmp.shoot and cooldown_timer.is_stopped():
		cooldown_timer.start()
		shoot_vector = input_cmp.shoot_vector
		can_shoot = true

@rpc("any_peer", "call_local", "reliable")
func shoot() -> void:
	can_shoot = false
