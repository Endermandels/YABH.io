extends Node2D
class_name Lobby

@export_group("Internal Nodes")
@export var host_game_button: Button
@export var join_game_button: Button
@export var ip_address_line_edit: LineEdit
@export var networking_cmp: NetworkingComponent
@export var failed_connection_label: Label
@export var connecting_label: Label

@export_group("Resources")
@export_file_path() var world_scene

func _ready() -> void:
	failed_connection_label.modulate.a = 0
	connecting_label.hide()
	host_game_button.pressed.connect(_on_host_game_button_pressed)
	join_game_button.pressed.connect(_on_join_game_button_pressed)

	# Networking
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func _on_connected_ok() -> void:
	get_tree().change_scene_to_file(world_scene)

func _on_connected_fail() -> void:
	print("[" + self.name + "] Failed to connect")
	_failed_connection()

func _on_server_disconnected() -> void:
	print("Disconnected from server")
	_failed_connection()

func _on_join_game_button_pressed() -> void:
	failed_connection_label.modulate.a = 0
	connecting_label.show()
	if networking_cmp.join_game(ip_address_line_edit.text):
		_failed_connection()

func _on_host_game_button_pressed() -> void:
	failed_connection_label.modulate.a = 0
	connecting_label.hide()
	if networking_cmp.create_game():
		_failed_connection()
		return
	get_tree().change_scene_to_file(world_scene)

func _failed_connection() -> void:
	connecting_label.hide()
	failed_connection_label.modulate.a = 1
	var tween = get_tree().create_tween()
	tween.tween_property(failed_connection_label, "modulate:a", 0, 5)
