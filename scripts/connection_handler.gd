extends Node
class_name ConnectionHandler

@export_group("External Nodes")
@export var players: Node2D

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func _on_peer_connected(id: int) -> void:
	print("[Player ID: " + str(id) + "] Connected")
	
func _on_peer_disconnected(id: int) -> void:
	print("[Player ID: " + str(id) + "] Disconnected")

func _on_server_disconnected() -> void:
	print("Disconnected from server")
