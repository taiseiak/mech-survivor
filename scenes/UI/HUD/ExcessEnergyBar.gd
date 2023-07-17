extends ProgressBar


var player

func _ready():
	player = Globals.get_player_node() as Player
	if player == null:
		return

	max_value = player.next_level_up
	value = player.excess_energy

	player.connect("excess_reached", self, "_on_player_excess_reached")
	player.connect("energy_added", self, "_on_player_energy_added")


func _on_player_excess_reached():
	max_value = player.next_level_up
	value = player.excess_energy


func _on_player_energy_added():
	value = player.excess_energy
