extends Node


export(Array, PackedScene) var enemy_scenes

var enemy_table = WeightedTable.new()

onready var timer = $Timer


func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	enemy_scenes = enemy_scenes as Array
	for i in enemy_scenes:
		enemy_table.add_item(i, 10)


func _on_timer_timeout():
	if enemy_table.items.size() <= 0:
		return

	var entities = Globals.get_entity_node()
	if entities == null:
		return

	var player = Globals.get_player_node()
	if player == null:
		return

	var enemy = enemy_table.take_item().instance()
	entities.add_child(enemy)

	# 256 is viewport size
	var spawn_location = Vector2.RIGHT * 300
	spawn_location = spawn_location.rotated(deg2rad(rand_range(-360, 360)))
	print(spawn_location)
	spawn_location += player.global_position
	enemy.global_position = spawn_location
