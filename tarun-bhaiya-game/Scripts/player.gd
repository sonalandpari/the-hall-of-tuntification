extends CharacterBody3D

var v = Vector3()
const Sensitivity =0.15
const SPEED = 2.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		v.y -=(event.relative.x * Sensitivity)
		v.x -=(event.relative.y * Sensitivity)
		v.x = clamp(v.x,-90,90)

func _physics_process(delta: float) -> void:
	
	$Head/Camera3D.rotation_degrees.x = v.x
	rotation_degrees.y = v.y
	
	$Head/SpotLight3D.rotation_degrees.x = v.x
	rotation_degrees.y = v.y
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "bacward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide() 
