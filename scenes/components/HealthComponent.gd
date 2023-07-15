extends Node
class_name HealthComponent


signal health_depleted
signal health_changed

export var max_health: float = 100

var current_health: float = 100 setget _set_current_health


func _set_current_health(new_value: float):
	current_health = new_value
	emit_signal("health_changed")
	if current_health <= 0:
		emit_signal("health_depleted")
