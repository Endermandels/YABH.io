extends MultiplayerSpawner
class_name PlayerSpawner

""" Spawns players and sets up any signal connections """

@export var player_scene: PackedScene

@export_group("External Nodes")
@export var boolet_spawner: BooletSpawner

var players: Dictionary = {}

func _ready() -> void:
	multiplayer.peer_connected.connect(spawn_player)
	if multiplayer.is_server():
		spawn_player(1)

func _process(_delta: float) -> void:
	if not multiplayer.is_server(): return

	for id in players:
		var player = players[id]
		if player.stats.is_dead():
			var last_hit_by = player.stats.last_hit_by
			if last_hit_by != -1:
				player.stats.reset_last_hit_by.rpc_id(id)
				players[last_hit_by].stats.set_kills.rpc_id(last_hit_by, players[last_hit_by].stats.kills + 1)
		elif player.stats.took_dmg:
			var last_hit_by = player.stats.last_hit_by
			if last_hit_by != -1:
				player.stats.reset_took_dmg.rpc_id(id)
				players[last_hit_by].stats.play_successful_hit_sfx.rpc_id(last_hit_by)

func spawn_player(id: int) -> void:
	if not multiplayer.is_server(): return

	var player: Player = player_scene.instantiate()
	player.name = str(id)
	boolet_spawner.players.append(player)
	players[player.name.to_int()] = player

	# Add new player to the node at spawn_path
	get_node(spawn_path).call_deferred("add_child", player)
