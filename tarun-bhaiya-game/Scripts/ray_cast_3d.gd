extends RayCast3D

@onready var prompt_door=$"../../door_prompt"
func _ready() -> void:
	prompt_door.visible = false

func _physics_process(delta: float) -> void:
	if is_colliding():
		var hit=get_collider()
		if hit.name == "door_body":
			prompt_door.visible=true
			if Input.is_action_just_pressed("interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
	else:
		prompt_door.visible=false
