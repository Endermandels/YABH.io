extends Node
class_name Stats

@export_group("Settings")
@export var max_hp: int = 50

@export_group("External Nodes")
@export var hurt_sfx: AudioStreamPlayer2D
@export var hit_sfx: AudioStreamPlayer2D
@export var kill_sfx: AudioStreamPlayer2D
@export var death_sfx: AudioStreamPlayer2D

var hp: int = max_hp
var kills: int = 0
var last_hit_by: int = -1
var took_dmg: bool = false

func take_dmg(dmg: int) -> void:
	if is_dead(): return
	
	hp = clampi(hp - dmg, 0, max_hp)
	hurt_sfx.pitch_scale = randf_range(0.8, 1.2)
	hurt_sfx.play()

	if not is_multiplayer_authority(): return

	took_dmg = true

	if is_dead():
		took_dmg = false
		death_sfx.play()

@rpc("any_peer", "call_local", "reliable")
func reset_took_dmg() -> void:
	took_dmg = false

@rpc("any_peer", "call_local", "reliable")
func play_successful_hit_sfx() -> void:
	if not is_multiplayer_authority(): return
	if kill_sfx.playing: return

	hit_sfx.pitch_scale = randf_range(0.8, 1.2)
	hit_sfx.play()

func set_last_hit_by(id: int) -> void:
	if is_dead(): return

	last_hit_by = id

@rpc("any_peer", "call_local", "reliable")
func set_kills(num: int) -> void:
	kills = num

	if not is_multiplayer_authority(): return
	
	print("Play kill sfx")
	kill_sfx.play()

@rpc("any_peer", "call_local", "reliable")
func reset_last_hit_by() -> void:
	last_hit_by = -1

func is_dead() -> bool:
	return hp <= 0

func reset() -> void:
	if not is_multiplayer_authority(): return

	hp = max_hp
	kills = 0
	took_dmg = false
