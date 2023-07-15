extends Area2D

export var immediate_damage: float = 0
export var sustained_damage: float = 0
export var sustained_damage_interval: float = 1

onready var sustained_damage_timer = $SustainedDamageTimer


func _ready():
	sustained_damage_timer.wait_time = sustained_damage_interval
	if immediate_damage > 0:
		connect("area_entered", self, "_on_area_entered")

	if sustained_damage > 0:
		sustained_damage_timer.connect("timeout", self, "_on_sustained_damage_timer_timeout")
		sustained_damage_timer.start()


func _on_area_entered(area: Area2D):
	if area is HurtBoxComponent:
		area.damage(immediate_damage)


func _on_sustained_damage_timer_timeout():
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if area is HurtBoxComponent:
			area.damage(sustained_damage)
