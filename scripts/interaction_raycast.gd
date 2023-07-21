extends RayCast3D

func _process(_delta):
	var collider = get_collider()
	
	if is_colliding() and collider is InteractableBody:
		if Input.is_action_just_pressed("interact"):
			collider.interact()
