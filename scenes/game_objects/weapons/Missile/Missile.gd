extends Node2D


var target: Node2D setget _set_target

onready var hit_box_component = $HitBoxComponent
onready var flight_component = $FlightComponent


func _ready():
	flight_component.connect("flight_timed_out", self, "_on_flight_timed_out")
	hit_box_component.connect("area_entered", self, "_on_hit_box_area_entered")
	if target != null:
		flight_component.target = target


func _set_target(new_value):
	target = new_value
	flight_component.target = new_value


func _on_hit_box_area_entered(area: Area2D):
	if area is HurtBoxComponent:
		hit_box_component.set_deferred("monitoring", false)
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("explode")


func _on_flight_timed_out():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("explode")
