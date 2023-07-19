extends Node


export(NodePath) var health_component

onready var _health_component = get_node(health_component) as HealthComponent


func _ready():
	_health_component.connect("health_depleted", self, "_on_health_component_health_depleted")


func _on_health_component_health_depleted():
	EventBus.emit_signal("entity_died", owner)
	owner.queue_free()
