extends Node
class_name Stats

@export_group("Settings")
@export var max_hp: int = 50

var hp: int = max_hp
var kills: int = 0

func take_dmg(dmg: int) -> void:
    hp = clampi(hp - dmg, 0, max_hp)

func is_dead() -> bool:
    return hp <= 0

func reset() -> void:
    hp = max_hp