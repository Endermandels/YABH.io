extends MultiplayerSpawner
class_name PlayerSpawner

@export var player_scene: PackedScene

func _ready() -> void:
    multiplayer.peer_connected.connect(spawn_player)
    if multiplayer.is_server():
        spawn_player(1)

func spawn_player(id: int) -> void:
    if not multiplayer.is_server(): return

    var player: Node = player_scene.instantiate()
    player.name = str(id)

    # Add new player to the node at spawn_path
    get_node(spawn_path).call_deferred("add_child", player)