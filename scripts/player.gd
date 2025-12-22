extends CharacterBody2D
class_name Player

const IS_SERVER = true
const DEFAULT_SERVER_IP = "127.0.0.1"
const DEFAULT_PORT = 7000

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent

func _physics_process(_delta: float) -> void:
	movement_cmp.handle_movement(self, input_cmp.input_vector)

	move_and_slide()

# NETWORKING

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	if IS_SERVER:
		print(create_game())
	else:
		join_game()

func _on_peer_connected(id: int) -> void:
	print("[Player ID: " + str(id) + "] Conected")

func _on_peer_disconnected(id: int) -> void:
	print("[Player ID: " + str(id) + "] Disconnected")

func _on_connected_ok() -> void:
	print("[" + self.name + "] Conected")

func _on_connected_fail() -> void:
	print("[" + self.name + "] Failed to connect")

func _on_server_disconnected() -> void:
	print("Disconnected from server")

func join_game(address = "", port = "") -> int:
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	if port.is_empty():
		port = DEFAULT_PORT
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, port)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	return OK

func create_game(port = "", max_clients = 32) -> int:
	if port.is_empty():
		port = DEFAULT_PORT
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, max_clients)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	return OK
