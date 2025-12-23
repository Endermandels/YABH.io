extends MultiplayerSpawner
class_name PlayerSpawner

""" Spawns players and sets up any signal connections """

@export var player_scene: PackedScene

@export_group("External Nodes")
@export var boolet_spawner: BooletSpawner

func _ready() -> void:
	multiplayer.peer_connected.connect(spawn_player)
	if multiplayer.is_server():
		spawn_player(1)

func spawn_player(id: int) -> void:
	if not multiplayer.is_server(): return

	var player: Player = player_scene.instantiate()
	player.name = str(id)
	boolet_spawner.players.append(player)

	# Add new player to the node at spawn_path
	get_node(spawn_path).call_deferred("add_child", player)
