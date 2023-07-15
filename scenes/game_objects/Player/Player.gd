extends KinematicBody2D


export(NodePath) var mouse_position_capturer_path

onready var scanner_component = $ScannerComponent
onready var mouse_position_capturer = get_node(mouse_position_capturer_path)
onready var missile_launcher = $Visuals/MissileLauncher
onready var health_component = $HealthComponent

var direction = Vector2.ZERO


func _ready():
	mouse_position_capturer.connect("mouse_position_changed", self, "_on_mouse_position_changed")
	scanner_component.connect("area_entered", self, "_on_scanner_area_entered")
	missile_launcher.connect("missiles_ready", self, "_on_missile_launcher_missiles_ready")
	health_component.connect("health_depleted", self, "_on_health_component_health_depleted")
	$HealthPrintTimer.connect("timeout", self, "_on_health_print_timer_timeout")


func _process(delta):
	var vertical_action_strength =\
			Input.get_action_strength("down") - Input.get_action_strength("up")
	var horizontal_action_strength =\
			Input.get_action_strength("right") - Input.get_action_strength("left")
	direction = Vector2(horizontal_action_strength, vertical_action_strength).normalized()
	var velocity = direction * 50
	move_and_slide(velocity)


func _launch_missiles():
	var overlapping_areas = scanner_component.get_overlapping_areas()
	var targets = []
	for area in overlapping_areas:
		if area is HurtBoxComponent:
			targets.append(area)
	if targets.size() > 0:
		missile_launcher.launch(targets)


func _on_mouse_position_changed(mouse_position: Vector2):
	scanner_component.desired_position = mouse_position


func _on_scanner_area_entered(area: Area2D):
	if area is HurtBoxComponent and missile_launcher.ready:
		_launch_missiles()


func _on_missile_launcher_missiles_ready():
	_launch_missiles()


func _on_health_component_health_depleted():
	get_tree().quit()


func _on_health_print_timer_timeout():
	print(health_component.current_health)
