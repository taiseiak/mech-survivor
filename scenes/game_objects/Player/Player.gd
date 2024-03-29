extends KinematicBody2D
class_name Player


signal player_died
signal leveled_up(level)
signal energy_added

export(NodePath) var mouse_position_capturer_path

onready var scanner_component = $ScannerComponent
onready var mouse_position_capturer = get_node(mouse_position_capturer_path)
onready var missile_launcher = $Visuals/MissileLauncher
onready var health_component = $HealthComponent as HealthComponent

var direction = Vector2.ZERO
var excess_energy: float = 0
var next_level_up: float = 10
var current_level: int = 1
var targets: Array = []


func _ready():
	mouse_position_capturer.connect("mouse_position_changed", self, "_on_mouse_position_changed")
	scanner_component.connect("area_entered", self, "_on_scanner_area_entered")
	missile_launcher.connect("missiles_ready", self, "_on_missile_launcher_missiles_ready")
	health_component.connect("health_depleted", self, "_on_health_component_health_depleted")
	health_component.connect("health_changed", self, "_on_health_component_health_changed")
	EventBus.connect("upgrade_chosen", self, "_on_upgrade_chosen")


func _process(delta):
	var vertical_action_strength =\
			Input.get_action_strength("down") - Input.get_action_strength("up")
	var horizontal_action_strength =\
			Input.get_action_strength("right") - Input.get_action_strength("left")
	direction = Vector2(horizontal_action_strength, vertical_action_strength).normalized()
	var velocity = direction * 50
	if velocity.length_squared()> 0:
		health_component.current_health -= 2 * delta
	move_and_slide(velocity)


func add_energy(energy_value):
	var healable_health = health_component.max_health - health_component.current_health
	health_component.current_health += min(energy_value, healable_health)
	var energy_after_heal = energy_value - healable_health
	if energy_after_heal > 0:
		excess_energy += energy_after_heal
		emit_signal("energy_added")
	if excess_energy >= next_level_up:
		level_up()


func level_up():
	var energy_for_next_level = excess_energy - next_level_up
	next_level_up *= 2
	excess_energy = energy_for_next_level
	current_level += 1
	emit_signal("leveled_up", current_level)


func _launch_missiles():
	_set_targets()
	if targets.size() > 0:
		missile_launcher.launch(targets)


func _set_targets():
	targets = []
	var overlapping_areas = scanner_component.get_overlapping_areas()
	for area in overlapping_areas:
		if area is HurtBoxComponent:
			# Super inefficient, but oh well.
			var length_to_area = area.global_position.distance_squared_to(global_position)
			if targets.size() == 0:
				targets.append({"target": area.owner, "length": length_to_area})
			else:
				for i in range(targets.size()):
					var target = targets[i]
					if target["length"] > length_to_area:
						targets.insert(i, {"target": area.owner, "length": length_to_area})
						break


func _on_mouse_position_changed(mouse_position: Vector2):
	scanner_component.desired_position = mouse_position


func _on_scanner_area_entered(area: Area2D):
	if area is HurtBoxComponent and missile_launcher.ready:
		_launch_missiles()


func _on_missile_launcher_missiles_ready():
	_launch_missiles()


func _on_health_component_health_depleted():
	emit_signal("player_died")


func _on_health_component_health_changed():
	EventBus.emit_signal("player_health_changed", health_component.current_health)


func _temp_energy_timeout():
	add_energy(10)


func _on_upgrade_chosen(upgrade):
	missile_launcher.missile_count *= 2
