extends Node
class_name DespawnComponent

@export_group("External Nodes")
@export var to_despawn: Node

@export_group("Internal Nodes")
@export var timer: Timer

func _ready() -> void: 
    timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
    if not multiplayer.is_server(): return
    to_despawn.queue_free()