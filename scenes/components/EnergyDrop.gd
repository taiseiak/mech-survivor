extends Node2D


export var energy_value: float = 10

onready var energy_area_2d = $EnergyArea2D
onready var target_find_area_2d = $TargetFindArea2D
onready var flight_component = $FlightComponent


func _ready():
	energy_area_2d.connect("area_entered", self, "_on_energy_area_2d_area_entered")
	target_find_area_2d.connect("area_entered", self, "_on_target_find_area_2d_area_entered")


func _on_energy_area_2d_area_entered(area: Area2D) -> void:
	if area is HurtBoxComponent:
		var player = Globals.get_player_node() as Player
		if player == null:
			return

		player.add_energy(energy_value)
		queue_free()


func _on_target_find_area_2d_area_entered(area: Area2D) -> void:
	if area is HurtBoxComponent:
		var player = Globals.get_player_node() as Player
		if player == null:
			return
		flight_component.target = player
		flight_component.fly = true
