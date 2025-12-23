extends Area2D
class_name Hurtbox

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
    print("[" + self.name + "] hit by [" + area.name + "]")