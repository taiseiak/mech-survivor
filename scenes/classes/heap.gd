class_name Heap


var items: Array = [{"item": null, "value": -INF}]

var _size: int = 0


func size():
	return _size - 1


func insert(item, value):
	var item_dict = {"item": item, "value": value}
	if _size >= items.size():
		items.append(item_dict)
	else:
		items[_size] = item_dict
	_size += 1
	_perc_up(_size)


func _perc_up(index):
	var current_index = index
	while _parent_index(current_index) > 0:
		var parent_index = _parent_index(current_index)
		if items[parent_index]["value"] > items[current_index]["value"]:
			_swap(parent_index, current_index)
		current_index = _parent_index(current_index)


func _perc_down(index):
	pass


func _swap(a_index, b_index):
	var temp = items[b_index]
	items[b_index] = items[a_index]
	items[a_index] = temp


func _parent_index(index):
	return int((index - 1) / 2);


func _left_child(index):
	return int(2 * index)


func _right_child(index):
	return int(2 * index + 1)
