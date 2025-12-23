extends CanvasLayer
class_name HUD

@export_group("External Nodes")
@export var stats: Stats

@export_group("Internal Nodes")
@export var kills_label: Label

func _ready() -> void:
	if not is_multiplayer_authority():
		queue_free()

func _process(_delta: float) -> void:
	if not is_multiplayer_authority(): return

	kills_label.text = "Kills: " + str(stats.kills)