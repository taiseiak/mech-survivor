extends Node


export(Array, PackedScene) var enemy_scenes
export(int) var max_enemies = 512

var enemy_table = WeightedTable.new()
var enemy_spawn_count: int = 1
var enemy_spawn_time: float = 1

var _current_enemies = 0

onready var spawn_timer = $SpawnTimer
onready var upgrade_timer = $UpgradeTimer


func _ready():
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	upgrade_timer.connect("timeout", self, "_on_upgrade_timer_timeout")
	EventBus.connect("entity_died", self, "_on_entity_died")
	enemy_scenes = enemy_scenes as Array
	for i in enemy_scenes:
		enemy_table.add_item(i, 10)


func _on_spawn_timer_timeout():
	if enemy_table.items.size() <= 0:
		return

	var entities = Globals.get_entity_node()
	if entities == null:
		return

	var player = Globals.get_player_node()
	if player == null:
		return

	var enemy_scene = enemy_table.take_item()
	_current_enemies = get_tree().get_nodes_in_group("enemy").size()
	for i in range(enemy_spawn_count):
		if _current_enemies >= 512:
			break
		var enemy = enemy_scene.instance()
		entities.add_child(enemy)
#		_current_enemies += 1

		# 256 is viewport size
		var spawn_location = Vector2.RIGHT * 300
		spawn_location = spawn_location.rotated(deg2rad(rand_range(-360, 360)))
		spawn_location += player.global_position
		enemy.global_position = spawn_location
	print("current enemies ", _current_enemies)


func _on_upgrade_timer_timeout():
	enemy_spawn_count *= 2
	print("enemy spawn count ", enemy_spawn_count)
	print("enemy spawn time ", enemy_spawn_time)


func _on_entity_died(entity: Node2D):
	if "enemy" in entity.get_groups():
		pass
