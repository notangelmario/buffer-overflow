class_name Door extends Interactable

@export var locked = false
@export var open_angle = 120
@onready var door = $door

var open = false

var target_angle = 0
var rotation_speed = 2.5


func interact():
	if !locked:
		open = !open
	
func _physics_process(delta):
	if open and !locked:
		target_angle = open_angle
	else:
		target_angle = 0
		
	rotate_door(delta)

func rotate_door(delta):
	var current_angle = door.rotation.y
	var current_angle_deg = rad_to_deg(current_angle)
	
	if current_angle_deg != target_angle:
		var direction = sign(target_angle - current_angle)
		door.rotation.y += direction * rotation_speed * delta
		door.rotation.y = clampf(door.rotation.y, 0, deg_to_rad(open_angle))
		
