extends Node
class_name AnimationComponent

@export_group("External Nodes")
@export var sprite: Sprite2D

func handle_facing_direction(body: CharacterBody2D) -> void:
	var ang: float = rad_to_deg(body.velocity.angle())
	if abs(ang) < 22.5:
		# right
		sprite.frame = 4
	elif abs(ang) > 157.5:
		# left
		sprite.frame = 2
	elif ang > 0 :
		if ang < 67.5:
			# down right
			sprite.frame = 5
		elif ang < 112.5:
			# down
			sprite.frame = 0 
		else:
			# down left
			sprite.frame = 1
	else:
		# anything up
		sprite.frame = 3
