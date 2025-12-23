extends Area2D
class_name Hitbox

@export_group("Settings")
@export var dmg: int = 5

@export_group("External Nodes")
@export var boolet: Boolet
@export var sprite: Sprite2D

var shooter_id: int = 0

func _ready() -> void:
	area_entered.connect(_on_area_entered)

# Called when the hurtbox is done checking the hitbox
func done_checking() -> void:
	queue_free()

func _on_area_entered(hurtbox: Area2D) -> void:
	if not is_multiplayer_authority(): return
	if not hurtbox.name == "Hurtbox" or shooter_id == hurtbox.player.name.to_int(): return

	# Fade out and delete boolet on contact
	get_tree().create_tween().tween_property(sprite, "modulate:a", 0, 0.1).finished.connect(boolet.queue_free)
