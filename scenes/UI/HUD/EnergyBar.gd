extends ProgressBar


func _ready():
	var player_node = Globals.get_player_node()
	if player_node == null:
		return
	max_value = player_node.health_component.max_health
	value = player_node.health_component.max_health
	EventBus.connect("player_health_changed", self, "_on_player_health_changed")


func _on_player_health_changed(new_value):
	value = new_value
