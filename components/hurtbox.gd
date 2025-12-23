extends Area2D
class_name Hurtbox

@export_group("External Nodes")
@export var player: Player
@export var stats: Stats

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Area2D) -> void:
	if not multiplayer.is_server(): return
	if not hitbox.name == "Hitbox" or hitbox.shooter_id == player.name.to_int(): return

	print("[" + player.name + "] hit by [" + str(hitbox.shooter_id) + "]")

	stats.take_dmg(hitbox.dmg)
	print("[" + player.name + "] has [" + str(stats.hp) + "] HP left")
