extends Node2D


signal missles_ready

export(PackedScene) var missile_scene
export var missile_count: int = 1 setget _set_missile_count

var _launch_positions: Array

onready var cooldown_timer = $CooldownTimer

func _ready():
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")


func launch(target: Node2D):
	if cooldown_timer.time_left > 0:
		return

	var entities = Globals.get_entity_node()
	if entities == null:
		return

	for i in missile_count:
		var missile = missile_scene.instance()
		call_deferred("_set_up_missile", entities, missile, target)


func _set_up_missile(entities, missile, target):
	entities.add_child(missile)
	missile.global_position = global_position + Vector2(rand_range(-10, 10), rand_range(-10, 10))
	missile.target = target


func _set_missile_count(new_value: int):
	missile_count = new_value
	var center_position
#	if new_value % 2 == 1:
#		center_position = Vector2(ciel(new_value / 2), 0)
#	else:
#		center_position = Vector2


func _on_cooldown_timer_timeout():
	emit_signal("missles_ready")
