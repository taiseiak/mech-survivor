extends Area2D


export var speed: float = 100
export var max_length_from_center: float = 60 setget _set_max_length_from_center
export(NodePath) var center_node_path

var desired_position = Vector2.ZERO

var _max_length_from_center_squared = 900

onready var center_node = get_node(center_node_path) as Node2D
onready var max_line = $MaxLine


func _ready():
	max_line.add_point(Vector2.ZERO)
	max_line.visible = false


func _process(delta):
	# Move towards desired position with fixed speed
	var vector_to_desired_position = desired_position - global_position
	var velocity = _get_velocity_to_position(desired_position)
	if (global_position - center_node.global_position).length_squared() >= _max_length_from_center_squared and\
			(desired_position - center_node.global_position).length_squared() >= _max_length_from_center_squared:
		var direction_to_desired_position = (desired_position - center_node.global_position).normalized()
		var new_desired_position = center_node.global_position + direction_to_desired_position\
				* max_length_from_center
		vector_to_desired_position = new_desired_position - global_position
		velocity = _get_velocity_to_position(new_desired_position)

	if (global_position - center_node.global_position).length_squared() >= _max_length_from_center_squared - 10:
		if max_line.points.size() > 1:
			max_line.remove_point(1)
		max_line.add_point(center_node.global_position - global_position)
		max_line.visible = true
	else:
		max_line.visible = false

	velocity *= delta

	if vector_to_desired_position.length_squared() > 0.05:
		var end_position = global_position + velocity
		global_position = end_position


func _get_velocity_to_position(to_position):
	var vector_to_desired_position = to_position - global_position
	var direction_to_desired_position = vector_to_desired_position.normalized()
	return direction_to_desired_position * speed


func _set_max_length_from_center(new_value: float):
	max_length_from_center = new_value
	_max_length_from_center_squared = new_value * new_value
