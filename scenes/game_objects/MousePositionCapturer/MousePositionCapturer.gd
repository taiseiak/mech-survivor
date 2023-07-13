extends Node2D


signal mouse_position_changed(mouse_position)

export(NodePath) var camera_node_path

var _half_viewport_size: Vector2
var _previous_position: Vector2 = Vector2.ZERO

onready var camera_node = get_node(camera_node_path) as Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	_set_viewport_variables()


func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	var position_from_center = mouse_position - _half_viewport_size
	var position_in_world = (camera_node.global_position + position_from_center).ceil()
	if position_in_world.distance_squared_to(_previous_position) > 0.1:
		global_position = position_in_world
		_previous_position = position_in_world
		emit_signal("mouse_position_changed", position_in_world)


func _set_viewport_variables():
	_half_viewport_size = get_viewport_rect().size / 2


func _on_viewport_size_changed():
	_set_viewport_variables()
