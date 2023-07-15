class_name WeightedTable


var items: Array = []

var _item_weights: int = 0


func add_item(item, weight: int):
	items.append({"item": item, "weight": weight})
	_item_weights += weight


func take_item():
	if items.size() <= 0:
		return null

	var target_weight = int(rand_range(0, _item_weights))
	var current_weight = 0
	var current_item
	for i in items:
		current_item = i
		current_weight += i["weight"]
		if current_weight >- target_weight:
			break
	return current_item["item"]
