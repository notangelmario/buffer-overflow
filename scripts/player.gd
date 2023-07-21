class_name Player extends CharacterBody3D

const SPEED = 3.0
const MOUSE_SENSITIVITY = 0.005
const JUMP_VELOCITY = 3.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var pivot = $Pivot
@onready var footsteps_stream = $FootstepsStream
@onready var footsteps_timer = $FootstepsTimer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-70), deg_to_rad(70))
		
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if event.is_action_pressed("click"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	$AnimationTree.set("parameters/conditions/idle", input_dir == Vector2.ZERO)
	$AnimationTree.set("parameters/conditions/run", input_dir != Vector2.ZERO)
	
	if input_dir != Vector2.ZERO:
		if footsteps_timer.time_left <= 0:
			footsteps_stream.pitch_scale = randf_range(0.8, 1.2)
			footsteps_stream.play()
			footsteps_timer.start(0.6)

	move_and_slide()
