extends Area2D
class_name HurtBoxComponent


export(NodePath) var health_component_path

onready var health_component = get_node(health_component_path) as HealthComponent


func damage(damage_value: float):
	health_component.current_health -= damage_value
