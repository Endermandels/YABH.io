extends Node2D
class_name Lobby

@export_group("Internal Nodes")
@export var host_game_button: Button
@export var join_game_button: Button
@export var ip_address_line_edit: LineEdit
@export var networking_cmp: NetworkingComponent

func _ready() -> void:
	host_game_button.pressed.connect(_on_host_game_button_pressed)
	join_game_button.pressed.connect(_on_join_game_button_pressed)

func _on_join_game_button_pressed() -> void:
	networking_cmp.join_game(ip_address_line_edit.text)

func _on_host_game_button_pressed() -> void:
	networking_cmp.create_game()
