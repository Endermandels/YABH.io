extends CharacterBody2D
class_name Player

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent
@export var animation_cmp: AnimationComponent

func _enter_tree() -> void:
	# Make sure client has authority over controlling the player
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	if not is_multiplayer_authority(): return

	# Each client should have its own camera
	var camera = Camera2D.new()
	add_child(camera)

func _physics_process(_delta: float) -> void:
	# Make sure only client has authority to move player
	if not is_multiplayer_authority(): return

	movement_cmp.handle_movement(self, input_cmp.input_vector)
	animation_cmp.handle_facing_direction(self)

	move_and_slide()

