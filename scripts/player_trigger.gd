extends Area3D

@export var node_path: NodePath
@export var method_enter: String
@export var method_exit: String

func _on_body_entered(body):
	if body is Player:
		if node_path:
			if get_node_or_null(node_path) != null:
				if get_node(node_path).has_method(method_enter):
					get_node(node_path).call(method_enter)
				else:
					print("Trigger node method doesn't exist")
			else:
				print("Trigger node doesn't exist")
		else:
			print("Trigger node undefined")
			


func _on_body_exited(body):
	if body is Player:
		if node_path:
			if get_node_or_null(node_path) != null:
				if get_node(node_path).has_method(method_exit):
					get_node(node_path).call(method_exit)
				else:
					print("Trigger node method doesn't exist")
			else:
				print("Trigger node doesn't exist")
		else:
			print("Trigger node undefined")
