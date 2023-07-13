extends KinematicBody2D


export(NodePath) var mouse_position_capturer_path

onready var scanner_component = $ScannerComponent
onready var mouse_position_capturer = get_node(mouse_position_capturer_path)

var direction = Vector2.ZERO


func _ready():
	mouse_position_capturer.connect("mouse_position_changed", self, "_on_mouse_position_changed")


func _process(delta):
	var vertical_action_strength =\
			Input.get_action_strength("down") - Input.get_action_strength("up")
	var horizontal_action_strength =\
			Input.get_action_strength("right") - Input.get_action_strength("left")
	direction = Vector2(horizontal_action_strength, vertical_action_strength).normalized()
	var velocity = direction * 50
	move_and_slide(velocity)


func _on_mouse_position_changed(mouse_position: Vector2):
	scanner_component.desired_position = mouse_position
