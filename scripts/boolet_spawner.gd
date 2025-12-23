extends MultiplayerSpawner
class_name BooletSpawner

@export var boolet_scene: PackedScene

var players: Array[Player] = []

func _process(_delta: float) -> void:
	if not multiplayer.is_server(): return
		
	for player: Player in players:
		if player.gun_handler.can_shoot:
			spawn_boolet(player.name.to_int(), player.global_position, player.gun_handler.shoot_vector)
			player.gun_handler.shoot.rpc()

func spawn_boolet(id: int, pos: Vector2, shoot_vector: Vector2) -> void:
	if not multiplayer.is_server(): return
	
	var boolet: Boolet = boolet_scene.instantiate()
	boolet.name = "Boolet_%d" % Time.get_ticks_usec() 
	boolet.set_shooter_id(id)
	boolet.shoot_vector = shoot_vector
	boolet.global_position = pos

	get_node(spawn_path).call_deferred("add_child", boolet)
