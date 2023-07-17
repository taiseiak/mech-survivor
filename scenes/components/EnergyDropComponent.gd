extends Node2D


export(NodePath) var health_component = null
export(float, 0.0, 1.0) var chance = 1

var _energy_drop_scene = preload("res://scenes/components/EnergyDrop.tscn")
var _health_component

func _ready():
	if health_component != null:
		_health_component = get_node(health_component) as HealthComponent
		_health_component.connect("health_depleted", self, "drop_experience")


func drop_experience():
	if rand_range(0, 1) <= chance:
		call_deferred("_create_experience")


func _create_experience():
	var entities = Globals.get_entity_node()
	if entities == null:
		return
	var energy_drop = _energy_drop_scene.instance()
	entities.add_child(energy_drop)
	energy_drop.global_position = global_position

