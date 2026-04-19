extends RayCast3D

@onready var prompt_door=$"../../door_prompt"
@onready var prompt_pickabe=$"../../pickup_prompt"

func _ready() -> void:
	prompt_door.visible = false
	prompt_pickabe.visible = false

func _physics_process(delta: float) -> void:
	if is_colliding():
		var hit=get_collider()
		if hit.name == "door_body":
			prompt_door.visible=true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
		elif hit.is_class("pickables"):
			prompt_pickabe.visible=true
	else:
		prompt_door.visible=false
		prompt_pickabe.visible=false
