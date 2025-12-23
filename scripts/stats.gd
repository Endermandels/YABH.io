extends Node
class_name Stats

@export_group("Settings")
@export var max_hp: int = 50

@export_group("External Nodes")
@export var hurt_sfx: AudioStreamPlayer2D

var hp: int = max_hp
var kills: int = 0

func take_dmg(dmg: int) -> void:
    if is_dead(): return
    
    hp = clampi(hp - dmg, 0, max_hp)
    hurt_sfx.pitch_scale = randf_range(0.8, 1.2)
    hurt_sfx.play()

func is_dead() -> bool:
    return hp <= 0

func reset() -> void:
    hp = max_hp